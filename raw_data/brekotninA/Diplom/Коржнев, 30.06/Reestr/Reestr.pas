unit Reestr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Registry;

type
  TForm15 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation
  //Uses Key, Entry;
{$R *.dfm}
 function SHRegGetPath(hkey:HKEY; pszSubKey:PChar; pszValue:PChar;
         pszPath:PChar; dwFlags:DWORD):LongInt;
         stdcall; external 'shlwapi.dll' name 'SHRegGetPathA';
procedure TForm15.Button1Click(Sender: TObject);
var c:array [0..MAX_PATH] of char;
    res:longint;
begin
//��������� ��������
res:= SHRegGetPath( HKEY_LOCAL_MACHINE,
                    'SYSTEM\CurrentControlSet\Services\Eventlog',
                    'ImagePath',c,0);
//���� res<>0, �� ��������� ��������� �� ������ (� ����������� �� ���� ������)
if res<>0 then begin
   FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,res,0,c,High(c)-1,nil);
   MessageBox(0,c,nil,MB_ICONEXCLAMATION);
   ExitProcess(0);
   end;
//���� GetFileAttributes=-1, ��, ������ �����, ������ ����� ���
//��� ��� ���� �� ������ ��������� - �� ����� ������ ��������
if GetFileAttributes(c)=Cardinal(-1) then begin
   FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM,nil,GetLastError(),0,c,High(c)-1,nil);
   MessageBox(0,c,nil,MB_ICONEXCLAMATION);
   ExitProcess(0);
   end;
//false - �������� ������������, true - �� ��������
CopyFile(c,'c:\SomeFile.zzz',false);
end;

end.
