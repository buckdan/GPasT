{ Fichier d'impl�mentation invocable pour TJetonLaunch impl�mentant IJetonLaunch }

unit JetonLaunchImpl;

interface

uses InvokeRegistry,
  Types,
  XSBuiltIns,
  // Uses perso
  Dialogs,
  Forms,
  SysUtils,
  DateUtils,
  // Fin uses perso
  JetonLaunchIntf;

type

  { TJetonLaunch }
  TJetonLaunch = class(TInvokableClass, IJetonLaunch)
  public
    function echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function echoDouble(const Value: Double): Double; stdcall;
    function GetToken(const ANomClient, ASender: string): string; stdcall;
    procedure FreeToken(const ANomClient, ASender: string); stdcall;
  private
  end;

implementation

uses Ginkoia_Dm;

function TJetonLaunch.echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
begin
  { TODO : Impl�menter la m�thode echoEnum }
  Result := Value;
end;

function TJetonLaunch.echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
begin
  { TODO : Impl�menter la m�thode echoDoubleArray }
  Result := Value;
end;

function TJetonLaunch.echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
begin
  { TODO : Impl�menter la m�thode echoMyEmployee }
  Result := TMyEmployee.Create;
end;

procedure TJetonLaunch.FreeToken(const ANomClient, ASender: string);
var
  dmGinkoia: TDm_Ginkoia; // Pointeur vers le Dm_Ginkoia instanci� pour la connexion
  sPathDB  : String;      // Chemin vers la base de donn�e � connecter
  sMessage : string;      // Message d'erreur en cas d'erreur
begin
  dmGinkoia := TDm_Ginkoia.Create(Nil);
  try
    // Se connecter a la base
    if dmGinkoia.ConnectDB(ANomClient, ASender, sMessage) >= 0 then
    begin
      // On lib�re le jeton
      dmGinkoia.DelToken
    end;
    dmGinkoia.DisconnectDB;
  finally
    FreeAndNil(dmGinkoia);
  end;
end;

function TJetonLaunch.GetToken(const ANomClient, ASender: string): string;
var
  dmGinkoia: TDm_Ginkoia; // Pointeur vers le Dm_Ginkoia instanci� pour la connexion
  sPathDB  : String;      // Chemin vers la base de donn�e � connecter
  sMessage : string;      // Message d'erreur en cas d'erreur
//  iBasJetons : integer;   // Contient
begin
  dmGinkoia := TDm_Ginkoia.Create(Nil);
  try
    // Se connecter a la base
    if dmGinkoia.ConnectDB(ANomClient, ASender, sMessage) >= 0 then
    begin
      // On est connect� on peut utiliser les query
      IF dmGinkoia.BasID <> 0 THEN
      BEGIN
        // On v�rifie si on peut prendre un jeton
        if dmGinkoia.CanGetToken then
        begin
          // Jeton pris ou rafraichi
          Result := 'OK';
        end
        else begin
          // Occup�
          Result := 'ERR-OQP';
        end;
      END
      else begin
        // Normalement impossible, il y'a donc un pb de config du launcher ou du fichier provider on logge
        Result := 'ERR-PRM';
      end;
      dmGinkoia.DisconnectDB;
    end
    else begin
      // Erreur de connexion
      Result := 'ERR-CNX';
    end;
  finally
    FreeAndNil(dmGinkoia);
  end;

end;

function TJetonLaunch.echoDouble(const Value: Double): Double; stdcall;
begin
  { TODO : Impl�menter la m�thode echoDouble }
  Result := Value;
end;

initialization

{ Les classes invocables doivent �tre enregistr�es }
InvRegistry.RegisterInvokableClass(TJetonLaunch);

end.
