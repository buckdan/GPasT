unit uCommand;

interface

uses
  SysUtils,
  uBMPs;

type
  TCommand = class
  private
    // G�re la particularit� des DLE (si un DLE est trouv� il faut le doubler avant l'envoi au PT)
    function ManageApduDleException(AApdu: string): string;
  protected
    FcmdClass: AnsiChar;
    FcmdInstr: AnsiChar;
    FBMPs: TBMPArray;

    // Calcule le CRC d'une commande
    procedure CRCCalc(AMessages: TBytes; var crcLowByte, crcHighByte: Byte);

    function getLength: string; virtual; abstract;
    function getDataBlock: string; virtual; abstract;

    // Formate une chaine de caract�re pour �tre envoy� au PT
    // Utiliser pour envoyer le montant via TAuthorizationCmd
    function strAsPTString(AString: string): string;
  public
    destructor Destroy; override;

    // Retourne une chaine de caract�re lisible (par exemple pour afficher dans des logs)
    function asString: string; virtual; abstract;
    // Retourne la chaine de caract�re � envoyer au PT
    function asPTString: string;

    property cmdClass: AnsiChar read FcmdClass;
    property cmdInstr: AnsiChar read FcmdInstr;
  end;

  TCommandClass = class of TCommand;

  { Les types de ECR commande
    - ecrcmdtMaster : Qui donne le statut master au PT
    - ecrcmdtIntermediate : Les commandes de communication avec le PT
  }
  TECRCmdType = (ecrcmdtIntermediate, ecrcmdtMaster);

  TECRCommand = class(TCommand)
  private
    function getCmdType: TECRCmdType;
  protected
    FCmdType: TECRCmdType;
  public
    constructor Create(AcmdClass, AcmdInst: AnsiChar); overload;

    function asString: string; override;

    property CmdType: TECRCmdType read getCmdType;
  end;

  { Les types de PT commande
      - ptcmdtIntermediate : pour les commandes donnant des informations sur l'�tat du PT
      - ptcmdtResult : la commande contenant le r�sultat. A distinguer des [Succes & Error]
                       parce qu'elle ne termine pas la transaction
      - ptcmdtSucces : La transaction c'est fini avec succes (dans certain cas le d�tail
                       du succes est dans le commande de type "ptcmdtResult)
                       Rend le statut master au ECR
      - ptmcdtError : la transaction c'est fini avec erreur (dans certain cas le d�tail
                       de l'errreur est dans le commande de type "ptcmdtResult)
                       Rend le statut master au ECR
      - ptmcdtTimeOut : Ce n'est pas une commande envoy� par le PT mais utilis�
                        pour sp�cifier que le PT n'a pas r�pondu dans les delais (3 secondes)
                        Rend le statut master au ECR
  }
  TPTCmdType = (ptcmdtIntermediate, ptcmdtResult, ptcmdtSucces, ptcmdtError, ptcmdtTimeOut);

  TPTCommand = class(TCommand)
  private
    // G�re la particularit� des DLE (les DLE sont doubl� il faut donc en
    // supprimer un avant d'annalyser ce que le PT nous envoi)
    function ManageBytesDleException(ABytes: TBytes): TBytes;
  protected
    FBytes: TBytes;
    FCmdType: TPTCmdType;
    FSendResponse: boolean;

    function getLength: string; override;
    function getCmdType: TPTCmdType;
  public
    constructor Create(ABytes: TBytes); overload; virtual;

    function Clone: TPTCommand; virtual;

    procedure AddBytes(ABytes: TBytes); virtual;

    function asString: string; override;

    // Dans le cas ou le PT envoi les informations de la commande en plusieurs fois
    // Permet de savoir si on a tous re�u
    function WaitForInstruction: Boolean;

    { Certaine commande envoy� par le PT demande une r�ponse du ECR }
    // Savoir si on doit retourner une r�ponse
    function SendResponse: boolean;
    // La r�ponse � retourner
    function getResponseCmd: TCommand; virtual;

    property CmdType: TPTCmdType read getCmdType;
    function CmdResultCode: string; virtual;
    function CmdResultDescr: string; virtual;
  end;

  TPTCommandClass = class of TPTCommand;

  // Commandes dont les param�tres sont au format BMP
  TPTBMPCommand = class(TPTCommand)
  protected
    procedure ReadBMPBytes;

    function getBMP(ACode: string): TBMPBCD;
  public
    function asString: string; override;

    procedure AddBytes(ABytes: TBytes); override;

    function CmdResultCode: string; override;
    function CmdResultDescr: string; override;
  end;

  TZVTSendCmdEvent = procedure(Sender: TObject; ASendCmd: TECRCommand) of object;
  TZVTReceivedCmdEvent = procedure(Sender: TObject; AReceivedCmd: TPTCommand) of object;

implementation

uses
  uZVTProtocolManager;

CONST
  DLE: Byte = Ord(#16);
  STX: Byte = Ord(#2);
  ETX: Byte = Ord(#3);

{ TCommand }

function TCommand.asPTString: string;
var
  _low, _high: Byte;
  apdu, dle_apdu: string;
begin
  apdu := FcmdClass + FcmdInstr + getLength + getDataBlock;

  // G�re la particularit� des DLE (si un DLE est trouv� il faut le doubler avant l'envoi au PT)
  dle_apdu := ManageApduDleException(apdu);

  CRCCalc(TEncoding.Default.GetBytes(apdu), _low, _high);

  Result := Chr(DLE) + Chr(STX) + dle_apdu + Chr(DLE) + Chr(ETX) + AnsiChar(_low) + AnsiChar(_high);
end;

procedure TCommand.CRCCalc(AMessages: TBytes; var crcLowByte,
  crcHighByte: Byte);
var
  CRCT : array[0..255] of Integer;
  CRC, HB, LB : Integer;
  i, j : Integer;
  CRC_POLYNOM: Integer;
begin
  CRC_POLYNOM := $8408;
  crc := 0;
  for i := 0 to 255 do
  begin
    crc := i;
    for j := 1 to 8 do
    begin
      if ((crc and 1) <> 0) then
        crc := (crc shr 1) xor CRC_POLYNOM
      else
        crc := (crc shr 1);
    end;
    CRCT [ i ]  := crc;
  end;
// CRC �ber den String "Daten$" berechnen.
// Werte von CRC-Highbyte ist dann in HB, CRC-Lowbyte ist dann in LB.
  CRC := 0;

//Aggiungo l'ETX al messaggio
  setLength(AMessages, length(AMessages)+1);
  AMessages[length(AMessages)-1] := ETX;

  For i := 0 To Length(AMessages)-1 do
  begin
    HB := hi(CRC);
    LB := lo(CRC);
    CRC := CRCT[LB xor AMessages [ i ] ] xor HB;
  end;
  HB := hi(CRC);    //' CRC-High-Byte
  LB := lo(CRC);  //' CRC-Low-Byte

  crcLowByte := LB;
  crcHighByte := HB;
end;

destructor TCommand.Destroy;
var
  i: integer;
begin
  for i := 0 to Length(FBMPs) - 1 do
    FreeAndNil(FBMPs[i]);
  SetLength(FBMPs, 0);

  inherited;
end;

function TCommand.ManageApduDleException(AApdu: string): string;
var
  i: integer;
begin
  Result := '';

  // Ajout un charact�re DLE pour tous charact�re DLE trouv�
  for i := 1 to length(AApdu) do
  begin
    Result := Result + AApdu[i];
    if AApdu[i] = Chr(DLE) then
      Result := Result + Chr(DLE);
  end;
end;

function TCommand.strAsPTString(AString: string): string;
var
  i, index: integer;
  slength: integer;

  va: string;
  val: integer;
  b: byte;

  cmdBuffer: TBytes;

  ca: TCharArray;
begin
  slength := Length(AString);

  SetLength(cmdBuffer, 0);

  i := 1;
  while i < slength do
  begin
    va := Format('$%s%s', [AString[i], AString[i + 1]]);
    val := StrToInt(va);
    b := Ord(val);

    index := Length(cmdBuffer);
    SetLength(cmdBuffer, index + 1);
    cmdBuffer[index] := b;

    inc(i, 2);
  end;

  ca := TEncoding.Default.GetChars(cmdBuffer);

  Result := '';
  for I := 0 to Length(ca) - 1  do
    Result := Result + ca[i];
end;

{ TECRCommand }

function TECRCommand.asString: string;
begin
  Result := cmdClass + ' ' + cmdInstr;
end;

constructor TECRCommand.Create(AcmdClass, AcmdInst: AnsiChar);
begin
  FcmdClass := AcmdClass;
  FcmdInstr := AcmdInst;

  FCmdType := ecrcmdtIntermediate;
end;

function TECRCommand.getCmdType: TECRCmdType;
begin
  Result := FCmdType;
end;

{ TPTCommand }

procedure TPTCommand.AddBytes(ABytes: TBytes);
begin
  FBytes := FBytes + ABytes;

  if not WaitForInstruction then
    FBytes := ManageBytesDleException(FBytes);
end;

function TPTCommand.asString: string;
var
  i: integer;
  c: AnsiChar;

  val: string;
begin
  Result := '';

  for i := 0 to Length(FBytes) - 1 do
  begin
    C := AnsiChar(FBytes[i]);

    case C of
      #21: val := 'NAK';
      #16: val := 'DLE';
      #6: val := 'ACK';
      #3: val := 'ETX';
      #2: val := 'STX';
      else val := IntToHex(FBytes[i], 2);
    end;
    Result := Result + val + ' ';
  end;
end;

function TPTCommand.Clone: TPTCommand;
begin
  Result := TPTCommand.Create;

  Result.FcmdClass := FcmdClass;
  Result.FcmdInstr := FcmdInstr;

  Result.FBMPs := FBMPs;

  Result.FBytes := FBytes;
  Result.FSendResponse := FSendResponse;
end;

function TPTCommand.CmdResultCode: string;
begin
  Result := '';
end;

function TPTCommand.CmdResultDescr: string;
begin
  Result := '';
end;

constructor TPTCommand.Create(ABytes: TBytes);
begin
  inherited Create;

  { Par d�faut les PTCommand sont en status intermediaire (ptcmdtIntermediate) }
  FCmdType := ptcmdtIntermediate;
  FSendResponse := False;

  AddBytes(ABytes);

  FcmdClass := AnsiChar(FBytes[2]);
  FcmdInstr := AnsiChar(FBytes[3]);
end;

function TPTCommand.ManageBytesDleException(ABytes: TBytes): TBytes;
var
  i, index: integer;
begin
  SetLength(Result, 0);

  i := 0;
  index := 0;

  // Les caract�res DLE sont doubl�s avant envoi on en supprime un des deux � la r�ception
  while i < length(FBytes) do
  begin
    SetLength(Result, index + 1);
    Result[index] := FBytes[i];
    inc(index);
    inc(i);

    if (FBytes[i] = DLE) and (FBytes[i + 1] = DLE) then
      inc(i);
  end;
end;

function TPTCommand.SendResponse: boolean;
begin
  Result := FSendResponse;
end;

function TPTCommand.getCmdType: TPTCmdType;
begin
  Result := FCmdType;
end;

function TPTCommand.getLength: string;
begin
  // Dans le tableau de Bytes retourn� par le PT la 4eme valeurs est toujours la taille
  Result := Chr(FBytes[4]);
end;

function TPTCommand.getResponseCmd: TCommand;
begin
  Result := Nil;
end;

function TPTCommand.WaitForInstruction: Boolean;
var
  len: integer;
begin
  // Cas des r�ponses ACK et NAK
  if length(FBytes) = 1 then
  begin
    Result := False
  end
  else
  begin
    // Pour le moment pour savoir si on a toutes les donn�es on v�rifie le DLE ETX
    // fermant la structure de donn�es.
    // TODO : Dans l'id�al il faudrait aussi v�rifier que la taille attendu et r��l sont les
    // m�mes. Si on n'a pas de chance il est possible que la v�rification ci_dessous soit vrai
    // alors qu'on attend toujours des donn�es
    Result := False;
    len := Length(FBytes);
    if (FBytes[len - 3] <> ETX) or (FBytes[len - 4] <> DLE) then
      Result := True;
  end;
end;

{ TPTBMPCommand }

procedure TPTBMPCommand.AddBytes(ABytes: TBytes);
begin
  inherited AddBytes(ABytes);

  if not WaitForInstruction then
    ReadBMPBytes;
end;

function TPTBMPCommand.asString: string;
var
  i: integer;
begin
  Result := '';
  for i := 0 to length(FBMPs) - 1 do
  begin
    // Code 22 c'est le num�ro de le Carte. On ne le retourne pas pour qu'il
    // n'apparaise pas dans les logs
    if FBMPs[i].Code = '22' then
      Result := Format('%s ["%s" = ...]', [Result, FBMPs[i].Name])
    else
      Result := Format('%s ["%s" = %s]', [Result, FBMPs[i].Name, FBMPs[i].FormatedValue]);
  end;
end;

function TPTBMPCommand.CmdResultCode: string;
var
  bmp: TBMPBCD;
begin
  bmp := getBMP('27');
  if Assigned(bmp) then
    Result := bmp.Code
  else
    Result := 'ND';
end;

function TPTBMPCommand.CmdResultDescr: string;
var
  bmp: TBMPBCD;
begin
  bmp := getBMP('27');
  if Assigned(bmp) then
    Result := bmp.FormatedValue
  else
    Result := 'Not Defined';
end;

function TPTBMPCommand.getBMP(ACode: string): TBMPBCD;
var
  i: integer;
begin
  Result := Nil;
  i := 0;

  while (i < Length(FBMPs) - 1) and not Assigned(Result) do
  begin
    if FBMPs[i].Code = ACode then
      Result := FBMPs[i];
    inc(i);
  end;
end;

procedure TPTBMPCommand.ReadBMPBytes;
var
  i, len: integer;
  bmp: TBMP;
  bmpbcd: TBMPBCD;
begin
  len := Length(FBytes) - 5;

  i := 5;
  while i < len do
  begin
    // Attention la liste des BMP connus par le BMPManager n'est pas exhaustive
    // il faudra la completer
    bmp := FBMPManager.getBmp(IntToHex(FBytes[i], 2));
    if bmp.Code <> '' then
    begin
      bmpbcd := TBMPBCD.Create(bmp.Code, bmp.Name, bmp.Length, bmp.Descr, FBytes,
        i, bmp.getFormatedValueProcedure);

      SetLength(FBMPs, Length(FBMPs) + 1);
      FBMPs[Length(FBMPs) - 1] := bmpbcd;

      inc(i, bmpbcd.Length + 1);
    end
    else
    begin
      //TODO � changer pour que le read bytes ne soit appel� que pour les commandes qui
      //sont forcement "BMP structured"
      Break;
    end;
  end;
end;

end.
