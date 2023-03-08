unit UService.Carro;

interface

uses
  UService.Base,
  UEntity.Carros,
  UEntity.Usuarios,
  Generics.Collections;

type
  TServiceCarro = class(TServiceBase)
  private
    FCarro: TCarro;
    FCarros: TobjectList<TCarro>;

    function GetCarros: TobjectList<TCarro>;

    procedure PreencherCarros(const aJsonCarros: String);
    procedure PreencherUsuario(const aJsonUsuario: String;
      var aUsuario: TUsuario);

  public
    constructor Create; overload;
    constructor Create(aCarro: TCarro); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;

    property Carros: TobjectList<TCarro> read GetCarros;

  end;

implementation

uses
  System.SysUtils,
  REST.Types,
  UUtils.Constants,
  FireDAC.comp.Client,
  Dataset.Serialize,
  UService.Intf,
  UUtils.Functions;

{ TServiceCarro }

procedure TServiceCarro.PreencherCarros(const aJsonCarros: String);
var
  xMemTable: TFDMemTable;
  xMemTableUsuario: TFDMemTable;
  xUsuario: TUsuario;
begin
  FCarros.Clear;

  xMemTable := TFDMemTable.Create(nil);
  xMemTableUsuario := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(FRESTResponse.Content);

    while not xMemTable.Eof do
    begin
      xMemTableUsuario.LoadFromJSON(xMemTable.FieldByName('usuario').AsString);

      xUsuario := TUsuario.Create(
        xMemTableUsuario.FieldByName('id').AsInteger,
        xMemTableUsuario.FieldByName('tipouser').AsString,
        xMemTableUsuario.FieldByName('nome').AsString,
        xMemTableUsuario.FieldByName('cpf').AsString,
        xMemTableUsuario.FieldByName('celular').AsString,
        xMemTableUsuario.FieldByName('email').AsString,
        xMemTableUsuario.FieldByName('login').AsString,
        xMemTableUsuario.FieldByName('senha').AsString);

      FCarros.Add(TCarro.Create(xMemTable.FieldByName('id').AsInteger,
                                xMemTable.FieldByName('ano').AsInteger,
                                xMemTable.FieldByName('modelo').AsString,
                                xMemTable.FieldByName('cor').AsString,
                                xMemTable.FieldByName('placa').AsString,
                                xMemTable.FieldByName('marca').AsString,
                                xUsuario));
      xMemTable.Next;
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableUsuario);
  end;
end;

procedure TServiceCarro.PreencherUsuario(const aJsonUsuario: String; var aUsuario: TUsuario);
begin
//
end;

constructor TServiceCarro.Create;
begin
  Inherited Create;
  FCarros := TobjectList<TCarro>.Create;
end;

constructor TServiceCarro.Create(aCarro: TCarro);
begin
  FCarro := aCarro;
  Self.Create;
end;

destructor TServiceCarro.Destroy;
begin
  FreeAndNil(FCarro);
  FreeAndNil(FCarros);
  inherited;
end;

procedure TServiceCarro.Excluir;
begin
  if (not Assigned(FCarro)) or (FCarro.Id = 0) then
    raise Exception.Create('Nenhum Carro foi escolhido para exclus�o.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_CARRO + '/%d', [FCarro.Id]);
    FRESTRequest.Method := rmDelete;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO_SEM_RETORNO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
    else
      raise Exception.Create('Erro n�o catalogado.');
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceCarro.GetCarros: TobjectList<TCarro>;
begin
  Result := FCarros;
end;

procedure TServiceCarro.Listar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_CARRO;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherCarros(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
    else
      raise Exception.Create
        ('Erro ao carregar a lista de Carros. C�digo do Erro: ' +
        FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceCarro.ObterRegistro(const aId: Integer): TObject;
begin
//
end;

procedure TServiceCarro.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_CARRO;
    FRESTRequest.Params.AddBody(FCarro.JSON);
    FRESTRequest.Method := rmPost;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
      else
        raise Exception.Create('Erro n�o catalogado.');
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
