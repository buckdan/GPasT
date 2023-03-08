unit uTCPThread;

interface

  uses Classes, uCommon, uCommonThread,Windows , ComCtrls, sysUtils, Forms;

type TTCPThread = class(TCMNThread)
  private
  public
    procedure Execute;override;
  published
end;

function CallBackCopyFile(
  TotalFileSize: LARGE_INTEGER;          // Taille totale du fichier en octets
  TotalBytesTransferred: LARGE_INTEGER;  // Nombre d'octets d�j�s transf�r�s
  StreamSize: LARGE_INTEGER;             // Taille totale du flux en cours
  StreamBytesTransferred: LARGE_INTEGER; // Nombre d'octets d�j� tranf�r�s dans ce flus
  dwStreamNumber: DWord;                 // Num�ro de flux actuem
  dwCallbackReason: DWord;               // Raison de l'appel de cette fonction
  hSourceFile: THandle;                  // handle du fichier source
  hDestinationFile: THandle;             // handle du fichier destination
  ProgressBar : TProgressBar             // param�tre pass� � la fonction qui est une
                                         // recopie du param�tre pass� � CopyFile Ex
                                         // Il sert � passer l'adresse du progress bar �
                                         // mettre � jour pour la copie. C'est une
                                         // excellente id�e de DelphiProg
  ): DWord; far; stdcall;


implementation

function CallBackCopyFile(
  TotalFileSize: LARGE_INTEGER;          // Taille totale du fichier en octets
  TotalBytesTransferred: LARGE_INTEGER;  // Nombre d'octets d�j�s transf�r�s
  StreamSize: LARGE_INTEGER;             // Taille totale du flux en cours
  StreamBytesTransferred: LARGE_INTEGER; // Nombre d'octets d�j� tranf�r�s dans ce flus
  dwStreamNumber: DWord;                 // Num�ro de flux actuem
  dwCallbackReason: DWord;               // Raison de l'appel de cette fonction
  hSourceFile: THandle;                  // handle du fichier source
  hDestinationFile: THandle;             // handle du fichier destination
  ProgressBar : TProgressBar             // param�tre pass� � la fonction qui est une
                                         // recopie du param�tre pass� � CopyFile Ex
                                         // Il sert � passer l'adresse du progress bar �
                                         // mettre � jour pour la copie. C'est une
                                         // excellente id�e de DelphiProg
  ): DWord; far; stdcall;
var
  EnCours: Int64;
begin
  // Calcul de la position du progresbar en pourcent, le calcul doit �tre effectu� dans
  // une variable interm�diaire de type Int64. Pour �viter les d�bordement de calcul
  // dans la propri�t� Position de type integer.
  if TotalFileSize.QuadPart <> 0 then
    EnCours := TotalBytesTransferred.QuadPart * 100 div TotalFileSize.QuadPart;
  If ProgressBar<>Nil Then ProgressBar.Position := EnCours;
  // La fonction doit d�finir si la copie peut �tre continu�e.
//  Application.ProcessMessages;
  Result := PROGRESS_CONTINUE;
end;


{ TTCPThread }

procedure TTCPThread.Execute;
var
  lpData : pointer;
  lpBool : PBool;
  Token : THandle;
  NewDestination : String;
begin
  Try
    case Self.ActionMode of
      maCopy : begin
        // Cr�ation du/des r�pertoire/s de destination s'il n'existe pas
        DoDir(ExtractFilePath(DestinationFile));
        // traitement de la copie
        if LogNetWork then
          Logonuser(PWideChar(LogUser),'',PWideChar(LogPassword),LOGON32_LOGON_INTERACTIVE, LOGON32_PROVIDER_WINNT50, Token);
        NewDestination := ExtractFilePath(DestinationFile) + 'O_' + ExtractFileName(DestinationFile);
        if FileExists(DestinationFile) then
          if not RenameFile(DestinationFile, NewDestination) then
            raise Exception.Create('Echec du renommage de ' + NewDestination);

        CopyFileEx(PWideChar(SourceFile),PwideChar(DestinationFile),@CallBackCopyFile,ProgressBar,lpBool,COPY_FILE_FAIL_IF_EXISTS);

        if FileExists(NewDestination) then
          if not DeleteFile(NewDestination) then
            raise Exception.Create('Echec de la suppression de ' + 'O_' + DestinationFile);
      end;
      maZip: ZipFile;
      maDel: DeleteFile(SourceFile);
    end;
  Except on E:Exception do
    begin
      if FileExists(DestinationFile) then
        DeleteFile(DestinationFile);

      if FileExists(NewDestination) then
        RenameFile(NewDestination,DestinationFile);

      Logs.Add('TCPThread -> ' + SourceFile + ' - ' + E.Message);
      Logs.Add('Erreur : ' + IntToStr((GetLastError)));
    end;
  End;
  IsTerminated := True;

end;

end.
