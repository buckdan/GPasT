//==============================================================================
// developpez.net                                               Andnotor - 2012
//
//      TUTORIEL - Envoyer des cha�nes ou des structures par PostMessage
//
// Pour plus d'info:
// http://http://andnotor.developpez.com/tutoriels/delphi/envoyer-chaines-postmessage/
//==============================================================================
unit MessagesEx;

interface

uses Classes, Windows, SysUtils;

function  PostBufferMessage(aWnd :hWnd; aMessage :cardinal; aBuffer :PByteArray; aLen :integer) :integer;
function  PostTextMessage(aWnd :hWnd; aMessage :cardinal; aText :string) :integer;
function  PostStreamMessage(aWnd :hWnd; aMessage :cardinal; aStream :TStream) :integer;

function  GetBufferMessage(aAtom :TAtom; aBuffer :PByte; aLen :integer) :integer;
function  GetTextMessage(aAtom :TAtom) :string;
function  GetStreamMessage(aAtom :TAtom; aStream :TStream) :integer;

procedure ClearPostMessageTable;

// Mettre ClearTableOnExit � FALSE si les messages doivent persister apr�s la
// sortie du programme. Par exemple une application console qui notifie un
// r�sultat et quitte imm�diatement
var
  ClearTableOnExit :boolean = TRUE;

implementation

//------------------------------------------------------------------------------
const
  EOD      = MAXINTATOM -1;  //End Of Data ($BFFF)
  MaxBytes = (MAXBYTE -SizeOf(TAtom) -2) div 2;
  Codes    : array[0..$F] of ansichar = '0123456789ABCDEF';

//------------------------------------------------------------------------------
type
  TData = packed record
    Next  :TAtom;
    Len   :byte;
    Bytes :string[MaxBytes *2];
    Null  :ansichar; //#0
  end;

//------------------------------------------------------------------------------
var
  GlobalAtoms :array[MAXINTATOM..$FFFF] of byte;

//------------------------------------------------------------------------------
function StrToByte(aText :string; aIndex :integer) :byte; inline;
begin
  Result := ((Pos(aText[aIndex], Codes) -1) shl 4) or
            (Pos(aText[aIndex+1], Codes) -1);
end;

function ByteToStr(aByte :byte) :string; inline;
begin
  Result := Codes[aByte shr 4]
           +Codes[aByte and $F];
end;

//------------------------------------------------------------------------------
procedure ClearPostMessageTable;
var
  i :integer;

begin
  for i := Low(GlobalAtoms) to High(GlobalAtoms) do
    while GlobalAtoms[i] > 0 do
    begin
      GlobalDeleteAtom(i);
      Dec(GlobalAtoms[i]);
    end;
end;

//------------------------------------------------------------------------------
function PostBufferMessage(aWnd :hWnd; aMessage :cardinal; aBuffer :PByteArray; aLen :integer) :integer;
var
  Data  :TData;
  Atoms :array of TAtom;
  Count :integer;
  i     :integer;
begin
  Result := -1;
  ZeroMemory(@Data, SizeOf(Data));

  //La donn�e est trait�e depuis la fin => Next = EOD
  Data.Next := EOD;

  try
    //S'il n'y a pas de donn�e, envoie une cha�ne vide
    if Assigned(aBuffer) then
    begin
      //Table d'atomes n�cessaires � l'envoi de la donn�e.
      //Si une erreur survient en court de traitement, permet
      //de lib�rer les atomes d�j� cr��s.
      SetLength(Atoms, aLen div MaxBytes +1);
      Count := 0;

      //Tra�te la donn�e depuis la fin. Le faire depuis le d�but
      //nous obligerait � utiliser une table temporaire et de
      //renum�roter les <Next> dans une deuxi�me passe.
      for i := aLen -1 downto 0 do
      begin
        //Conversion byte -> caract�res
        Data.Bytes := UTF8Encode(ByteToStr(aBuffer[i])) + Data.Bytes;
        
        //Taille max atteinte => Stock la cha�ne
        if i mod MaxBytes = 0 then
        begin
          Data.Len  := Length(Data.Bytes) div 2;
          Data.Next := GlobalAddAtomA(@Data);

          //Si erreur, Next=0. Sinon ajoute l'atome � nos listes
          if Data.Next <> 0 then
          begin
            Atoms[Count] := Data.Next;
            inc(GlobalAtoms[Data.Next]);
            inc(Count);

            //Reset pour prochaine boucle
            Data.Bytes := '';
          end
          else
          begin
            Result := GetLastError;
            Exit;
          end;
        end;
      end;
    end
    else SetLength(Atoms, 0);

    //Envoi
    //if PostMessage(aWnd, aMessage, Data.Next, aLen) then
    if PostMessage(aWnd, aMessage, Data.Next, aLen) then
      Result := ERROR_SUCCESS
    else
      Result := GetLastError;

  finally
    //Lib�ration des atomes d�j� cr��s si erreur
    if Result <> ERROR_SUCCESS then
    begin
      for i := 0 to Count -1 do
      begin
        GlobalDeleteAtom(Atoms[i]);
        dec(GlobalAtoms[Atoms[i]]);
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
function PostTextMessage(aWnd :hWnd; aMessage :Cardinal; aText :string) :integer;
begin
  Result := PostBufferMessage(aWnd, aMessage, @aText[1], Length(aText) *SizeOf(Char));
end;

//------------------------------------------------------------------------------
function PostStreamMessage(aWnd :hWnd; aMessage :Cardinal; aStream :TStream) :integer;
var
  Buffer :array of byte;

begin
  SetLength(Buffer, aStream.Size);
  aStream.Position := 0;
  aStream.Read(Buffer[0], aStream.Size);

  Result := PostBufferMessage(aWnd, aMessage, @Buffer[0], aStream.Size);
end;

//------------------------------------------------------------------------------
function GetBufferMessage(aAtom :TAtom; aBuffer :PByte; aLen :integer) :integer;
var
  Data :TData;
  i    :integer;

begin
  //Result renvoit la taille de la donn�e
  Result := 0;

  //Lit tant que "End Of Data" n'est pas atteint
  while aAtom <> EOD do
    if GlobalGetAtomNameA(aAtom, @Data, SizeOf(Data)) <> 0 then
    begin
      inc(Result, Data.Len);

      //Si le buffer n'est pas sp�cifi� (nil), l'atome n'est pas supprim�
      //et la fonction sert uniquement � r�cup�rer la taille totale de la
      //donn�e en vue de l'allocation d'un buffer
      if Assigned(aBuffer) then
      begin
        //Supprime l'atome
        GlobalDeleteAtom(aAtom);
        dec(GlobalAtoms[aAtom]);

        i := 1;

        if Data.Len < aLen then
          aLen := Data.Len;

        //Converti la cha�ne en octets
        while i < aLen *2 do
        begin
          aBuffer^ := StrToByte(Data.Bytes, i);
          inc(i, 2);
          inc(aBuffer);
        end;
      end;

      //Atome suivant
      aAtom := Data.Next;
    end
    else
    begin
      Result := 0;
      Break;
    end;
end;

//------------------------------------------------------------------------------
function GetTextMessage(aAtom :TAtom) :string;
var
  Len :integer;

begin
  Len := GetBufferMessage(aAtom, nil, 0);
  SetLength(Result, Len div SizeOf(Char));
  GetBufferMessage(aAtom, @Result[1], Len);
end;

//------------------------------------------------------------------------------
function GetStreamMessage(aAtom :TAtom; aStream :TStream) :integer;
var
  Buffer :array of byte;

begin
  Result := GetBufferMessage(aAtom, nil, 0);
  SetLength(Buffer, Result);
  GetBufferMessage(aAtom, @Buffer[0], Result);

  aStream.Write(Buffer[0], Result);
end;

//------------------------------------------------------------------------------
initialization
  ZeroMemory(@GlobalAtoms, SizeOf(GlobalAtoms));

finalization
  if ClearTableOnExit then
    ClearPostMessageTable;

end.
