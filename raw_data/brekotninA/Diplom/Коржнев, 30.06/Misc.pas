unit Misc;

interface

function GetBaseCaption:string;
function GetBaseKey:string;
function GetInstallDateKey:string;

implementation

function GetBaseCaption:string;
begin
{$IfDef TRIZ_MODE}
  Result:='����-9.0. ����������. ���������� �������';
{$Else}
  Result:='����-9.0. ����������. ���������� �������';
  //Result:='����������� ���������� �� ���������� ��� ��������� � ������� �������';
{$EndIf}
end;

function GetBaseKey:string;
begin
{$IfDef TRIZ_MODE}
  Result:='Software\Burov A N\Triz';
{$Else}
  Result:='Software\Burov A N\Logic';
{$EndIf}
end;

function GetInstallDateKey:string;
begin
{$IfDef TRIZ_MODE}
  Result:='TGUID';
{$Else}
  Result:='LGUID';
{$EndIf}
end;
end.
