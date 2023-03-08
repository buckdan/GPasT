unit IdSrvClient;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ScktComp, ExtCtrls, IniFiles, MudUtil, HUtil32, Grobal2;

type
  TAdmission = record
    usrid:   string[14];
    uaddr:   string[15];
    Certification: integer;
    PayMode: integer;  //0:체험판, 1:정상, 2:무료모드
    AvailableMode: integer;
    //1:개인정액 2:개인정량 3:겜방정액 4:겜방정량 5:무료사용자 6:미르2정량사용자
    ClientVersion: integer;
  end;
  PTAdmission = ^TAdmission;

  TFrmIDSoc = class(TForm)
    IDSocket: TClientSocket;
    Timer1:   TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: integer);
    procedure IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    AdmissionList: TList;
    ShareIPList:   TStringList;
    LoginServerCheckTime: longword;
    procedure AddAdmission(uid, uaddr: string;
      certify, paymode, available, clversion: integer);
    procedure DelAdmission(certify: integer);
    procedure GetPasswdSuccess(body: string);
    procedure GetCancelAdmission(body: string);
    procedure GetTotalUserCount(body: string);
    procedure GetAccountExpired(body: string);
    procedure GetUsageInformation(body: string);
  public
    ServerAddress: string;
    ServerPort:    integer;
    IDSocStr:      string;
    procedure Initialize;
    procedure DecodeSocStr;
    procedure LoadShareIPList;
    function GetAdmission(uid, ipaddr: string; cert: integer;
      var availmode, clversion: integer): integer;  //메인 스래드에서만 사용해야 함.
    procedure SendUserClose(uid: string; cert: integer);
    procedure SendUserShiftToVentureServer(svname, uid: string; cert: integer);
    procedure SendUserCount(ucount: integer);
    procedure SendGameTimeOfTimeCardUser(uid: string; gametime_min: integer);
  end;

var
  FrmIDSoc: TFrmIDSoc;

implementation

uses
  svMain;

{$R *.DFM}

procedure TFrmIDSoc.FormCreate(Sender: TObject);
var
  ini:   TIniFile;
  fname: string;
  i:     integer;
begin
  IDSocket.Address := '';
  fname := '.\!setup.txt';
  if FileExists(fname) then begin
    ini := TIniFile.Create(fname);
    if ini <> nil then begin
      ServerAddress := ini.ReadString('Server', 'IDSAddr', '210.121.143.204');
      ServerPort    := ini.ReadInteger('Server', 'IDSPort', 5600);
    end;
    ini.Free;
  end else
    ShowMessage(fname + ' not found');
  AdmissionList := TList.Create;

  ShareIPList := TStringList.Create;
  LoadShareIPList;

  LoginServerCheckTime := GetTickCount;
end;

procedure TFrmIDSoc.FormDestroy(Sender: TObject);
var
  i: integer;
begin
  csShare.Enter;
  try
    for i := 0 to AdmissionList.Count - 1 do begin
      Dispose(PTAdmission(AdmissionList[i]));
    end;
    AdmissionList.Clear;
  finally
    csShare.Leave;
  end;
  AdmissionList.Free;
  ShareIPList.Free;
end;

procedure TFrmIDSoc.LoadShareIPList;
var
  i:     integer;
  fname: string;
begin {
   ShareIPList.Clear;
   fname := '.\!shareiplist.txt';
   if FileExists (fname) then begin
      ShareIPList.LoadFromFile (fname);
      CheckListValidTrim (ShareIPList);
   end else
      ShowMessage (fname + ' not found');  }
end;

procedure TFrmIDSoc.Timer1Timer(Sender: TObject);
begin
  if IDSocket.Address <> '' then
    if not IDSocket.Active then
      IDSocket.Active := True;
end;

procedure TFrmIDSoc.IDSocketConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ;
end;

procedure TFrmIDSoc.IDSocketDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ;
end;

procedure TFrmIDSoc.IDSocketError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: integer);
begin
  ErrorCode := 0;
  Socket.Close;
end;

procedure TFrmIDSoc.IDSocketRead(Sender: TObject; Socket: TCustomWinSocket);
var
  Data: AnsiString;
begin
  try
    csShare.Enter;
    SetLength(Data, Socket.ReceiveLength);
    SetLength(Data, Socket.ReceiveBuf(Pointer(Data)^, Length(Data)));
    IdSocStr := IdSocStr + Data;
    //IdSocStr := IdSocStr + Socket.ReceiveText;
  finally
    csShare.Leave;
  end;
end;

procedure TFrmIDSoc.Initialize;
begin
  with IDSocket do begin
    Active  := False;
    Address := ServerAddress;
    Port    := ServerPort;
    Active  := True;
  end;
end;

procedure TFrmIDSoc.SendUserClose(uid: string; cert: integer);
begin
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText('(' + IntToStr(ISM_USERCLOSED) + '/' +
      uid + '/' + IntToStr(cert) + ')');
end;

procedure TFrmIDSoc.SendGameTimeOfTimeCardUser(uid: string; gametime_min: integer);
begin
  // 2003.01.22 국내 서비스에 무용한 루틴이므로 리마크 처리
{
   if IDSocket.Socket.Connected then
      IDSocket.Socket.SendText ('(' + IntToStr(ISM_GAMETIMEOFTIMECARDUSER) +
                                      '/' + uid +
                                      '/' + IntToStr(gametime_min) +
                                      ')');
}
end;

procedure TFrmIDSoc.SendUserShiftToVentureServer(svname, uid: string; cert: integer);
begin
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText('(' + IntToStr(ISM_SHIFTVENTURESERVER) +
      '/' + svname + '/' + uid + '/' + IntToStr(cert) + ')');
end;

procedure TFrmIDSoc.SendUserCount(ucount: integer);
begin
  if IDSocket.Socket.Connected then
    IDSocket.Socket.SendText('(' + IntToStr(ISM_USERCOUNT) + '/' +
      ServerName + '/' + IntToStr(ServerIndex) + '/' + IntToStr(ucount) + ')');
end;

procedure TFrmIDSoc.DecodeSocStr;
var
  BufStr, str, head, body: string;
  ident: integer;
begin
  try
    csShare.Enter;
    if Pos(')', IdSocStr) <= 0 then
      exit;
    BufStr   := IDSocStr;
    IDSocStr := '';
  finally
    csShare.Leave;
  end;

  try
    while Pos(')', BufStr) > 0 do begin
      BufStr := ArrestStringEx(BufStr, '(', ')', str);
      if str <> '' then begin
        body  := GetValidStr3(str, head, ['/']);
        ident := Str_ToInt(head, 0);
        case ident of
          ISM_PASSWDSUCCESS: begin
            GetPasswdSuccess(body);
          end;
          ISM_CANCELADMISSION: begin
            GetCancelAdmission(body);
          end;
          ISM_SHIFTVENTURESERVER: begin
            if BoVentureServer then begin  //모험서버로 이동해옴
              ;
            end;
          end;
          ISM_TOTALUSERCOUNT: begin
            GetTotalUserCount(body);
          end;
          ISM_ACCOUNTEXPIRED: begin
            GetAccountExpired(body);
          end;
          //             ISM_USAGEINFORMATION:
          //                begin
          //                   GetUsageInformation (body);
          //                   LoginServerCheckTime := GetTickCount;
          //                end;
        end;
      end else
        break;
    end;
    try
      csShare.Enter;
      IdSocStr := BufStr + IdSocStr;
    finally
      csShare.Leave;
    end;

    // Update Log...Copark
    // 접속해재를 일단 막음
    //    if GetTickCount - LoginServerCheckTime > 500000 then begin  //로그인 서버로 부터 GetUsageInformation 을 못 받으면
    //로그인 서버와 끊어진다.
    //    IDSocket.Active := FALSE;  //끊어졌다 붙었다 하게됨
    //    end;

  except
    MainOutMessage('[Exception] FrmIdSoc.DecodeSocStr');
  end;
end;

procedure TFrmIDSoc.GetPasswdSuccess(body: string);
var
  uid, certstr, paystr, uaddr, availablestr, cversion: string;
  avail: integer;
begin
  try
    body  := GetValidStr3(body, uid, [char($a)]);
    body  := GetValidStr3(body, certstr, [char($a)]);
    body  := GetValidStr3(body, paystr, [char($a)]);
    body  := GetValidStr3(body, availablestr, [char($a)]);
    body  := GetValidStr3(body, uaddr, [char($a)]);
    body  := GetValidStr3(body, cversion, [char($a)]);
{      body := GetValidStr3 (body, uid, ['/']);
      body := GetValidStr3 (body, certstr, ['/']);
      body := GetValidStr3 (body, paystr, ['/']);
      body := GetValidStr3 (body, availablestr, ['/']);
      body := GetValidStr3 (body, uaddr, ['/']);
      body := GetValidStr3 (body, cversion, ['/']);}
    avail := Str_ToInt(availablestr, 0);
    //FrmMain.Memo1.Lines.Add ('Cert:'+uid+'/'+certstr+'/'+paystr+'/'+availablestr+'/'+uaddr+'/'+cversion+'/');
    AddAdmission(uid, uaddr, Str_ToInt(certstr, 0), Str_ToInt(paystr, 0),
      avail, Str_ToInt(cversion, 0));
    //if avail = 0 then
    //   MainOutMessage (body);
  except
    MainOutMessage('[Exception] FrmIdSoc.GetPasswdSuccess');
  end;
end;

procedure TFrmIDSoc.GetCancelAdmission(body: string);
var
  uid, certstr: string;
  cert: integer;
begin
  try
    certstr := GetValidStr3(body, uid, ['/']);
    cert    := Str_ToInt(certstr, 0);
    ////UserEngine.AccountExpired (uid);
    DelAdmission(cert);
  except
    MainOutMessage('[Exception] FrmIdSoc.GetCancelAdmission');
  end;
end;

 //available
 // 1 개인정액
 // 2 개인정량
 // 3 겜방정액
 // 4 겜방정량
 // 5 공짜
procedure TFrmIDSoc.AddAdmission(uid, uaddr: string;
  certify, paymode, available, clversion: integer);
var
  pa: PTAdmission;
begin
  new(pa);
  pa.usrid   := uid;
  pa.uaddr   := uaddr;
  pa.Certification := certify;
  pa.PayMode := paymode;
  pa.AvailableMode := available;
  pa.ClientVersion := clversion;

  try
    csShare.Enter;
    AdmissionList.Add(pa);
  finally
    csShare.Leave;
  end;
end;

procedure TFrmIDSoc.DelAdmission(certify: integer);
var
  i:      integer;
  kickid: string;
begin
  kickid := '';
  try
    csShare.Enter;
    for i := 0 to AdmissionList.Count - 1 do begin
      if PTAdmission(AdmissionList[i]).Certification = certify then begin
        kickid := PTAdmission(AdmissionList[i]).UsrId;
        //인증 제거
        Dispose(PTAdmission(AdmissionList[i]));
        AdmissionList.Delete(i);
        break;
      end;
    end;
  finally
    csShare.Leave;
  end;
  if kickid <> '' then begin
    //인증이 해제된 ID 킥..
    csDelShare.Enter;
    try
      RunSocket.CloseUserid(kickid, certify);
    finally
      csDelShare.Leave;
    end;
  end;
end;

 //0: 승인 없음
 //1: 체험판
 //2: 정식 사용자
function TFrmIDSoc.GetAdmission(uid, ipaddr: string; cert: integer;
  var availmode, clversion: integer): integer;

  function IsShareIP(ip: string): boolean;
  var
    i: integer;
  begin
    Result := False;
    for i := 0 to ShareIPList.Count - 1 do
      if ShareIPList[i] = ip then begin
        Result := True;
        break;
      end;
  end;

var
  i: integer;
begin
  Result    := 0;
  availmode := 0;

  try
    try
      csShare.Enter;
      for i := 0 to AdmissionList.Count - 1 do begin
        if PTAdmission(AdmissionList[i]).Certification = cert then begin
          //if (PTAdmission(AdmissionList[i]).usrid = uid) and
          //   (
          //     (PTAdmission(AdmissionList[i]).uaddr = ipaddr)
          //       or IsShareIP (PTAdmission(AdmissionList[i]).uaddr)
          //   ) then
          //begin
          case PTAdmission(AdmissionList[i]).PayMode of
            2: Result := 3;   //무료사용자
            1: Result := 2;   //정식사용자
            0: Result := 1;   //체험판
          end;
          availmode := PTAdmission(AdmissionList[i]).AvailableMode;
          clversion := PTAdmission(AdmissionList[i]).ClientVersion;
          //end else begin
          //   if BoViewAdmissionFail then
          //      MainOutMessage ('[Adm-Failure] ' + ipaddr + '/' + uid);
          //end;
          break;
        end;
      end;
    finally
      csShare.Leave;
    end;
  except
    MainOutMessage('[RunSock->FrmIdSoc] GetAdmission exception');
  end;
end;

procedure TFrmIDSoc.GetTotalUserCount(body: string);
begin
  TotalUserCount := Str_ToInt(body, 0);
end;

procedure TFrmIDSoc.GetAccountExpired(body: string);
var
  uid, certstr: string;
  cert: integer;
begin
  try
    certstr := GetValidStr3(body, uid, ['/']);
    cert    := Str_ToInt(certstr, 0);
    if not BoTestServer and not BoServiceMode then begin
      UserEngine.AccountExpired(uid);
      DelAdmission(cert);
    end;
  except
    MainOutMessage('[Exception] FrmIdSoc.GetCancelAdmission');
  end;
end;

procedure TFrmIDSoc.GetUsageInformation(body: string);
var
  scurmon, stotalmon, slastmon, sgross, sgrosscount: string;
begin
  body := GetValidStr3(body, scurmon, ['/']);
  body := GetValidStr3(body, stotalmon, ['/']);
  body := GetValidStr3(body, slastmon, ['/']);
  body := GetValidStr3(body, sgross, ['/']);
  body := GetValidStr3(body, sgrosscount, ['/']);

  CurrentMonthlyCard := Str_ToInt(scurmon, 0);
  TotalTimeCardUsage := Str_ToInt(stotalmon, 0);
  LastMonthTotalTimeCardUsage := Str_ToInt(slastmon, 0);
  GrossTimeCardUsage := Str_ToInt(sgross, 0);
  GrossResetCount    := Str_ToInt(sgrosscount, 0);

end;


end.
