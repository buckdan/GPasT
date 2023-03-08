unit RepriseCCGlobalPOSService;

interface

uses
  System.Classes, System.SysUtils,
  uRepriseCCGlobalPOSUtils, uRepriseCCGlobalPOSDBUtils, ulog, ulogs;

type
  TRepriseCCGlobalPOSService = class(TThread)
  private
    FLogs: TLogs;

    FDelais: integer;
    FRCCUtils: TRepriseCCGlobalPOSUtils;
    FRCCDBUtils: TRepriseCCGlobalPOSDBUtils;

    procedure InitLogs;
    procedure RefreshLogFileName;
    procedure InitDelais;
    procedure AddLog(ALogMessage: string; ALogLevel: TLogLevel = logTrace); overload;
    procedure AddLog(ALogItem: TLogItem); overload;
    procedure RepriseCCGlobalPOSLog(Sender: TObject; ALogItem: TLogItem);
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

{ TRepriseCCGlobalPOS }

procedure TRepriseCCGlobalPOSService.AddLog(ALogMessage: string; ALogLevel: TLogLevel);
var
  tmplog: TLogItem;
begin
  tmplog.key := 'Status';
  tmplog.mag := '';
  tmplog.val := ALogMessage;
  tmplog.lvl := ALogLevel;

  AddLog(tmplog);
end;

procedure TRepriseCCGlobalPOSService.AddLog(ALogItem: TLogItem);
begin
  log.Log('CCGlobalPOS', log.Ref, ALogItem.mag, ALogItem.key, ALogItem.val, ALogItem.lvl, True, FDelais * 2 + 10);
  FLogs.AddToLogs(ALogItem.val);
end;

function TRepriseCCGlobalPOSService.CanExecute: Boolean;
begin
  try
    Result := Length(FRCCDBUtils.ListMagasins(True)) > 0;
  finally
    FRCCDBUtils.closeConnection;
  end;
end;

constructor TRepriseCCGlobalPOSService.Create(ADataBaseFile: string);
begin
  InitLogs;

  FRCCUtils := TRepriseCCGlobalPOSUtils.Create(ADataBaseFile);
  FRCCUtils.OnCanContinue := RCCCanContinue;
  FRCCUtils.OnLog := RepriseCCGlobalPOSLog;

  FRCCDBUtils := TRepriseCCGlobalPOSDBUtils.Create(ADataBaseFile);
  FRCCDBUtils.OnLog := RepriseCCGlobalPOSLog;

  FDelais := 0;

  FreeOnTerminate := False;

  inherited Create(True);
end;

destructor TRepriseCCGlobalPOSService.Destroy;
begin
  FreeAndNil(FRCCUtils);
  FreeAndNil(FRCCDBUtils);
  FreeAndNil(FLogs);

  inherited;
end;

procedure TRepriseCCGlobalPOSService.Execute;
var
  count: integer;
begin
  //Initialisation des objects COM pour pouvoir lire les XML retourn� par le service web
  CoInitialize(nil);

  //InitDelais; comment� pour commencer le premier traitement instantan�mment.

  try
    count := 0;
    AddLog(Format('Demarrage du service "Reprise cartes cadeaux Global POS" (d�lai %d minutes)', [Trunc(FDelais / 60)]));
    AddLog('Demarr�', logInfo);
    while not Terminated do
    begin
      try
        inc(Count);
        if Count >= FDelais then
        begin
          count := 0;
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
    AddLog(Format('Arr�t du service "Reprise cartes cadeaux"', [FDelais]));
    AddLog('Arr�t�', logInfo);
    CoUninitialize;
  end;
end;

procedure TRepriseCCGlobalPOSService.InitDelais;
var
  i, magDelais: integer;
  magasins: TMagasinArray;

  newdelais: integer;
begin
  try
    newdelais := FRCCDBUtils.getGenParamValueInteger(13, 24, 0);

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

procedure TRepriseCCGlobalPOSService.InitLogs;
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

procedure TRepriseCCGlobalPOSService.RCCCanContinue(Sender: TObject;
  var ACanContinue: Boolean);
begin
  ACanContinue := Not Terminated;
end;

procedure TRepriseCCGlobalPOSService.RecoverCKDs;
begin
  RefreshLogFileName;
  AddLog('Lancement de la "Reprise cartes cadeaux"', logNotice);
  FRCCUtils.RecoverBaseCKDOs;
  AddLog('Fin du traitement pour la "Reprise cartes cadeaux"', logInfo);
end;

procedure TRepriseCCGlobalPOSService.RefreshLogFileName;
var
  sdate: string;
begin
  DateTimeToString(sdate, 'yyyymmdd', Now());
  FLogs.FileName := Format('repriseCCGlobalPOSservicelogs_%s.txt', [sdate]);
end;

procedure TRepriseCCGlobalPOSService.RepriseCCGlobalPOSLog(Sender: TObject;
  ALogItem: TLogItem);
begin
  AddLog(ALogItem);
end;

end.
