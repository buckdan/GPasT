unit UService.Servico;

interface

Uses
  UService.Base,
  Generics.Collections,
  UEntity.Servicos;

type
  TServiceServico = class(TServiceBase)
  private
    FServico: TServico;
    FServicos: TObjectList<TServico>;

    function GetServicos: TObjectList<TServico>;

    procedure PreencherServicos(const aJsonServicos: String);

  public
    constructor Create; overload;
    constructor Create(aServico: TServico); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;

    property Servicos: TObjectList<TServico> read GetServicos;
  end;

implementation

uses
  System.SysUtils,
  REST.Types,
  UService.Intf,
  UUtils.Constants,
  DataSet.Serialize,
  FireDAC.Comp.Client,
  UUtils.Functions;

{ TServiceServico }

constructor TServiceServico.Create;
begin
  Inherited Create;

  FServicos := TObjectList<TServico>.Create;
end;

constructor TServiceServico.Create(aServico: TServico);
begin
  FServico := aServico;
  Self.Create;
end;

destructor TServiceServico.Destroy;
begin
  FreeAndNil(FServico);
  FreeAndNil(FServicos);
  inherited;
end;

procedure TServiceServico.Excluir;
begin
  if (not Assigned(FServico)) or (FServico.Id = 0) then
    raise Exception.Create('Nenhum Servico foi escolhido para exclus�o.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_SERVICO + '/%d', [FServico.Id]);
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

function TServiceServico.GetServicos: TObjectList<TServico>;
begin
  Result := FServicos;
end;

procedure TServiceServico.Listar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_SERVICO;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherServicos(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
    else
      raise Exception.Create
        ('Erro ao carregar a lista de Servi�os. C�digo do Erro: ' +
        FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceServico.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //M�todo sem implementa��o no momento
end;

procedure TServiceServico.PreencherServicos(const aJsonServicos: String);
begin
 //
end;

procedure TServiceServico.Registrar;
begin
   try
    FRESTClient.BaseURL := URL_BASE_SERVICO;
    FRESTRequest.Params.AddBody(FServico.JSON);
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
