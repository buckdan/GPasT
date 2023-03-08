unit UUtils.Constants;

interface

uses
  System.SysUtils;

const
  URL_BASE_LOGIN       = 'http://localhost:9000/v1/login';
  URL_BASE_USUARIO     = 'http://localhost:9000/v1/usuarios';
  URL_BASE_SERVICO     = 'http://localhost:9000/v1/servicos';
  URL_BASE_CARRO       = 'http://localhost:9000/v1/carros';
  URL_BASE_PECA        = 'http://localhost:9000/v1/pecas';
  URL_BASE_ITEMSERVICO = 'http://localhost:9000/v1/itemservico';
  URL_BASE_ORCAMENTO   = 'http://localhost:9000/v1/orcamentos';
  URL_BASE_ITEMPECA    = 'http://localhost:9000/v1/pecas';

  API_SUCESSO = 200;
  API_CRIADO = 201;
  API_SUCESSO_SEM_RETORNO = 204;
  API_NAO_AUTORIZADO = 401;

implementation

end.
