unit UEntity.Usuarios;

interface

uses
  System.JSON;

type
  TUsuario = class
  private

    FId: Integer;
    FTipoUsuario: Boolean;
    FNome: String;
    FCPF: String;
    FCelular: String;
    FEmail: String;
    FLogin: String;
    FSenha: String;
    FJSON: TJSONObject;

    function GetId: Integer;
    function GetTipoUsuario: Boolean;
    function GetNome: String;
    function GetCPF: String;
    function GetCelular: String;
    function GetEmail: String;
    function GetLogin: String;
    function GetSenha: String;
    function GetJSON: TJSONObject;

    procedure SetId(const Value: Integer);
    procedure SetTipoUsuario(const Value: Boolean);
    procedure SetNome(const Value: String);
    procedure SetCPF(const Value: String);
    procedure SetCelular(const Value: String);
    procedure SetEmail(const Value: String);
    procedure SetLogin(const Value: String);
    procedure SetSenha(const Value: String);

  public
    constructor Create; overload;
    constructor Create(const aId: Integer); overload;
    constructor Create(const aNome, aLogin, aSenha: String); overload;
    constructor Create(const aId: Integer; const aTipoUsuario, aNome,
      aCPF: String; const aCelular: String; const aEmail: String;
      const aLogin: String; const aSenha: String); overload;

    destructor Destroy; override;

    property Id: Integer read GetId write SetId;
    property TipoUsuario: Boolean read GetTipoUsuario write SetTipoUsuario;
    property Nome: String read GetNome write SetNome;
    property CPF: String read GetCPF write SetCPF;
    property Celular: String read GetCelular write SetCelular;
    property Email: String read GetEmail write SetEmail;
    property Login: String read GetLogin write SetLogin;
    property Senha: String read GetSenha write SetSenha;

    property JSON: TJSONObject read GetJSON;
  end;

implementation

uses
  SysUtils;

{ TUsuario }

constructor TUsuario.Create;
begin
  FJSON := TJSONObject.Create;
end;

constructor TUsuario.Create(const aId: Integer);
begin
  FId := aId;
  Self.Create;
end;

constructor TUsuario.Create(const aId: Integer; const aTipoUsuario, aNome, aCPF,
  aCelular, aEmail, aLogin, aSenha: String);
begin
  FId          := aId;
  FTipoUsuario := aTipoUsuario.ToBoolean;
  FNome        := aNome;
  FCPF         := aCPF;
  FCelular     := aCelular;
  FEmail       := aEmail;
  FLogin       := aLogin;
  FSenha       := aSenha;

  Self.Create;
end;

constructor TUsuario.Create(const aNome, aLogin, aSenha: String);
begin
  FNome  := aNome;
  FLogin := aLogin;
  FSenha := aSenha;

  Self.Create;
end;

destructor TUsuario.Destroy;
begin
  FreeAndNil(FJSON);
  inherited;
end;

function TUsuario.GetCelular: String;
begin
  Result := FCelular;
end;

function TUsuario.GetCPF: String;
begin
  Result := FCPF;
end;

function TUsuario.GetEmail: String;
begin
  Result := FEmail;
end;

function TUsuario.GetId: Integer;
begin
  Result := FId;
end;

function TUsuario.GetJSON: TJSONObject;
begin
  FJSON.AddPair('id',          FId.ToString);
  FJSON.AddPair('tipousuario', FTipoUsuario.ToString);
  FJSON.AddPair('nome',        FNome);
  FJSON.AddPair('cpf',         FCPF);
  FJSON.AddPair('celular',     FCelular);
  FJSON.AddPair('email',       FEmail);
  FJSON.AddPair('login',       FLogin);
  FJSON.AddPair('senha',       FSenha);
  Result := FJSON;
end;

function TUsuario.GetLogin: String;
begin
  Result := FLogin;
end;

function TUsuario.GetNome: String;
begin
  Result := FNome;
end;

function TUsuario.GetSenha: String;
begin
  Result := FSenha;
end;

function TUsuario.GetTipoUsuario: Boolean;
begin
  Result := FTipoUsuario;
end;

procedure TUsuario.SetCelular(const Value: String);
begin
  FCelular := value;
end;

procedure TUsuario.SetCPF(const Value: String);
begin
  FCPF := value;
end;

procedure TUsuario.SetEmail(const Value: String);
begin
  FEmail := value;
end;

procedure TUsuario.SetId(const Value: Integer);
begin
  FId := Value;
end;

procedure TUsuario.SetLogin(const Value: String);
begin
  FLogin := value;
end;

procedure TUsuario.SetNome(const Value: String);
begin
  FNome := value;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  FSenha := value;
end;


procedure TUsuario.SetTipoUsuario(const Value: Boolean);
begin
  FTipoUsuario := value;
end;

end.
