unit uCreateCsv;

interface

uses Windows, Messages, SysUtils, Classes, StrUtils, Contnrs, DB, UCommon;

type
  TExportAlign  = (alLeft,alRight);
  TExportFormat = (fmNone,fmInteger,fmFloat,fmDate,fmEmpty);

  THeaderO = class(TObject)
    Text  : String;
    Size  : Integer;
    Align : TExportAlign;
    TypeFormat : TExportFormat;
    FloatFormat : String;
    cDecSep : char;
  end;

type TExportHeaderOL = class(TObjectList)
  private
    function GetItems(Index : Integer) : THeaderO;
    procedure SetItems(Index : Integer; Value : THeaderO);
  public
    bWriteHeader : Boolean;
    bAlign: Boolean;
    Separator: String;
    OldStr,NewStr: String;
    // Indique quel champ des donn�es export�es doit �tre unique. Vide si aucun.
    sChampUnique: String;
    // Indique s'il y a eu des erreurs d'unicit�.
    bErreurUnicite: Boolean;
    // Liste des lignes en erreur d'unicit�.
    sLignesDoubles: String;
    property Items [Index : Integer] : THeaderO read GetItems Write SetItems; default;
    procedure Add(sText : String;iSize : Integer = 0;eaAlign : TExportAlign = alLeft;efTypeFormat : TExportFormat = fmNone;sFormat : String = '';cDecimalSeparator : Char = '.');

    // R�cup�re le header format� pour le CSV avec s�parateur ; par d�faut     -
    function GetCsvHeader(Separator : String = ';') : String;
    function ConvertToCsv(DsDataSet: TDataSet;sFileName : String) : Boolean;

    constructor Create;
end;

implementation

{ TExportHeaderOL }

procedure TExportHeaderOL.Add(sText: String; iSize: Integer; eaAlign: TExportAlign;
  efTypeFormat: TExportFormat; sFormat : String;cDecimalSeparator : char);
var
  Header : THeaderO;
begin
  Header := THeaderO.Create;
  With Header do
  begin
    Text := sText;
    Size := iSize;
    Align := eaAlign;
    TypeFormat := efTypeFormat;
    FloatFormat := sFormat;
    cDecSep := cDecimalSeparator;
  end;

  Inherited Add(Header);
end;

function TExportHeaderOL.ConvertToCsv(DsDataSet: TDataSet; sFileName: String) : Boolean;
var
  i, j, iNbLignes: Integer;
  sField, sValeurChamp: String;
  FormatSet: TFormatSettings;
  sLigne: AnsiString;
  lstFile: TSTringList;
  FFile: TFileStream;
  // Liste des valeurs pour le champ unique
  lstListeValeursUniques, lstListeValeursIgnorees: TStringList;
  bVerifierDoublons: Boolean;
begin
  if not DsDataSet.Active then
  begin
    LogAction('Erreur [TExportHeaderOL.ConvertToCsv]: dataset ferm� pour le fichier [' + sFileName + '] !', 3);
    Exit;
  end;

  //if DsDataSet.RecordCount > 0 then
  //begin
    FFile := TFileStream.Create(sFileName, fmCreate);

    // Si la v�rification d'unicit� sur un champ est pr�vu. On cr�er les listes.
    lstListeValeursUniques  := TStringList.Create();
    lstListeValeursIgnorees := TStringList.Create();
    iNbLignes := 0;
    bErreurUnicite := false;
    sLignesDoubles := '';
    try
      // gestion de l'ent�te (ne peut pas fonctionner avec le mode alignement)
      if bWriteHeader and not bAlign then
      begin
        sLigne := GetCsvHeader(Separator);
        sLigne := sLigne + #13#10;
        FFile.Write(sLigne[1],Length(sLigne));
      end;

      // Si la v�rification d'unicit� sur un champ est pr�vu. On v�rifie les doublons.
      bVerifierDoublons := (sChampUnique <> '');
      if bVerifierDoublons then
      begin
        DsDataSet.First();
        while not DsDataSet.Eof do
        begin
          // R�cup�re la valeur du champ
          sValeurChamp := DsDataSet.FieldByName(sChampUnique).AsString;
          
          if lstListeValeursUniques.IndexOf(sValeurChamp) = -1 then
          begin
            // La valeur n'existe pas encore. On la m�morise.      
            lstListeValeursUniques.Add(sValeurChamp);
            Inc(iNbLignes);
          end
          else
          begin
            // La valeur existe d�j�. On la marque � bloquer.
            if lstListeValeursIgnorees.IndexOfName(sValeurChamp) = -1 then
            begin
              // La valeur n'a pas encore �t� marqu�e � ignorer. On l'ajoute.
              lstListeValeursIgnorees.Values[sValeurChamp] := '1';
            end
            else
            begin
              // Si la valeur � d�j� �t� marqu�e. On l'incr�mente.
              lstListeValeursIgnorees.Values[sValeurChamp] := IntToStr(Succ(StrToInt(lstListeValeursIgnorees.Values[sValeurChamp])));
            end;
          end;

          DsDataSet.Next();
        end;
      end;

      With DsDataSet do
      Try
        First;
        while not EOF do
        begin
          // Si la v�rification d'unicit� sur un champ est pr�vu. On v�rifie si le champ courant est marqu�.
          if bVerifierDoublons then
          begin            
            if lstListeValeursIgnorees.IndexOfName(FieldByName(sChampUnique).AsString) > -1 then
            begin
              // Si le champ est marqu�. On passe directement au suivant.
              Next();
              Continue;
            end;
          end;
        
          sLigne := '';
          for i := 0 to Count - 1 do
          begin
            With Items[i] do
            begin
              // selon le type on formatte les donn�es du field
              case TypeFormat of
                fmNone:
                  begin
                    sField := Trim(StringReplace(FieldByName(Text).AsString, OldStr, NewStr, [rfReplaceAll]));
                    for j := 1 to Length(sField)-1 do
                      if sField[j]in [#1..#31] then
                        sField[j] := #32;
                  end;

                fmInteger:
                  sField := IntToStr(FieldByName(Text).AsLargeInt);

                fmFloat:
                  begin
                    FormatSet.DecimalSeparator := cDecSep;
                    sField := FormatFloat(FloatFormat,FieldByName(Text).AsFloat,FormatSet);
                  end;

                fmDate:
                  sField := FormatDateTime(FloatFormat,FieldByName(Text).AsDateTime);

                fmEmpty: sField := '';
              end;

              if bAlign and (Size <> 0) then
              begin
                case Align of
                  alLeft:
                    begin
                      sField := sField + StringOfChar(' ',Size - Length(sField));
                      sField := Copy(sField,1,Size);
                    end;

                  alRight:
                    begin
                      sField := StringOfChar(' ',Size - Length(sField)) + sField;
                      sField := Copy(sField,Length(sField) - Size,Size);
                    end;
                end;
              end;
            end;
            sLigne := sLigne + sField;

            if Separator <> '' then
              sLigne := sLigne +  Separator;
          end;
          // on supprime le dernier Separator
          if Separator <> '' then
            sLigne := Copy(sLigne,1,Length(sLigne) -1);

          // Ajout du s�parateur de lignes
          sLigne := sLigne + #13#10;
          FFile.Write(sLigne[1],Length(sLigne));

          Next;
        end;

        if lstListeValeursIgnorees.Count > 0 then
        begin
          bErreurUnicite := True;
          for i := 0 to lstListeValeursIgnorees.Count - 1 do
          begin
            sLignesDoubles := sLignesDoubles + #13#10 +
              Format('Le champ unique "%0:s" a �t� trouv� %2:s fois avec la valeur "%1:s". Il n''a pas �t� export�.',
                [sChampUnique, lstListeValeursIgnorees.Names[i], lstListeValeursIgnorees.ValueFromIndex[i]]);   
          end;
        end;
      except
        on E: Exception do
          raise Exception.create('ConvertToCSV Error : ' + E.Message);
      end;
    finally
      FFile.Free;
      lstListeValeursUniques.Free();
      lstListeValeursIgnorees.Free();      
    end;
  //end;
end;

constructor TExportHeaderOL.Create;
begin
  Inherited Create;
  bWriteHeader := False;
  bAlign := True;
  Separator := '';
  sChampUnique := '';
  bErreurUnicite := False;
  sLignesDoubles := '';
end;

function TExportHeaderOL.GetCsvHeader(Separator: String): String;
var
  i : integer;
begin
  Result := '';
  if Count > 0 then
  begin
    for i := 0 to Count - 1 do
    begin
      Result := Result + Items[i].Text;
      if Separator <> '' then
        Result := Result + Separator;
    end;
    if Separator <> '' then
      Result := Copy(Result,1,Length(Result) -1);
  end;
end;

function TExportHeaderOL.GetItems(Index: Integer): THeaderO;
begin
  Result := THeaderO(Inherited GetItem(Index));
end;

procedure TExportHeaderOL.SetItems(Index: Integer; Value: THeaderO);
begin
 Inherited SetItem(Index,Value);
end;

end.
