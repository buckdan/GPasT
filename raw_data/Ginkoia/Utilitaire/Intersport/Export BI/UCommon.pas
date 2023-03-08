UNIT UCommon;

INTERFACE

USES SysUtils,
  Classes,
  Forms,
  FileCtrl,
  StdCtrls,
  Controls,
  LMDFileGrep,
  LMDFileCtrl
{$IFDEF DEBUG}
  ,
  Dialogs
{$ENDIF}
  ;

PROCEDURE QuickSort(Liste: TStrings);
PROCEDURE LogAction(s: STRING; ANiveau: integer = 0);
PROCEDURE initLogFileName(AMemo: TMemo; AStatusLab: TLabel; ANiveau: integer = 0; Append : boolean = false);
FUNCTION GetLogFile: STRING;
FUNCTION RemChrFromStr(sChr, sStr: STRING): STRING;
PROCEDURE Progress();
PROCEDURE Sablier(b: boolean; sender: TControl);
PROCEDURE PurgeOldLogs(bDelOldLogs: boolean = False; iDelOldLogAge: integer = 60);
FUNCTION StringToFloat(s: STRING): double;
//FUNCTION StringToFloat (s: STRING) : double;
PROCEDURE gTrace(S: STRING);
PROCEDURE DelCurrentLog;
FUNCTION ArrondiMonetaire(x: double): double;
function StrEnleveAccents(const S : String) : string;


VAR
  iNbLog: integer;
  GAPPATH : String;
  GGENTMPPATH : String;
  GGENPATHFACTURE ,
  GGENPATHCDE     ,
  GGENPATHCSV     : String;
  GGENARCHCDE     : String;

IMPLEMENTATION

VAR
  sLogFile: STRING;
  gNiveauToLog: integer;
  mMemo: TMemo;
  bAppend : Boolean;
  lStatus: TLabel;
  bMemo, bStatus: boolean;
  //renseigne un m�mo et un fichier



function StrEnleveAccents(const S : String) : string;
var i:integer;
begin
 Result := S;
 i:=1;
 while i<=length(s) do
  begin
   case s[i] of '�'..'�'     : Result[i]:='A';
                '�'..'�'     : Result[i]:='a';
                '�'..'�'     : Result[i]:='E';
                '�'..'�'     : Result[i]:='e';
                '�'..'�'     : Result[i]:='I';
                '�'..'�'     : Result[i]:='i';
                '�'..'�','�' : Result[i]:='O';
                '�'..'�','�' : Result[i]:='o';
                '�'..'�'     : Result[i]:='U';
                '�'..'�'     : Result[i]:='u';
                '�'          : Result[i]:='S';
                '�'          : Result[i]:='s';
                '�'          : Result[i]:='C';
                '�'          : Result[i]:='c';
                '�'          : Result[i]:='N';
                '�'          : Result[i]:='n';
                '�'          : Result[i]:='D';
                '�','�'      : Result[i]:='Y';
                '�','�'      : Result[i]:='y';
                '�'          : Result[i]:='d';
                '�'          : Result[i]:='z';
                '�'          : Result[i]:='Z';
                '�'    :begin
                         Result[i]:='O';
                         insert('E',Result,i+1);
                         inc(i);
                        end;
                '�'    :begin
                         Result[i]:='o';
                         insert('e',Result,i+1);
                         inc(i);
                        end;
                '�'    :begin
                         Result[i]:='A';
                         insert('E',Result,i+1);
                         inc(i);
                        end;
                '�'    :begin
                         Result[i]:='a';
                         insert('e',Result,i+1);
                         inc(i);
                        end;
                     end;
   inc(i);
   end;
end;

FUNCTION StringToFloat(s: STRING): double;
VAR
  SvgDecSep: Char;
BEGIN
  SvgDecSep := DecimalSeparator;
  TRY
    // On teste avec un .
    DecimalSeparator := '.';
    Result := StrToFloat(S);
  EXCEPT
    TRY
      // On teste avec une ,
      DecimalSeparator := ',';
      Result := StrToFloat(S);
    EXCEPT
      Result := 0;
    END;
  END;
  DecimalSeparator := SvgDecSep;
END;

PROCEDURE Progress();
BEGIN
  mMemo.Lines[mMemo.Lines.Count - 1] := mMemo.Lines[mMemo.Lines.Count - 1] + '.';
  mMemo.Update;
END;

PROCEDURE LogAction(s: STRING; ANiveau: integer = 0);
// Niveau d'activation de log : 0 = Erreurs critiques, 1 = Erreurs normales, 2 = Informations, 3 = Debug
VAR
  F: TextFile;
BEGIN
  TRY
    AssignFile(F, sLogFile);
    IF NOT FileExists(sLogFile) THEN
    BEGIN
      Rewrite(F);
      CloseFile(F);
    END;
    IF ANiveau <= gNiveauToLog THEN
    BEGIN
      // Log effectu� dans le fichier
      Inc(iNbLog);

      // Se positionne � la fin du fichier
      Append(F);

      WriteLn(F, FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + S);

      CloseFile(F);
    END;

    //complete le m�mo
    IF bMemo THEN
    BEGIN
      if bAppend then
        mMemo.Lines.Add(FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + s)
      else
        mMemo.Lines.Insert(0, FormatDateTime('dd/mm/yyyy hh:mm:ss', Date + Time) + ' : ' + s);
      mMemo.Update;
    END;

    IF bStatus THEN
    BEGIN
      lStatus.Caption := s;
      lStatus.Update;
    END;

  EXCEPT
    // tantpis, pas de log
  END;
END;

PROCEDURE DelCurrentLog;
VAR
  FileToDel: TLMDFileCtrl;
BEGIN
  FileToDel := TLMDFileCtrl.Create(NIL);
  TRY
    FileToDel.Options := [ffFilesOnly, ffNoActionConfirm];
    FileToDel.FileName := sLogFile;
    IF FileExists(FileToDel.FileName) THEN
    BEGIN
      IF FileToDel.DeleteFiles(FileToDel.FileName) THEN
      BEGIN
        //
      END;
    END;
  FINALLY
    FileToDel.Free;
  END;
END;

PROCEDURE PurgeOldLogs(bDelOldLogs: boolean = False; iDelOldLogAge: integer = 60);
VAR
  LogFiles: TLMDFileGrep;
  FileToDel: TLMDFileCtrl;
  i: integer;
BEGIN
  IF bDelOldLogs THEN
  BEGIN
    LogFiles := TLMDFileGrep.Create(NIL);
    TRY
      FileToDel := TLMDFileCtrl.Create(NIL);
      TRY
        LogFiles.ThreadedSearch := False;
        LogFiles.Dirs := ExtractFilePath(Application.ExeName) + 'Logs';
        LogFiles.FileMasks := '*.*';
        LogFiles.RecurseSubDirs := false;
        LogFiles.ReturnValues := [rvDir, rvFileName];
        LogFiles.ReturnDelimiter := ';';
        LogFiles.CreatedBefore.DateTimeValue := (Now() - iDelOldLogAge);
        LogFiles.LookForDates := [lfCreateBefore];
        LogFiles.Grep;

        FileToDel.Options := [ffFilesOnly, ffNoActionConfirm];
        FOR i := 0 TO LogFiles.Files.Count - 1 DO
        BEGIN
          // R�cup le nom du dossier, sous la forme 'DossierContenant;NomDossierAnnee;'
          FileToDel.FileName := RemChrFromStr(';', LogFiles.Files[i]);
          IF FileToDel.DeleteFiles(FileToDel.FileName) THEN
          BEGIN
            LogAction('Suppression vieux log : ' + FileToDel.FileName, 0);
            // On ne compte pas ce log
            Dec(iNbLog)
          END;
        END;
      FINALLY
        FileToDel.Free;
      END;
    FINALLY
      LogFiles.Free;
    END;
  END;
END;

PROCEDURE initLogFileName(AMemo: TMemo; AStatusLab: TLabel; ANiveau: integer; Append : boolean);
// Objet de la proc�dure : initialiser les logs
// Chemin du log, m�mo de compte rendu (si non, mettre nil), Label de compte rendu (si non, mettre nil)
// Niveau d'activation de log : 0 = Erreurs critiques, 1 = Erreurs normales, 2 = Informations, 3 = Debug
BEGIN
  iNbLog := 0;

  IF AMemo <> NIL THEN
  BEGIN
    mMemo := AMemo;
    mMemo.clear;
    bMemo := True;
    bAppend := Append;
  END
  ELSE
    bMemo := False;

  IF AStatusLab <> NIL THEN
  BEGIN
    lStatus := AStatusLab;
    lStatus.Caption := 'Bienvenue dans ' + Application.Name;
    bStatus := True;
  END
  ELSE
    bStatus := False;

  // On active le log pour ce niveau et ceux plus importants
  gNiveauToLog := ANiveau;

  ForceDirectories(ExtractFilePath(Application.ExeName) + 'Logs\');
  sLogFile := ExtractFilePath(Application.ExeName) + 'Logs\' + FormatDateTime('yyyy_mm_dd', Date) + '_' + ChangeFileExt(ExtractFileName(Application.ExeName), '.log');
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

PROCEDURE gTrace(S: STRING);
BEGIN
{$IFDEF DEBUG}
  Showmessage(S);
{$ENDIF}

END;

FUNCTION ArrondiMonetaire(X: double): double;
BEGIN
  TRY
    Result := Round(X * 100) / 100;
  EXCEPT
    ON E: Exception DO
    BEGIN
      Result := 0;
    END;
  END;

END;

END.

