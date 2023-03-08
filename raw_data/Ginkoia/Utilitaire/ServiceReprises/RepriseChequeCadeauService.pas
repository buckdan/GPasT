unit RepriseChequeCadeauService;

interface

uses
  System.Classes, System.SysUtils,
  uRepriseChequeCadeauUtils, uRepriseChequeCadeauDBUtils, ulog, ulogs;

type
  TRepriseChequeCadeauService = class(TThread)
  private
    FLogs: TLogs;

    FDelais: integer;
    FRCCUtils: TRepriseChequeCadeauUtils;
    FRCCDBUtils: TRepriseChequeCadeauDBUtils;

    procedure InitLogs;
    procedure RefreshLogFileName;
    procedure InitDelais;
    procedure AddLog(ALogMessage: string; ALogLevel: TLogLevel = logTrace); overload;
    procedure AddLog(ALogItem: TLogItem); overload;
    procedure RepriseChequeCadeauLog(Sender: TObject; ALogItem: TLogItem);
  protected
    procedure Execute; override;

    procedure RecoverCKDs;
    procedure RCCCanContinue(Sender: TObject; var ACanContinue: Boolean);
  public
    constructor Create(ADataBaseFile: string); overload;
    destructor Destroy; override;

    function CanExecute: Boolean;
  end;

implementation

uses
  ShellAPI, Vcl.SvcMgr, ActiveX;

{ TRepriseChequeCadeau }

procedure TRepriseChequeCadeauService.AddLog(ALogMessage: string; ALogLevel: TLogLevel);
var
  tmplog: TLogItem;
begin
  tmplog.key := 'Status';
  tmplog.mag := '';
  tmplog.val := ALogMessage;
  tmplog.lvl := ALogLevel;

  AddLog(tmplog);
end;

procedure TRepriseChequeCadeauService.AddLog(ALogItem: TLogItem);
begin
  log.Log('DEMAT', log.Ref, ALogItem.mag, ALogItem.key, ALogItem.val, ALogItem.lvl, True, FDelais * 2 + 10);
  FLogs.AddToLogs(ALogItem.val);
end;

function TRepriseChequeCadeauService.CanExecute: Boolean;
begin
  try
    Result := Length(FRCCDBUtils.ListMagasins(True)) > 0;
  finally
    FRCCDBUtils.closeConnection;
  end;
end;

constructor TRepriseChequeCadeauService.Create(ADataBaseFile: string);
begin
  InitLogs;

  FRCCUtils := TRepriseChequeCadeauUtils.Create(ADataBaseFile);
  FRCCUtils.OnCanContinue := RCCCanContinue;
  FRCCUtils.OnLog := RepriseChequeCadeauLog;

  FRCCDBUtils := TRepriseChequeCadeauDBUtils.Create(ADataBaseFile);
  FRCCDBUtils.OnLog := RepriseChequeCadeauLog;

  FDelais := 0;

  FreeOnTerminate := False;

  inherited Create(True);
end;

destructor TRepriseChequeCadeauService.Destroy;
begin
  FreeAndNil(FRCCUtils);
  FreeAndNil(FRCCDBUtils);
  FreeAndNil(FLogs);

  inherited;
end;

procedure TRepriseChequeCadeauService.Execute;
var
  count: integer;
begin
  //Initialisation des objects COM pour pouvoir lire les XML retourn� par le service web
  CoInitialize(nil);

  InitDelais;

  try
    count := 0;
    AddLog(Format('Demarrage du service "Reprise ch�ques cadeaux" (d�lai %d minutes)', [Trunc(FDelais / 60)]));
    AddLog('Demarr�', logInfo);
    while not Terminated do
    begin
      try
        inc(Count);
        if Count >= FDelais then
        begin
          Count := 0;
          try
            RecoverCKDs;
            InitDelais;
          finally
            FRCCUtils.closeConnection;
          end;
        end;
        Sleep(1000);
      except
        on E: Exception do
          AddLog(Format('Erreur : %s', [E.Message]), logError);
      end;
    end;
  finally
    AddLog(Format('Arr�t du service "Reprise ch�ques cadeaux"', [FDelais]));
    AddLog('Arr�t�', logInfo);
    CoUninitialize;
  end;
end;

procedure TRepriseChequeCadeauService.InitDelais;
var
  i, magDelais: integer;
  magasins: TMagasinArray;

  newdelais: integer;
begin
  try
    newdelais := FRCCDBUtils.getGenParamValueInteger(3,  134, 0);

    if newdelais = 0 then
    begin
      AddLog('Impossible de r�cup�rer le "d�lai" par le "GENBASES.BAS_MAGID". Tentative par la liste des magasins');
      magasins := FRCCDBUtils.ListMagasins(True);

      for i := 0 to length(magasins) - 1 do
      begin
        AddLog('  ' + magasins[i].FName);
        magDelais := FRCCDBUtils.getGenParamValueInteger(3,  134, magasins[i].FId);
        if (newdelais = 0) or (magDelais < newdelais) then
          newdelais := magDelais;
      end;
    end;

    if newdelais = 0 then
    begin
      newdelais := 15;
      AddLog(Format('Impossible de r�cup�rer le "d�lai" dans la base de donn�e. ' +
        'Utilisation de la valeur par d�faut (%d minutes)', [newdelais]));
    end;

    newdelais := newdelais * 60; // "x60" pour la passer en seconde

    if newdelais <> FDelais then
    begin
      FDelais := newdelais;
      AddLog(Format('Chargement du d�lai = %d minutes', [Trunc(FDelais / 60)]));
    end;
  finally
    FRCCDBUtils.closeConnection;
  end;
end;

procedure TRepriseChequeCadeauService.InitLogs;
var
  path: string;
begin
  path := ExtractFilePath(ParamStr(0)) + '\logs\';
  if not DirectoryExists(path) then
  begin
    ForceDirectories(path);
  end;

  FLogs := TLogs.Create;
  FLogs.Path := path;

  RefreshLogFileName;
end;

procedure TRepriseChequeCadeauService.RCCCanContinue(Sender: TObject;
  var ACanContinue: Boolean);
begin
  ACanContinue := Not Terminated;
end;

procedure TRepriseChequeCadeauService.RecoverCKDs;
begin
  RefreshLogFileName;
  AddLog('Lancement de la "Reprise ch�ques cadeaux"', logNotice);
  FRCCUtils.RecoverBaseCKDs;
  AddLog('Fin du traitement pour la "Reprise ch�ques cadeaux"', logInfo);
end;

procedure TRepriseChequeCadeauService.RefreshLogFileName;
var
  sdate: string;
begin
  DateTimeToString(sdate, 'yyyymmdd', Now());
  FLogs.FileName := Format('reprisechequecadeauservicelogs_%s.txt', [sdate]);
end;

procedure TRepriseChequeCadeauService.RepriseChequeCadeauLog(Sender: TObject;
  ALogItem: TLogItem);
begin
  AddLog(ALogItem);
end;

end.
