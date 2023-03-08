UNIT UCommon;

INTERFACE

USES SysUtils, Classes, Forms, StdCtrls, Controls, IBDataset;


PROCEDURE QuickSort(Liste: TStrings);
PROCEDURE LogAction(s: STRING);
PROCEDURE initLogFileName(AMemo: TMemo; AStatusLab: TLabel; LogActif: boolean = true);
FUNCTION GetLogFile: STRING;
FUNCTION RemChrFromStr(sChr, sStr: STRING): STRING;
PROCEDURE Progress();
PROCEDURE Sablier(b: boolean; sender: TControl);
FUNCTION QueryGetEntete(AQuery: TIBOQuery): STRING;
FUNCTION UpperAndRemoveForbiddenChars(SourceString: STRING): STRING;
PROCEDURE ActiveLog(Activer: boolean);
PROCEDURE InitForbiddenChars(sForbid: STRING; cReplace: char);
FUNCTION IsUnicolor(ACouNom: STRING) : boolean;

IMPLEMENTATION


VAR
  sLogFile: STRING;
  mMemo: TMemo;
  lStatus: TLabel;
  bLogActif: boolean;
  sForbiddenChars: STRING;
  cForbidReplaceChar: char;
  //renseigne un m�mo et un fichier

PROCEDURE Progress();
BEGIN
  IF mMemo <> NIL THEN
    mMemo.Lines[mMemo.Lines.Count - 1] := mMemo.Lines[mMemo.Lines.Count - 1] + '.';
  IF mMemo <> NIL THEN
    mMemo.Update;
END;

PROCEDURE LogAction(s: STRING);
VAR
  F: TextFile;
BEGIN
  IF bLogActif THEN
  BEGIN
    TRY
      AssignFile(F, sLogFile);
      IF NOT FileExists(sLogFile) THEN
      BEGIN
        Rewrite(F);
      END;
      // Se positionne � la fin du fichier
      Append(F);

      WriteLn(F, FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + S);

      CloseFile(F);
      //complete le m�mo
      IF mMemo <> NIL THEN
        mMemo.Lines.Insert(0, FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + s);

      IF lStatus <> NIL THEN
        lStatus.Caption := s;
      IF mMemo <> NIL THEN
        mMemo.Update;
      IF lStatus <> NIL THEN
        lStatus.Update;
    EXCEPT
      // tantpis, pas de log
    END;
  END;
END;

PROCEDURE initLogFileName(AMemo: TMemo; AStatusLab: TLabel; LogActif: boolean = true);
BEGIN
  mMemo := AMemo;

  IF mMemo <> NIL THEN
    mMemo.clear;

  lStatus := AStatusLab;
  IF lStatus <> NIL THEN
    lStatus.Caption := 'Bienvenue dans ' + Application.Name;

  sLogFile := ExtractFilePath(Application.ExeName) + 'Log\' +  FormatDateTime('yyyy_mm_dd', Date) + '_' + ChangeFileExt(ExtractFileName(Application.ExeName), '.log');

  ActiveLog(LogActif);
END;

FUNCTION GetLogFile: STRING;

BEGIN
  result := sLogFile
END;

FUNCTION RemChrFromStr(sChr, sStr: STRING): STRING;
BEGIN

  WHILE Pos(sChr, sStr) > 0 DO
  BEGIN
    delete(sStr, Pos(sChr, sStr), Length(sChr));
  END;

  result := sStr
END;


PROCEDURE QuickSort(Liste: TStrings);
// FC : Proc�dure trouv�e sur le Web, ne pas crier sur la facon de d�clarer, merci...
  PROCEDURE RappelQuickSort(Liste: TStrings; Premier, Dernier: Integer);

    {Objectif : Proc�dure triant la liste de type TStrings re�u en param�tre.
                Le trillage se fera avec le tri (Quick Sort).}

  VAR
    PremierTemp, DernierTemp: Integer;
    Milieu: STRING;

  BEGIN
    PremierTemp := Premier;
    DernierTemp := Dernier;
    Milieu := Liste.Strings[(Dernier + Premier) DIV 2];

    REPEAT
      WHILE Liste.Strings[PremierTemp] < Milieu DO Inc(PremierTemp);
      WHILE Liste.Strings[DernierTemp] > Milieu DO Dec(DernierTemp);

      IF PremierTemp <= DernierTemp THEN
      BEGIN
        Liste.ExChange(PremierTemp, DernierTemp);
        Inc(PremierTemp);
        Dec(DernierTemp);
      END;

    UNTIL PremierTemp > DernierTemp;

    IF DernierTemp > Premier THEN RappelQuickSort(Liste,
        Premier, DernierTemp);
    IF PremierTemp < Dernier THEN RappelQuickSort(Liste,
        PremierTemp, Dernier);
  END;

BEGIN
  IF Liste.Count > 0 THEN RappelQuickSort(Liste, 0, Liste.Count - 1);
END;


PROCEDURE sablier(b: boolean; sender: TControl);
BEGIN
  IF B THEN
  BEGIN
    screen.cursor := crHourGlass;
    // on d�sactive la fenetre
    sender.Enabled := false;
  END
  ELSE
  BEGIN
    screen.cursor := crDefault;
    sender.Enabled := True;
  END;
END;


FUNCTION QueryGetEntete(AQuery: TIBOQuery): STRING;
VAR
  i: integer;
  sRet: STRING;
BEGIN
  sRet := '';

  FOR i := 0 TO AQuery.FieldCount - 1 DO
  BEGIN
    IF i = 0 THEN
      sRet := AQuery.Fields[i].FieldName
    ELSE
      sRet := sRet + ';' + AQuery.Fields[i].FieldName;
  END;

  Result := sRet;
END;


PROCEDURE ActiveLog(Activer: boolean);
BEGIN
  bLogActif := Activer;
END;

PROCEDURE InitForbiddenChars(sForbid: STRING; cReplace: char);
BEGIN
  sForbiddenChars := sForbid;
  cForbidReplaceChar := cReplace;
END;

FUNCTION UpperAndRemoveForbiddenChars(SourceString: STRING): STRING;
VAR
  sTmpStr: STRING;
  i: integer;
BEGIN
  sTmpStr := SourceString;
  FOR i := 1 TO Length(sForbiddenChars) DO
  BEGIN
    sTmpStr := StringReplace(sTmpStr, sForbiddenChars[i], cForbidReplaceChar, [rfReplaceAll]);
  END;
  sTmpStr := UpperCase(sTmpStr);

  result := sTmpStr
END;

FUNCTION IsUnicolor(ACouNom: STRING) : boolean;
var
  s: string;
begin
  s := UpperCase(ACouNom);
  IF (s = '') OR (s = 'UNICOLOR') OR (s = '.') OR (s='UNI') THEN
    Result := true
  ELSE
    Result := false;
END;

END.

