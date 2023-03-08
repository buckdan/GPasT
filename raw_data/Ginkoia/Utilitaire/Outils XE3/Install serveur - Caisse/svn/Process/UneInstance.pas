unit UneInstance;

interface

uses
  Windows, SysUtils, Forms;

// fonction � mettre juste apr�s le Begin du dpr:
//
// if not(RunOnlyOne) then
//   exit;
//
// Application.Initialize;
// ...

function RunOnlyOne(Global : boolean = false) : boolean;

implementation

function RunOnlyOne(Global : boolean): boolean;

  function GetMutexPrefix(Global : boolean) : string;
  begin
    if Global then
      Result := 'Global\'
    else
      Result := 'Local\';
  end;

var
	Erreur  : Integer;    //R�cup�re l'erreur du mutex
  AppName : String;     //Nom de l'application utilis� pour la cr�ation du mutex

  Wnd  : HWND;
  sTmp : String;
BEGIN
  result := true;

  //contr�le du lancement de l'application
  SetLastError(NO_ERROR);                             //Vide le tampon d'erreur
  AppName := LowerCase(ExtractFileName(ParamStr(0)));    //Construit le nom du mutex
  CreateMutex (nil, False, PChar(GetMutexPrefix(Global) + AppName));      //Cr�ation du mutex
  Erreur  := GetLastError;                             //R�cup�re les erreurs
  if (Erreur = ERROR_ALREADY_EXISTS) or (Erreur = ERROR_ACCESS_DENIED ) then
  begin
    Result := false;
    sTmp := Application.Title;
    SetWindowText(Application.Handle, '');

    // attention ne marche pas quand il y a MainFormOnTaskbar = True dans le dpr  ( a voir)
    Wnd := FindWindow('TApplication', PChar(sTmp));
    if Wnd<>0 then
    begin
      if IsIconic(Wnd) then
        ShowWindow(Wnd, SW_RESTORE)
      else
        SetForeGroundWindow (Wnd);
    end;
  end;
end;

end.
