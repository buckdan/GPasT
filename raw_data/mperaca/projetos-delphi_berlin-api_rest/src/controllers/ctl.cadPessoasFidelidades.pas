unit ctl.cadPessoasFidelidades;

interface

uses Horse, Horse.GBSwagger, System.UITypes,
     System.SysUtils, Vcl.Dialogs, System.JSON, DataSet.Serialize, Data.DB;

procedure Registry;

implementation

uses prv.dataModuleConexao, dat.cadPessoasFidelidades;


procedure ListaTodasFidelidades(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var wlista: TJSONArray;
    wval: string;
    wret,werro: TJSONObject;
    widempresa,widpessoa: integer;
    wconexao: TProviderDataModuleConexao;
begin
  try
    widpessoa     := Req.Params['idpessoa'].ToInteger; // recupera o id da Pessoa
    wconexao      := TProviderDataModuleConexao.Create(nil);
    widempresa    := wconexao.FIdEmpresa; //id empresa do arquivo TrabinApi.ini
    wlista := TJSONArray.Create;
    wlista := dat.cadPessoasFidelidades.RetornaListaFidelidades(Req.Query,widpessoa);
    wret   := wlista.Get(0) as TJSONObject;
    if wret.TryGetValue('status',wval) then
       Res.Send<TJSONArray>(wlista).Status(400)
    else
       Res.Send<TJSONArray>(wlista).Status(200);
  except
    On E: Exception do
    begin
      werro := TJSONObject.Create;
      werro.AddPair('status','500');
      werro.AddPair('description',E.Message);
      werro.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
    end;
  end;
end;

procedure CriaFidelidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var wFidelidade,wnewFidelidade,wresp,werro: TJSONObject;
    wval: string;
    widempresa,widpessoa: integer;
    wconexao: TProviderDataModuleConexao;
begin
  try
    widpessoa     := Req.Params['idpessoa'].ToInteger; // recupera o id da Fidelidade
    wFidelidade   := TJSONObject.Create;
    wnewFidelidade:= TJSONObject.Create;
    wresp         := TJSONObject.Create;
    wFidelidade   := Req.Body<TJSONObject>;
    wconexao      := TProviderDataModuleConexao.Create(nil);
    widempresa    := wconexao.FIdEmpresa; //id empresa do arquivo TrabinApi.ini

    if widempresa=0 then
       begin
         wresp.AddPair('status','405');
         wresp.AddPair('description','idempresa n�o definido');
         wresp.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
         Res.Send<TJSONObject>(wresp).Status(405);
       end
    else if dat.cadPessoasFidelidades.VerificaRequisicao(wFidelidade) then
       begin
         wnewFidelidade := dat.cadPessoasFidelidades.IncluiFidelidade(wFidelidade,widpessoa);
         if wnewFidelidade.TryGetValue('status',wval) then
            Res.Send<TJSONObject>(wnewFidelidade).Status(400)
         else
            Res.Send<TJSONObject>(wnewFidelidade).Status(201);
       end
    else
       begin
         wresp.AddPair('status','405');
         wresp.AddPair('description','JSON preenchido incorretamente');
         wresp.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
         Res.Send<TJSONObject>(wresp).Status(405);
       end;
  except
    On E: Exception do
    begin
      werro := TJSONObject.Create;
      werro.AddPair('status','500');
      werro.AddPair('description',E.Message);
      werro.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
    end;
  end;
end;

procedure AlteraFidelidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var wFidelidade,wnewFidelidade,wresp,werro: TJSONObject;
    wid,widpessoa: integer;
    wval: string;
begin
  try
    wnewFidelidade  := TJSONObject.Create;
    wFidelidade     := TJSONObject.Create;
    wresp           := TJSONObject.Create;
    widpessoa       := Req.Params['idpessoa'].ToInteger; // recupera o id da Pessoa
    wid             := Req.Params['id'].ToInteger; // recupera o id da Devolu��o
    wFidelidade     := Req.Body<TJSONObject>;
    wnewFidelidade  := dat.cadPessoasFidelidades.AlteraFidelidade(wid,wFidelidade);
    if wnewFidelidade.TryGetValue('data',wval) then
       begin
         wnewFidelidade.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
         Res.Send<TJSONObject>(wnewFidelidade).Status(200);
       end
    else
       begin
         wresp.AddPair('status','400');
         wresp.AddPair('description','Fidelidade n�o encontrada');
         wresp.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
         Res.Send<TJSONObject>(wresp).Status(400);
       end;
  except
    On E: Exception do
    begin
      werro := TJSONObject.Create;
      werro.AddPair('status','500');
      werro.AddPair('description',E.Message);
      werro.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
    end;
  end;
end;

procedure ExcluiFidelidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var wid,widpessoa: integer;
    wret,werro: TJSONObject;
begin
  try
    wid       := Req.Params['id'].ToInteger; // recupera o id do Dependente
    widpessoa := Req.Params['idpessoa'].ToInteger; // recupera o id da Pessoa
    if wid>0 then
       begin
         wret := TJSONObject.Create;
         wret := dat.cadPessoasFidelidades.ApagaFidelidade(wid);
         if wret.GetValue('status').Value='200' then
            Res.Send<TJSONObject>(wret).Status(200)
         else
            Res.Send<TJSONObject>(wret).Status(400);
       end;
  except
    On E: Exception do
    begin
      werro := TJSONObject.Create;
      werro.AddPair('status','500');
      werro.AddPair('description',E.Message);
      werro.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
    end;
  end;
end;

procedure RetornaFidelidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var wFidelidade,werro: TJSONObject;
    wid: integer;
    wval: string;
begin
  try
    wid           := Req.Params['id'].ToInteger; // recupera o id da Fidelidade
    wFidelidade   := TJSONObject.Create;
    wFidelidade   := Req.Body<TJSONObject>;
    wFidelidade   := dat.cadPessoasFidelidades.RetornaFidelidade(wid);
    if wFidelidade.TryGetValue('status',wval) then
       Res.Send<TJSONObject>(wFidelidade).Status(400)
    else
       Res.Send<TJSONObject>(wFidelidade).Status(200);
  except
    On E: Exception do
    begin
      werro := TJSONObject.Create;
      werro.AddPair('status','500');
      werro.AddPair('description',E.Message);
      werro.AddPair('datetime',formatdatetime('yyyy-mm-dd hh:nn:ss',now));
    end;
  end;
end;

procedure Registry;
begin
// M�todo Get
  THorse.Get('/trabinapi/cadastros/pessoas/:idpessoa/fidelidades',ListaTodasFidelidades);
  THorse.Get('/trabinapi/cadastros/pessoas/:idpessoa/fidelidades/:id',RetornaFidelidade);

// M�todo Post
  THorse.Post('/trabinapi/cadastros/pessoas/:idpessoa/fidelidades',CriaFidelidade);

  // M�todo Put
  THorse.Put('/trabinapi/cadastros/pessoas/:idpessoa/fidelidades/:id',AlteraFidelidade);

// M�todo Delete
  THorse.Delete('/trabinapi/cadastros/pessoas/:idpessoa/fidelidades/:id',ExcluiFidelidade);
end;

initialization

// defini��o da documenta��o
  Swagger
    .BasePath('trabinapi')
    .Path('cadastros/categorias')
      .Tag('AliquotasICM')
      .GET('Listar Categorias')
//        .AddResponse(200, 'Lista de Al�quotas').Schema(TAliquotas).IsArray(True).&End
      .&End
      .POST('Criar uma nova Categoria')
//        .AddParamBody('Dados da Al�quota').Required(True).Schema(TAliquotas).&End
        .AddParamQuery('codigo', 'C�digo').&End
        .AddParamQuery('descricao', 'Descri��o').&End
        .AddParamQuery('percentual', 'Percentual').&End
        .AddParamQuery('percentualsc', 'Percentual SC').&End
        .AddParamQuery('percentualsp', 'Percentual SP').&End
        .AddParamQuery('basecalculo', 'Base de C�lculo').&End
        .AddParamQuery('somaoutros', 'Soma Outros').&End
        .AddParamQuery('somaisentos', 'Soma Isentos').&End
//        .AddResponse(201).Schema(TAliquotas).&End
        .AddResponse(400).&End
      .&End
    .&End
    .Path('cadastros/categorias/{id}')
      .Tag('Categorias')
      .GET('Obter os dados de uma Categoria espec�fica')
        .AddParamPath('id', 'Id').&End
//        .AddResponse(200, 'Dados da Al�quota').Schema(TAliquotas).&End
        .AddResponse(404).&End
      .&End
      .PUT('Alterar os dados de uma Categoria espec�fica')
        .AddParamPath('id', 'Id').&End
        .AddParamQuery('codigo', 'C�digo').&End
        .AddParamQuery('descricao', 'Descri��o').&End
        .AddParamQuery('percentual', 'Percentual').&End
        .AddParamQuery('percentualsc', 'Percentual SC').&End
        .AddParamQuery('percentualsp', 'Percentual SP').&End
        .AddParamQuery('basecalculo', 'Base de C�lculo').&End
        .AddParamQuery('somaoutros', 'Soma Outros').&End
        .AddParamQuery('somaisentos', 'Soma Isentos').&End
//        .AddParamBody('Dados da Al�quota').Required(True).Schema(TAliquotas).&End
        .AddResponse(200).&End
        .AddResponse(400).&End
        .AddResponse(404).&End
      .&End
      .DELETE('Excluir Categoria')
        .AddParamPath('id', 'Id').&End
        .AddResponse(204).&End
        .AddResponse(400).&End
        .AddResponse(404).&End
      .&End
    .&End
  .&End;

end.
