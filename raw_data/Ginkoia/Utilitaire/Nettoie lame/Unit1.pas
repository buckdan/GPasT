unit Unit1;

{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, uSevenZip, Vcl.Buttons, Vcl.FileCtrl, System.INIFIles, System.StrUtils, System.Math, Vcl.Samples.Spin, System.DateUtils,
  Vcl.ExtCtrls, Winapi.ShellAPI, uLog, Vcl.Menus, Gin.Com.ThreadProc;

type
  TRepertoire = (rBatch, rExtract);
  TNiveau = (Annee, Mois, Jour);

  TMainForm = class(TForm)
    LabelRepertoire: TLabel;
    ListBoxRepertoiresSources: TListBox;
    BtnAjouterRepertoire: TBitBtn;
    FileOpenDialog: TFileOpenDialog;
    BtnRetirerRepertoire: TBitBtn;
    BtnTraitement: TBitBtn;
    GroupBoxSousRepertoires: TGroupBox;
    CheckBoxBatch: TCheckBox;
    CheckBoxExtract: TCheckBox;
    CheckBoxLOG: TCheckBox;
    CheckBoxLOGS: TCheckBox;
    LabelSousRepertoire: TLabel;
    LabelTempsEcoule: TLabel;
    LabelEtape: TLabel;
    PanelLogs: TPanel;
    Label4: TLabel;
    SpinEditNbJoursLogs: TSpinEdit;
    PanelLog: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    SpinEditNbJoursNonZippeLog: TSpinEdit;
    SpinEditNbJoursTotalLog: TSpinEdit;
    PanelBatch: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    SpinEditNbJoursNonZippeBatch: TSpinEdit;
    SpinEditNbJoursTotalBatch: TSpinEdit;
    PanelExtract: TPanel;
    Label5: TLabel;
    Label8: TLabel;
    SpinEditNbJoursNonZippeExtract: TSpinEdit;
    SpinEditNbJoursTotalExtract: TSpinEdit;
    PanelTauxCompression: TPanel;
    SpinEditTauxCompression: TSpinEdit;
    Label3: TLabel;
    TrayIcon: TTrayIcon;
    PopupMenu: TPopupMenu;
    Afficher1: TMenuItem;
    Timer: TTimer;
    BtnArreterTraitement: TBitBtn;
    TimerDuree: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure BtnAjouterRepertoireClick(Sender: TObject);
    procedure BtnRetirerRepertoireClick(Sender: TObject);
    procedure BtnTraitementClick(Sender: TObject);
    procedure TimerDureeTimer(Sender: TObject);
    procedure BtnArreterTraitementClick(Sender: TObject);
    procedure Afficher1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    _sRepertoire: String;
    _bDemarrageAutomatique, _bArreterTraitement: Boolean;
    _DebutTraitement: TDateTime;

    procedure Traitement;
    procedure RechercheSousRepertoire(const sRepertoire: String);
    procedure TraitementSousRepertoireDonnes(const sRepertoire: String; const Repertoire: TRepertoire; const Niveau: TNiveau = Annee; const nAnnee: Integer = 0; const nMois: Integer = 0);
    procedure TraitementSousRepertoireLog(const sRepertoire: String);
    procedure TraitementSousRepertoireLogs(const sRepertoire: String);
    procedure GetListeFichiers(const sRepertoire: String; out sListeFichier: String);
    function Compresser(const sRepertoire: String): Boolean;
    function SupprimerRepertoire(const sRepertoire: String): Boolean;
    procedure AjoutLog(const sLigne: String; const bNouveau: Boolean = False);

  public

  end;

const
  ERREUR_REPERTOIRE_INEXISTANT = -1;
  ERREUR_COMPRESSION_REPERTOIRE = -2;
  ERREUR_SUPPRESSION_REPERTOIRE = -3;
  ERREUR_SUPPRESSION_FICHIER_COMPRESSE = -4;
  ERREUR_NOM_REPERTOIRE_JOUR = -5;
  ERREUR_SUPPRESSION_FICHIER_LOGS = -6;
var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
{$REGION 'FormCreate'}
  procedure FormateListe(var ListeRepertoires: TStringList);
  var
    i: Integer;
  begin
    for i:=0 to Pred(ListeRepertoires.Count) do
      ListeRepertoires[i] := Copy(ListeRepertoires[i], Pos('=', ListeRepertoires[i]) + 1, Length(ListeRepertoires[i]));
  end;
{$ENDREGION}
var
  FichierINI: TIniFile;
  ListeRepertoires: TStringList;
begin
  Log.App := LeftStr(ExtractFileName(Application.ExeName), Length(ExtractFileName(Application.ExeName)) - Length(ExtractFileExt(Application.ExeName)));
  Log.Open;

  _sRepertoire := 'C:\';
  LabelRepertoire.Caption := '';
  _bDemarrageAutomatique := False;      _bArreterTraitement := False;

  // Chargement des param�tres.
  FichierINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NettoieLame.ini');
  try
    ListeRepertoires := TStringList.Create;
    try
      FichierINI.ReadSectionValues('R�pertoires sources', ListeRepertoires);
      FormateListe(ListeRepertoires);
      ListBoxRepertoiresSources.Items.AddStrings(ListeRepertoires);
    finally
      ListeRepertoires.Free;
    end;

    CheckBoxBatch.Checked := (FichierINI.ReadInteger('Sous-r�pertoires', 'BATCH', 1) = 1);
    CheckBoxExtract.Checked := (FichierINI.ReadInteger('Sous-r�pertoires', 'EXTRACT', 1) = 1);
    CheckBoxLOG.Checked := (FichierINI.ReadInteger('Sous-r�pertoires', 'LOG', 1) = 1);
    CheckBoxLOGS.Checked := (FichierINI.ReadInteger('Sous-r�pertoires', 'LOGS', 1) = 1);

    SpinEditNbJoursNonZippeBatch.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours non zipp� BATCH', 15);
    SpinEditNbJoursTotalBatch.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours total BATCH', 180);
    SpinEditNbJoursNonZippeExtract.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours non zipp� EXTRACT', 15);
    SpinEditNbJoursTotalExtract.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours total EXTRACT', 180);
    SpinEditNbJoursNonZippeLog.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours non zipp� LOG', 15);
    SpinEditNbJoursTotalLog.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours total LOG', 180);
    SpinEditNbJoursLogs.Value := FichierINI.ReadInteger('Param�tres', 'Nombre de jours LOGS', 30);
    SpinEditTauxCompression.Value := FichierINI.ReadInteger('Param�tres', 'Taux de compression', 1);
  finally
    FichierINI.Free;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  // Si d�marrage automatique.
  if(ParamCount = 1) and (UpperCase(ParamStr(1)) = '/AUTO') and (not _bDemarrageAutomatique) then
    Timer.Enabled := True;
end;

procedure TMainForm.TimerTimer(Sender: TObject);
begin
  Timer.Enabled := False;
  _bDemarrageAutomatique := True;
  Hide;

  // Traitement automatique.
  Traitement;
  Application.Terminate;
end;

procedure TMainForm.BtnAjouterRepertoireClick(Sender: TObject);
{$REGION 'BtnAjouterRepertoireClick'}
  function RepertoireParent(const sRepertoire: String): String;
  var
    nIndex: Integer;
  begin
    Result := ReverseString(sRepertoire);
    nIndex := Pos('\', Result);
    if nIndex > 0 then
      Result := Copy(Result, nIndex, Length(Result));
    Result := ReverseString(Result);
  end;
{$ENDREGION}
begin
  // Si sup�rieur � Windows XP.
  if Win32MajorVersion >= 6 then
  begin
    FileOpenDialog.DefaultFolder := _sRepertoire;
    FileOpenDialog.FileName := '';

    // Si validation.
    if FileOpenDialog.Execute then
      ListBoxRepertoiresSources.Items.Add(FileOpenDialog.FileName);
    _sRepertoire := RepertoireParent(FileOpenDialog.FileName);
  end
  else
  begin
    // Si validation.
    if SelectDirectory(' S�lectionner un r�pertoire', '', _sRepertoire, [sdNewFolder, sdShowEdit, sdShowShares, sdValidateDir]) then
      ListBoxRepertoiresSources.Items.Add(_sRepertoire);
    _sRepertoire := RepertoireParent(FileOpenDialog.FileName);
  end;
end;

procedure TMainForm.BtnRetirerRepertoireClick(Sender: TObject);
begin
  if ListBoxRepertoiresSources.ItemIndex > -1 then
    ListBoxRepertoiresSources.Items.Delete(ListBoxRepertoiresSources.ItemIndex);
end;

procedure TMainForm.BtnTraitementClick(Sender: TObject);
begin
  if ListBoxRepertoiresSources.Items.Count = 0 then
  begin
    Application.MessageBox('Attention :  il faut lister les r�pertoires � traiter !', PChar(Caption + ' - message'), MB_ICONEXCLAMATION + MB_OK);
    BtnAjouterRepertoireClick(Sender);
    Exit;
  end;

  Traitement;
end;

procedure TMainForm.TimerDureeTimer(Sender: TObject);
begin
  LabelTempsEcoule.Caption := FormatDateTime('hh:nn:ss', (Now - _DebutTraitement));
  Application.ProcessMessages;
end;

procedure TMainForm.BtnArreterTraitementClick(Sender: TObject);
begin
  _bArreterTraitement := True;
  AjoutLog('# Traitement interrompu.');
  LabelRepertoire.Caption := '# Le traitement va s''interrompre ...';
  BtnArreterTraitement.Enabled := False;
  Application.ProcessMessages;
end;

procedure TMainForm.Traitement;
{$REGION 'Traitement'}
  function GetLibelleErreur: String;
  begin
    case ExitCode of
      ERREUR_REPERTOIRE_INEXISTANT:
        Result := 'Erreur r�pertoire inexistant';
      ERREUR_COMPRESSION_REPERTOIRE:
        Result := 'Erreur lors de la compression d''un r�pertoire';
      ERREUR_SUPPRESSION_REPERTOIRE:
        Result := 'Erreur lors de la suppression d''un r�pertoire';
      ERREUR_SUPPRESSION_FICHIER_COMPRESSE:
        Result := 'Erreur lors de la suppression d''un fichier compress�';
      ERREUR_NOM_REPERTOIRE_JOUR:
        Result := 'Erreur de nom de r�pertoire jour';
      ERREUR_SUPPRESSION_FICHIER_LOGS:
        Result := 'Erreur lors de la suppression d''un fichier LOGS';
    end;
  end;
{$ENDREGION}
var
  i: Integer;
begin
  BtnAjouterRepertoire.Enabled := False;
  BtnRetirerRepertoire.Enabled := False;
  BtnTraitement.Hide;      BtnArreterTraitement.Show;      BtnArreterTraitement.Enabled := True;
  GroupBoxSousRepertoires.Enabled := False;
  LabelRepertoire.Caption := '';      LabelSousRepertoire.Show;      LabelEtape.Show;
  _bArreterTraitement := False;
  _DebutTraitement := Now;
  TimerDuree.Enabled := True;
  Screen.Cursor := crHourGlass;
  try
    AjoutLog('D�but traitement.', True);
    ExitCode := 0;

    // Parcours des r�pertoires sources � traiter.
    for i:=0 to Pred(ListBoxRepertoiresSources.Items.Count) do
    begin
      ListBoxRepertoiresSources.ItemIndex := i;
      LabelRepertoire.Caption := 'Traitement r�pertoire [ ' + ListBoxRepertoiresSources.Items[i] + ' ] ...';
      Application.ProcessMessages;

      // Si le r�pertoire existe.
      if System.SysUtils.DirectoryExists(ListBoxRepertoiresSources.Items[i]) then
      begin
        // Traitement du r�pertoire source.
        RechercheSousRepertoire(ListBoxRepertoiresSources.Items[i]);
      end
      else
      begin
        ExitCode := ERREUR_REPERTOIRE_INEXISTANT;
        AjoutLog('>> Erreur :  le r�pertoire [' + ListBoxRepertoiresSources.Items[i] + '] n''existe pas !');
      end;
    end;

    // Gestion du monitoring.
    if ExitCode = 0 then
      Log.Log(getMachineName, 'NettoieLame', '', '', 'Status', '', logInfo, True, 86400)
    else
      Log.Log(getMachineName, 'NettoieLame', '', '', 'Status', GetLibelleErreur, logError, True, 86400);
    AjoutLog('Fin traitement.');
  finally
    Screen.Cursor := crDefault;
    TimerDuree.Enabled := False;
    LabelRepertoire.Caption := IfThen(_bArreterTraitement, 'Traitement interrompu par l''utilisateur !', 'Traitement termin�.');      LabelSousRepertoire.Hide;      LabelEtape.Hide;
    BtnAjouterRepertoire.Enabled := True;
    BtnRetirerRepertoire.Enabled := True;
    BtnTraitement.Show;      BtnArreterTraitement.Hide;      BtnArreterTraitement.Enabled := True;
    GroupBoxSousRepertoires.Enabled := True;
  end;
end;

procedure TMainForm.RechercheSousRepertoire(const sRepertoire: String);
var
  sr: TSearchRec;
begin
  if FindFirst(IncludeTrailingPathDelimiter(sRepertoire) + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if _bArreterTraitement then
        Exit;

      // Si r�pertoire.
      if((sr.Attr and faDirectory) = faDirectory) and (sr.Name <> '.') and (sr.Name <> '..') then
      begin
        if(CheckBoxBatch.Checked) and (UpperCase(sr.Name) = 'BATCH') then
          TraitementSousRepertoireDonnes(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name, rBatch)
        else if(CheckBoxExtract.Checked) and (UpperCase(sr.Name) = 'EXTRACT') then
          TraitementSousRepertoireDonnes(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name, rExtract)
        else if(CheckBoxLOG.Checked) and (UpperCase(sr.Name) = 'LOG') then
          TraitementSousRepertoireLog(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name)
        else if(CheckBoxLOGS.Checked) and (UpperCase(sr.Name) = 'LOGS') then
          TraitementSousRepertoireLogs(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name)
        else
          RechercheSousRepertoire(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name);
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

procedure TMainForm.TraitementSousRepertoireDonnes(const sRepertoire: String; const Repertoire: TRepertoire; const Niveau: TNiveau; const nAnnee, nMois: Integer);
{$REGION 'TraitementSousRepertoireDonnes'}
  function RepertoireVide(const sRepertoire: String): Boolean;
  var
    sr: TSearchRec;
  begin
    Result := True;
    if FindFirst(IncludeTrailingPathDelimiter(sRepertoire) + '*.*', faAnyFile, sr) = 0 then
    begin
      repeat
        if(sr.Name <> '.') and (sr.Name <> '..') then
        begin
          Result := False;
          Break;
        end;
      until FindNext(sr) <> 0;
      FindClose(sr);
    end;
  end;
{$ENDREGION}
var
  sr: TSearchRec;
  nTmp, nNbJours: Integer;
  DateRepertoire: TDateTime;
begin
  if Niveau = Annee then
    AjoutLog('Traitement sous-r�pertoire [' + sRepertoire + ']');
  LabelSousRepertoire.Caption := '[ ' + RightStr(sRepertoire, Length(sRepertoire) - Length(ListBoxRepertoiresSources.Items[ListBoxRepertoiresSources.ItemIndex])) + ' ]';
  Application.ProcessMessages;
  nNbJours := 0;

  if FindFirst(IncludeTrailingPathDelimiter(sRepertoire) + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if _bArreterTraitement then
        Exit;

      if(sr.Name <> '.') and (sr.Name <> '..') then
      begin
        // Si r�pertoire.
        if(sr.Attr and faDirectory) = faDirectory then
        begin
          case Niveau of
            Annee:
              begin
                if TryStrToInt(sr.Name, nTmp) then
                begin
                  TraitementSousRepertoireDonnes(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name, Repertoire, Mois, nTmp);

                  // Si r�pertoire 'ann�e' vide.
                  if RepertoireVide(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                  begin
                    if RemoveDir(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                      AjoutLog('>> R�pertoire ann�e [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                    else
                    begin
                      ExitCode := ERREUR_SUPPRESSION_REPERTOIRE;
                      AjoutLog('>> �chec suppression r�pertoire ann�e [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                    end;
                  end;
                end
                else
                  AjoutLog('>> Erreur nom r�pertoire ann�e [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
              end;

            Mois:
              begin
                if TryStrToInt(sr.Name, nTmp) then
                begin
                  TraitementSousRepertoireDonnes(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name, Repertoire, Jour, nAnnee, nTmp);

                  // Si r�pertoire 'mois' vide.
                  if RepertoireVide(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                  begin
                    if RemoveDir(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                      AjoutLog('>> R�pertoire mois [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                    else
                    begin
                      ExitCode := ERREUR_SUPPRESSION_REPERTOIRE;
                      AjoutLog('>> �chec suppression r�pertoire mois [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                    end;
                  end;
                end
                else
                  AjoutLog('>> Erreur nom r�pertoire mois [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
              end;

            Jour:
              begin
                if TryStrToInt(sr.Name, nTmp) then
                begin
                  DateRepertoire := EncodeDate(nAnnee, nMois, nTmp);
                  if Repertoire = rBatch then
                    nNbJours := SpinEditNbJoursTotalBatch.Value
                  else if Repertoire = rExtract then
                    nNbJours := SpinEditNbJoursTotalExtract.Value;

                  // Si date r�pertoire ant�rieure au nombre de jours total de conservation.
                  if CompareDateTime(IncDay(DateRepertoire, nNbJours), Now) = -1 then
                  begin
                    // Suppression du r�pertoire.
                    if SupprimerRepertoire(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                      AjoutLog('>> R�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                    else
                    begin
                      ExitCode := ERREUR_SUPPRESSION_REPERTOIRE;
                      AjoutLog('>> �chec suppression r�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                    end;
                  end
                  else
                  begin
                    if Repertoire = rBatch then
                      nNbJours := SpinEditNbJoursNonZippeBatch.Value
                    else if Repertoire = rExtract then
                      nNbJours := SpinEditNbJoursNonZippeExtract.Value;

                    // Si date r�pertoire ant�rieure au nombre de jours non zipp�.
                    if CompareDateTime(IncDay(DateRepertoire, nNbJours), Now) = -1 then
                    begin
                      // Si r�pertoire compress�.
                      if Compresser(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                      begin
                        // Suppression du r�pertoire.
                        if SupprimerRepertoire(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                          AjoutLog('>> R�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                        else
                        begin
                          ExitCode := ERREUR_SUPPRESSION_REPERTOIRE;
                          AjoutLog('>> �chec suppression r�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                        end;
                      end
                      else
                      begin
                        ExitCode := ERREUR_COMPRESSION_REPERTOIRE;
                        AjoutLog('>> �chec compression r�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                      end;
                    end;
                  end;
                end
                else
                begin
                  ExitCode := ERREUR_NOM_REPERTOIRE_JOUR;
                  AjoutLog('>> Erreur nom r�pertoire jour [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                end;
              end;
          end;
        end
        else      // Fichier.
        begin
          // Si fichier zip au niveau jour.
          if(Niveau = Jour) and ((LowerCase(ExtractFileExt(sr.Name)) = '.7z') or (LowerCase(ExtractFileExt(sr.Name)) = '.zip')) then
          begin
            if TryStrToInt(LeftStr(sr.Name, Length(sr.Name) - Length(ExtractFileExt(sr.Name))), nTmp) then
            begin
              DateRepertoire := EncodeDate(nAnnee, nMois, nTmp);
              if Repertoire = rBatch then
                nNbJours := SpinEditNbJoursTotalBatch.Value
              else if Repertoire = rExtract then
                nNbJours := SpinEditNbJoursTotalExtract.Value;

              // Si date r�pertoire ant�rieure au nombre de jours total de conservation.
              if CompareDateTime(IncDay(DateRepertoire, nNbJours), Now) = -1 then
              begin
                // Suppression du fichier compress�.
                if DeleteFile(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                  AjoutLog('>> Fichier [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                else
                begin
                  ExitCode := ERREUR_SUPPRESSION_FICHIER_COMPRESSE;
                  AjoutLog('>> Erreur :  la suppression du fichier [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] a �chou� !' + #13#10 + SysErrorMessage(GetLastError));
                end;
              end;
            end
            else
            begin
              ExitCode := ERREUR_NOM_REPERTOIRE_JOUR;
              AjoutLog('>> Erreur nom r�pertoire jour [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
            end;
          end;
        end;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

procedure TMainForm.TraitementSousRepertoireLog(const sRepertoire: String);
var
  sr: TSearchRec;
  nTmp: Integer;
  DateRepertoire: TDateTime;
  sNomFichier: String;
begin
  AjoutLog('Traitement sous-r�pertoire LOG [' + sRepertoire + ']');
  LabelSousRepertoire.Caption := '[ ' + RightStr(sRepertoire, Length(sRepertoire) - Length(ListBoxRepertoiresSources.Items[ListBoxRepertoiresSources.ItemIndex])) + ' ]';
  Application.ProcessMessages;

  if FindFirst(IncludeTrailingPathDelimiter(sRepertoire) + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if _bArreterTraitement then
        Exit;

      if(sr.Name <> '.') and (sr.Name <> '..') then
      begin
        // Si r�pertoire.
        if(sr.Attr and faDirectory) = faDirectory then
        begin
          if(Length(sr.Name) = 8) and (TryStrToInt(sr.Name, nTmp)) then
          begin
            DateRepertoire := EncodeDate(StrToInt(LeftStr(sr.Name, 4)), StrToInt(Copy(sr.Name, 5, 2)), StrToInt(RightStr(sr.Name, 2)));

            // Si date r�pertoire ant�rieure au nombre de jours total de conservation.
            if CompareDateTime(IncDay(DateRepertoire, SpinEditNbJoursTotalLog.Value), Now) = -1 then
            begin
              // Suppression directe du r�pertoire (inutile de compresser).
              if SupprimerRepertoire(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                AjoutLog('>> R�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
              else
              begin
                ExitCode := ERREUR_SUPPRESSION_REPERTOIRE;
                AjoutLog('>> �chec suppression r�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
              end;
            end
            else
            begin
              // Si date r�pertoire ant�rieure au nombre de jours non zipp�.
              if CompareDateTime(IncDay(DateRepertoire, SpinEditNbJoursNonZippeLog.Value), Now) = -1 then
              begin
                // Si r�pertoire compress�.
                if Compresser(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                begin
                  // Suppression du r�pertoire.
                  if SupprimerRepertoire(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                    AjoutLog('>> R�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                  else
                  begin
                    ExitCode := ERREUR_SUPPRESSION_REPERTOIRE;
                    AjoutLog('>> �chec suppression r�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                  end;
                end
                else
                begin
                  ExitCode := ERREUR_COMPRESSION_REPERTOIRE;
                  AjoutLog('>> �chec compression r�pertoire [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] !');
                end;
              end;
            end;
          end;
        end
        else      // Fichier.
        begin
          // Si fichier zip.
          if((LowerCase(ExtractFileExt(sr.Name)) = '.7z') or (LowerCase(ExtractFileExt(sr.Name)) = '.zip')) then
          begin
            sNomFichier := LeftStr(sr.Name, Length(sr.Name) - Length(ExtractFileExt(sr.Name)));
            if(Length(sNomFichier) = 8) and (TryStrToInt(sNomFichier, nTmp)) then
            begin
              DateRepertoire := EncodeDate(StrToInt(LeftStr(sNomFichier, 4)), StrToInt(Copy(sNomFichier, 5, 2)), StrToInt(RightStr(sNomFichier, 2)));

              // Si date r�pertoire ant�rieure au nombre de jours total de conservation.
              if CompareDateTime(IncDay(DateRepertoire, SpinEditNbJoursTotalLog.Value), Now) = -1 then
              begin
                // Suppression du fichier compress�.
                if DeleteFile(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                  AjoutLog('>> Fichier [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
                else
                begin
                  ExitCode := ERREUR_SUPPRESSION_FICHIER_COMPRESSE;
                  AjoutLog('>> Erreur :  la suppression du fichier [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] a �chou� !' + #13#10 + SysErrorMessage(GetLastError));
                end;
              end;
            end;
          end;
        end;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

procedure TMainForm.TraitementSousRepertoireLogs(const sRepertoire: String);
var
  sr: TSearchRec;
  sNomFichier: String;
  nTmp: Integer;
//  DateRepertoire: TDateTime;
begin
  AjoutLog('Traitement sous-r�pertoire LOGS [' + sRepertoire + ']');
  LabelSousRepertoire.Caption := '[ ' + RightStr(sRepertoire, Length(sRepertoire) - Length(ListBoxRepertoiresSources.Items[ListBoxRepertoiresSources.ItemIndex])) + ' ]';
  Application.ProcessMessages;

  if FindFirst(IncludeTrailingPathDelimiter(sRepertoire) + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      if _bArreterTraitement then
        Exit;

      if(sr.Name <> '.') and (sr.Name <> '..') then
      begin
        // Si fichier.
        if(sr.Attr and faDirectory) <> faDirectory then
        begin
//          sNomFichier := LeftStr(sr.Name, Length(sr.Name) - Length(ExtractFileExt(sr.Name)));
//          if(Length(sNomFichier) >= 8) and (TryStrToInt(LeftStr(sNomFichier, 8), nTmp)) then
//          begin
//            DateRepertoire := EncodeDate(StrToInt(LeftStr(sNomFichier, 4)), StrToInt(Copy(sNomFichier, 5, 2)), StrToInt(Copy(sNomFichier, 7, 2)));

            // Si date fichier ant�rieure au nombre de jours de conservation.
            if CompareDateTime(IncDay(sr.TimeStamp, SpinEditNbJoursLogs.Value), Now) = -1 then
            begin
              // Suppression du fichier compress�.
              if DeleteFile(IncludeTrailingPathDelimiter(sRepertoire) + sr.Name) then
                AjoutLog('>> Fichier [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] supprim�.')
              else
              begin
                ExitCode := ERREUR_SUPPRESSION_FICHIER_LOGS;
                AjoutLog('>> Erreur :  la suppression du fichier [' + IncludeTrailingPathDelimiter(sRepertoire) + sr.Name + '] a �chou� !' + #13#10 + SysErrorMessage(GetLastError));
              end;
            end;
//          end;
        end;
      end;
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

function ProgressionCompression(Sender: Pointer; bTotal: Boolean; Value: Int64): HRESULT;   stdcall;
begin
  Result := 1;
//  MainForm.LabelProgression.Caption := IntToStr(Value);
  Application.ProcessMessages;
end;

procedure TMainForm.GetListeFichiers(const sRepertoire: String; out sListeFichier: String);
var
  sr: TSearchrec;
begin
  sListeFichier := '';
  if FindFirst(IncludeTrailingPathDelimiter(sRepertoire) + '*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      // Si fichier.
      if((sr.Attr and faDirectory) <> faDirectory) and (sr.Name <> '.') and (sr.Name <> '..') then
        sListeFichier := sListeFichier + sr.Name + ';';
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
end;

function TMainForm.Compresser(const sRepertoire: String): Boolean;
{$REGION 'Compresser'}
  function RepertoireCourant: String;
  var
    nIndex: Integer;
  begin
    Result := ReverseString(sRepertoire);
    nIndex := Pos('\', Result);
    if nIndex > 0 then
      Result := Copy(Result, 1, nIndex - 1);
    Result := ReverseString(Result);
  end;

  function GetTailleFichier(const szFichier: String): Int64;
  var
     sr: TSearchRec;
  begin
     Result := 0;
     if FindFirst(szFichier, faAnyFile, sr) = 0 then
     begin
        Result := sr.Size;
        FindClose(sr);
     end;
  end;
{$ENDREGION}
var
  TypeArchive: TGUID;
  Archive: I7zOutArchive;
  sListeFichier: String;
  bCompressionEnCours: Boolean;
begin
  Result := False;

  // Si r�pertoire d�j� compress� (anomalie).
  if FileExists(sRepertoire + '.zip') then
  begin
    AjoutLog('>> Attention :  r�pertoire [' + sRepertoire + '] d�j� compress� !');
    if not RenameFile(sRepertoire + '.zip', sRepertoire + '_OLD_(' + FormatDateTime('dd-mm-yyyy-hh-nn-ss', Now) + ')' + '.zip') then
    begin
      AjoutLog('>> �chec renommage fichier [' + sRepertoire + '.zip]: ' + SysErrorMessage(GetLastError));
      Exit;
    end;
  end;

  LabelEtape.Caption := 'Compression [' + RepertoireCourant + '] en cours ...';
  Application.ProcessMessages;

  // Compression.
  bCompressionEnCours := True;
  TThreadProc.RunInThread(
    procedure
    begin
      TypeArchive := CLSID_CFormatZip;
      Archive := CreateOutArchive(TypeArchive);
      GetListeFichiers(sRepertoire, sListeFichier);
      Archive.AddFiles(sRepertoire, '', sListeFichier, True);
      SetCompressionLevel(Archive, SpinEditTauxCompression.Value);      // 0 1 3 5 7 9
//      Archive.SetProgressCallback(nil, ProgressionCompression);
      Archive.SaveToFile(sRepertoire + '.zip');
    end
  ).whenError(
    procedure(aException: Exception)
    begin
      AjoutLog('>> ' + aException.Message);
    end
  ).whenFinish(
    procedure
    begin
      bCompressionEnCours := False;
    end
  ).Run;

  // Attente de la fin de la compression.
  while bCompressionEnCours do
  begin
    Application.ProcessMessages;
    Sleep(100);
  end;

  if FileExists(sRepertoire + '.zip') then
  begin
    if GetTailleFichier(sRepertoire + '.zip') > 0 then
    begin
      AjoutLog('>> R�pertoire [' + sRepertoire + '] compress�.');
      Result := True;
    end;
  end;

  LabelEtape.Caption := '';
  Application.ProcessMessages;
end;

function TMainForm.SupprimerRepertoire(const sRepertoire: String): Boolean;
var
  SHFileOpStruct: TSHFileOpStruct;
begin
  Result := False;
  if System.SysUtils.DirectoryExists(sRepertoire) then
  begin
    ZeroMemory(@SHFileOpStruct, SizeOf(SHFileOpStruct));
    SHFileOpStruct.wFunc := FO_DELETE;
    SHFileOpStruct.fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
    SHFileOpStruct.pFrom := PChar(sRepertoire + #0);
    Result := (0 = ShFileOperation(SHFileOpStruct));
  end;
end;

procedure TMainForm.Afficher1Click(Sender: TObject);
begin
  // Afficher la fen�tre.
  Show;
  Application.Restore;
end;

procedure TMainForm.AjoutLog(const sLigne: String; const bNouveau: Boolean);
var
  F: TextFile;
begin
  AssignFile(F, ExtractFilePath(Application.ExeName) + 'NettoieLame.log');
  try
    if bNouveau then
      Rewrite(F)
    else
      Append(F);
    Writeln(F, '[' + FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Now) + ']  ' + sLigne);
  finally
    CloseFile(F);
  end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  FichierINI: TIniFile;
  i: Integer;
begin
  FichierINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'NettoieLame.ini');
  try
    FichierINI.EraseSection('R�pertoires sources');
    for i:=0 to Pred(ListBoxRepertoiresSources.Items.Count) do
      FichierINI.WriteString('R�pertoires sources', IntToStr(i + 1), ListBoxRepertoiresSources.Items[i]);

    FichierINI.WriteInteger('Sous-r�pertoires', 'BATCH', IfThen(CheckBoxBatch.Checked, 1, 0));
    FichierINI.WriteInteger('Sous-r�pertoires', 'EXTRACT', IfThen(CheckBoxExtract.Checked, 1, 0));
    FichierINI.WriteInteger('Sous-r�pertoires', 'LOG', IfThen(CheckBoxLOG.Checked, 1, 0));
    FichierINI.WriteInteger('Sous-r�pertoires', 'LOGS', IfThen(CheckBoxLOGS.Checked, 1, 0));

    FichierINI.WriteInteger('Param�tres', 'Nombre de jours non zipp� BATCH', SpinEditNbJoursNonZippeBatch.Value);
    FichierINI.WriteInteger('Param�tres', 'Nombre de jours total BATCH', SpinEditNbJoursTotalBatch.Value);
    FichierINI.WriteInteger('Param�tres', 'Nombre de jours non zipp� EXTRACT', SpinEditNbJoursNonZippeExtract.Value);
    FichierINI.WriteInteger('Param�tres', 'Nombre de jours total EXTRACT', SpinEditNbJoursTotalExtract.Value);
    FichierINI.WriteInteger('Param�tres', 'Nombre de jours non zipp� LOG', SpinEditNbJoursNonZippeLog.Value);
    FichierINI.WriteInteger('Param�tres', 'Nombre de jours total LOG', SpinEditNbJoursTotalLog.Value);
    FichierINI.WriteInteger('Param�tres', 'Nombre de jours LOGS', SpinEditNbJoursLogs.Value);
    FichierINI.WriteInteger('Param�tres', 'Taux de compression', SpinEditTauxCompression.Value);
  finally
    FichierINI.Free;
  end;
end;

end.

