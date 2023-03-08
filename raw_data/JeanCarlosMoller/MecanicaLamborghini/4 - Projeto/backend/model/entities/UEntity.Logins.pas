unit UEntity.Logins;

interface

type
  TLogin = class
  private
    FLogin: String;
    FSenha: String;
    FToken: String;

    function GetLogin: String;
    function GetSenha: String;
    function GetToken: String;

    procedure SetLogin(const Value: String);
    procedure SetSenha(const Value: String);
    procedure SetToken(const Value: String);

  public
    constructor Create(const aLogin, aSenha: String);

    property Login: String read GetLogin write SetLogin;
    property Senha: String read GetSenha write SetSenha;
    property Token: String read GetToken write SetToken;
  end;

implementation

{ TLogin }

constructor TLogin.Create(const aLogin, aSenha: String);
begin
  FLogin := aLogin;
  FSenha := aSenha;
end;

function TLogin.GetLogin: String;
begin
  Result := FLogin;
end;

function TLogin.GetSenha: String;
begin
  Result := FSenha;
end;

function TLogin.GetToken: String;
begin
  Result := FToken;
end;

procedure TLogin.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TLogin.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

procedure TLogin.SetToken(const Value: String);
begin
  FToken := Value;
end;

end.
