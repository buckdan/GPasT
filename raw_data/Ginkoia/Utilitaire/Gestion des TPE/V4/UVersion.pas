unit UVersion;

interface

Type
  TProcedure = procedure;
    Function GetNumVersionSoft:string;

implementation

uses Windows, SysUtils;

Function GetNumVersionSoft:string;
var
  VerInfoSize, VerValueSize, Dummy: DWord;
  VerInfo: Pointer;
  VerValue: PVSFixedFileInfo;
begin
  VerInfoSize := GetFileVersionInfoSize(PChar(ParamStr(0)), Dummy);
  {Deux solutions : }
  if VerInfoSize <> 0 then
  {- Les info de version sont inclues }
  begin
    {On alloue de la m�moire pour un pointeur sur les info de version : }
    GetMem(VerInfo, VerInfoSize);
    {On r�cup�re ces informations : }
    GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
    VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
    {On traite les informations ainsi r�cup�r�es : }
    with VerValue^ do
    begin
      Result := IntTostr(dwFileVersionMS shr 16);
      Result := Result + '.' + IntTostr(dwFileVersionMS and $FFFF);
      Result := Result + '.' + IntTostr(dwFileVersionLS shr 16);
      Result := Result + '.' + IntTostr(dwFileVersionLS and $FFFF);
    end;

    {On lib�re la place pr�c�demment allou�e : }
    FreeMem(VerInfo, VerInfoSize);
  end

  else
    {- Les infos de version ne sont pas inclues }
    {On d�clenche une exception dans le programme : }
    raise EAccessViolation.Create('Les informations de version de sont pas inclues');
end;

end.
