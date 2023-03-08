unit UPostXE7;

interface

uses
  Vcl.Forms,
  Winapi.windows,
  Vcl.StdCtrls,
  System.Classes,
  System.SysUtils,
  IdHTTP,
  Datasnap.DBClient;

type
  TPostData = class
  private
    FLeschamps: tstringlist;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    procedure Add(nom, valeur: string);
    procedure Clear;
    function PostWaitTimeOut(clt: TIdHTTP; url: string; timeout: integer; Reponse : TStream; Memo: TMemo = nil): boolean;
  end;

  TConnexion = class
  private
    Base : string;
    clt : TIdHTTP;
  public
    constructor Create(); reintroduce;
    destructor Destroy(); override;

    function traitechaine(s: string): string;
    function Select(Qry: string; Memo: TMemo = nil): TstringList;
    function ordre(qry: string; Memo: TMemo = nil): boolean;
    function insert(qry: string; Memo: TMemo = nil): integer;
    procedure FreeResult(ts: tstringlist);
    function recordCount(ts: tstringlist): integer;
    function UneValeur(ts: tstringlist; col: string; Num: integer = 0): string;
    function UneValeurEntiere(ts: tstringlist; col: string; Num: integer = 0): Integer;
    function DateTime(D: TdateTime): string;
    procedure remplie(qry: string; mem: TClientDataset);

    function HTMLEncode(astr: String): String;
    function HTMLDecode(astr: String; SkipXml : boolean = true): String;
  end;

implementation

uses
  System.Variants,
  Xml.XMLIntf,
  Xml.XMLDoc,
  Data.DB,
  UXmlUtils;

const
  URL_SERVEUR = 'ginkoia.yellis.net';

{ TPostData }

constructor TPostData.Create();
begin
  inherited Create();
  FLeschamps := TStringList.Create();
end;

destructor TPostData.Destroy();
begin
  FreeAndNil(FLeschamps);
  inherited Destroy();
end;

procedure TPostData.Add(nom, valeur: string);
begin
  FLeschamps.Values[nom] := valeur;
end;

procedure TPostData.Clear();
begin
  FLeschamps.Clear();
end;

function TPostData.PostWaitTimeOut(clt : TIdHTTP; url : string; timeout: integer; Reponse : TStream; Memo: TMemo = nil): boolean;
var
  RequeteString, Tag : AnsiString;
  i : integer;
  Requete : TMemoryStream;
begin
  result := false;

  randomize();
  tag := '_MOI' + AnsiString(IntToStr(Random(999999) + 1)) + '_';
  RequeteString := '';
  for i := 0 to FLeschamps.Count - 1 do
    RequeteString := RequeteString + '--' + tag + #13#10
                   + 'Content-Disposition: form-data; name="' + AnsiString(FLeschamps.Names[i]) + '"'#13#10#13#10
                   + AnsiString(FLeschamps.Values[FLeschamps.Names[i]]) + #13#10;
  RequeteString := RequeteString + '--' + tag + '--'#13#10;

  try
    Requete := tmemorystream.create;
    Requete.Write(pointer(RequeteString)^, length(RequeteString));
    Requete.seek(soFromBeginning, 0);

    if memo <> nil then
      memo.lines.add(String(RequeteString));

    clt.Request.Clear();
    clt.Request.Method := 'POST';
    clt.Request.ContentType := 'multipart/form-data;boundary="' + String(tag) + '"';
    clt.Request.ContentLength := length(RequeteString);

    clt.ReadTimeout := timeout;

    try
      clt.Post(url, Requete, Reponse);
      result := true;
    except
      on e : Exception do
        Reponse.Write(pointer(e.Message)^, length(e.Message))
    end;
  finally
    FreeAndNil(Requete);
  end;
end;

{ TConnexion }

constructor TConnexion.Create();
begin
  inherited Create();
  Base := '';
  clt := TIdHTTP.create(nil);
end;

destructor TConnexion.Destroy();
begin
  FreeAndNil(clt);
  inherited;
end;

// utils ??

function TConnexion.DateTime(D: TdateTime): string;
begin
  result := FormatDateTime('yyyy-mm-dd hh:nn:ss', D);
end;

procedure TConnexion.FreeResult(ts: tstringlist);
var
  i: integer;
begin
  for i := 0 to ts.count - 1 do
    tstringlist(ts.Objects[i]).free;
  ts.free;
end;

function TConnexion.recordCount(ts: tstringlist): integer;
begin
  if ts.Count = 0 then
    result := 0
  else
  begin
    result := tstringlist(ts.objects[0]).count;
  end;
end;

procedure TConnexion.remplie(qry: string; mem: TClientDataset);
var
  result: tstringlist;
  i: integer;
  j: integer;
begin
  mem.close;
  mem.open;
  result := Select(qry);
  for i := 0 to recordCount(result) - 1 do
  begin
    mem.Append;
    for j := 1 to mem.FieldCount - 1 do
      mem.fields[j].AsString := UneValeur(result, mem.fields[j].FieldName, i);
    mem.post;
  end;
  FreeResult(result);
  mem.first;
end;

function TConnexion.traitechaine(s: string): string;
var
  i: integer;
begin
  while pos('\', s) > 0 do
  begin
    s[pos('\', s)] := '�';
  end;
  while pos('�', s) > 0 do
  begin
    i := pos('�', s);
    s[i] := '\';
    system.insert('\', S, i);
  end;
  result := S;
end;

// requetage

function TConnexion.insert(qry: string; Memo: TMemo = nil): integer;
var
  tpd: TPostData;
  Body: TStringStream;
  s: string;
  i: integer;
  XmlDoc : IXMLDocument;
  NodeResult : IXMLNode;
begin
  Result := -1;
  tpd := nil;
  Body := nil;
  qry := traitechaine(qry);
  if memo <> nil then
    memo.Lines.add(qry);
  for i := 1 to 5 do
  begin
    try
      tpd := TPostData.create;
      Body := TStringStream.Create('');

      if base <> '' then
        tpd.add('db', base);
      tpd.add('action', 'QRY');
      tpd.add('qry1', qry);
      if tpd.PostWaitTimeOut(clt, 'http://' + URL_SERVEUR + '/admin/base.php', 30000, Body) then
      begin
        S := BODY.DataString;
        if pos('<HTML>', Uppercase(S)) > 0 then
        begin
          if memo <> nil then
            memo.lines.add(s);
          S := '';
        end;
      end
      else
        s := '';
    finally
      FreeAndNil(tpd);
      FreeAndNil(Body);
    end;

    if trim(S) <> '' then
      BREAK;
    Application.processmessages;
  end;
  if trim(s) = '' then
  begin
{$IFDEF debug}
    application.messagebox('Cha�ne vide en r�ponse', 'Probl�me', MB_OK);
{$ELSE}
    halt;
{$ENDIF}
  end;
  if memo <> nil then
    memo.Lines.add(S);
  XmlDoc := TXMLDocument.Create(nil);
  XmlDoc.XML.Text := S;
  XmlDoc.Active := true;
  NodeResult := GetRootNodeFromName('qry1', XmlDoc);
  if assigned(NodeResult) then
    result := NodeResult.NodeValue;
end;

function TConnexion.ordre(qry: string; Memo: TMemo = nil): boolean;
var
  tpd: TPostData;
  Body: TStringStream;
  s: string;
  i: integer;
  XmlDoc : IXMLDocument;
  NodeResult : IXMLNode;
begin
  tpd := nil;
  Body := nil;
  qry := traitechaine(qry);
  if memo <> nil then
    memo.Lines.add(qry);
  for i := 1 to 5 do
  begin
    try
      tpd := TPostData.create;
      Body := TStringStream.Create('');

      if base <> '' then
        tpd.add('db', base);
      tpd.add('action', 'QRY');
      tpd.add('qry1', qry);
      if tpd.PostWaitTimeOut(clt, 'http://' + URL_SERVEUR + '/admin/base.php', 30000, Body) then
      begin
        S := BODY.DataString;
        if pos('<HTML>', Uppercase(S)) > 0 then
          S := '';
      end
      else
        s := '';
    finally
      FreeAndNil(tpd);
      FreeAndNil(Body);
    end;

    if trim(S) <> '' then
      BREAK;
    Application.processmessages;
  end;
  if trim(s) = '' then
  begin
{$IFDEF debug}
    application.messagebox('Cha�ne vide en r�ponse', 'Probl�me', MB_OK);
{$ELSE}
    halt;
{$ENDIF}
  end;
  if memo <> nil then
    memo.Lines.add(S);
  XmlDoc := TXMLDocument.Create(nil);
  XmlDoc.XML.Text := S;
  XmlDoc.Active := true;
  NodeResult := GetRootNodeFromName('RESULT', XmlDoc);
  result := assigned(NodeResult) and (NodeResult.NodeValue = 'OK');
end;

function TConnexion.Select(Qry: string; Memo: TMemo = nil): TstringList;
var
  tpd: TPostData;
  Body: TStringStream;
  s : string;
  i, j, idx : integer;
  XmlDoc : IXMLDocument;
  NodeResult, NodeNbLigne, NodeLignes : IXMLNode;
begin
  qry := traitechaine(qry);
  tpd := nil;
  Body := nil;
  result := TStringList.Create;
  if Memo <> nil then
    Memo.Lines.Add(qry);
  for i := 1 to 5 do
  begin
    try
      tpd := TPostData.create;
      Body := TStringStream.Create('');

      if base <> '' then
        tpd.add('db', base);
      tpd.add('action', 'SEL');
      tpd.add('sel', qry);
      if tpd.PostWaitTimeOut(clt, 'http://' + URL_SERVEUR + '/admin/base.php', 30000, Body, Memo) then
      begin
        S := BODY.DataString;
        if pos('<HTML>', Uppercase(S)) > 0 then
        begin
          if memo <> nil then
          begin
            memo.lines.add(s);
          end;
          S := '';
        end;
      end
      else
      begin
        S := '';
        if memo <> nil then
        begin
          memo.lines.add('Time Out');
        end;
      end;
    finally
      FreeAndNil(tpd);
      FreeAndNil(Body);
    end;

    if trim(S) <> '' then
      BREAK;
    Application.processmessages;
  end;
  if trim(s) = '' then
  begin
{$IFDEF debug}
    application.messagebox('Cha�ne vide en r�ponse', 'Probl�me', MB_OK);
{$ENDIF}
  end;
  if memo <> nil then
    memo.Lines.add(S);

  S := HtmlDecode(S);

  XmlDoc := TXMLDocument.Create(nil);
  XmlDoc.XML.Text := S;
  XmlDoc.Active := true;
  NodeResult := GetRootNodeFromName('RESULT', XmlDoc);
  if assigned(NodeResult) and (NodeResult.NodeValue = 'OK') then
  begin
    NodeNbLigne  := GetRootNodeFromName('NBLIGNE', XmlDoc);
    if Assigned(NodeNbLigne) and (NodeNbLigne.NodeValue > 0) then
    begin
      NodeLignes := GetRootNodeFromName('LIGNES', XmlDoc);
      if Assigned(NodeLignes) then
      begin
        // recup des entete
        for i := 0 to NodeLignes.ChildNodes[0].ChildNodes.Count -1 do
          result.AddObject(NodeLignes.ChildNodes[0].ChildNodes[i].NodeName, TstringList.create());
        // recup des lignes
        for i := 0 to NodeLignes.ChildNodes.Count -1 do
        begin
          for j := 0 to NodeLignes.ChildNodes[i].ChildNodes.Count -1 do
          begin
            idx := Result.IndexOf(NodeLignes.ChildNodes[i].ChildNodes[j].NodeName);
            if VarIsNull(NodeLignes.ChildNodes[i].ChildNodes[j].NodeValue) then
              TstringList(result.Objects[idx]).add('NULL')
            else
              TstringList(result.Objects[idx]).add(NodeLignes.ChildNodes[i].ChildNodes[j].NodeValue);
          end;
        end;
      end;
    end;
  end;
end;

// accesseur au valeur

function TConnexion.UneValeur(ts: tstringlist; col: string; Num: integer = 0): string;
begin
  if ts.indexof(col) > -1 then
    result := tstringlist(ts.objects[ts.indexof(col)]).strings[num]
  else
    result := '';
end;

function TConnexion.UneValeurEntiere(ts: tstringlist; col: string; Num: integer): Integer;
var
  S: string;
begin
  S := UneValeur(ts, col, Num);
  if s = '' then
    result := 0
  else
    result := Strtoint(UneValeur(ts, col, Num));
end;

// encodage et decodage

function TConnexion.HTMLEncode(astr: String): String;
begin
  Result := astr;
  Result := StringReplace(Result, '"', '&quot;',    [rfReplaceAll]);
  Result := StringReplace(Result, '&', '&amp;',     [rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;',      [rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;',      [rfReplaceAll]);
  Result := StringReplace(Result, ' ', '&nbsp;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&iexcl;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&cent;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&pound;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&curren;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&yen;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&brvbar;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&sect;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&uml;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&copy;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ordf;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&laquo;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&not;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&shy;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&reg;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&macr;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&deg;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&plusmn;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&sup2;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&sup3;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&acute;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&micro;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&para;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&middot;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&cedil;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&sup1;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ordm;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&raquo;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&frac14;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&frac12;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&frac34;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&iquest;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Agrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Aacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Acirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Atilde;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Auml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Aring;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&AElig;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ccedil;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Egrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Eacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ecirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Euml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Igrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Iacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Icirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Iuml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ETH;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ntilde;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ograve;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Oacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ocirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Otilde;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ouml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&times;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Oslash;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ugrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Uacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Ucirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Uuml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&Yacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&THORN;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&szlig;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&agrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&aacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&acirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&atilde;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&auml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&aring;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&aelig;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ccedil;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&egrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&eacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ecirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&euml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&igrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&iacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&icirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&iuml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&eth;',     [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ntilde;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ograve;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&oacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ocirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&otilde;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ouml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&divide;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&oslash;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ugrave;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&uacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&ucirc;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&uuml;',    [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&yacute;',  [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&thorn;',   [rfReplaceAll]);
  Result := StringReplace(Result, '�', '&yuml;',    [rfReplaceAll]);
end;

function TConnexion.HTMLDecode(astr: String; SkipXml : boolean): String;
begin
  Result := astr;
  if not SkipXml then
  begin
    Result := StringReplace(Result, '&quot;',    '"', [rfReplaceAll]);
    Result := StringReplace(Result, '&amp;',     '&', [rfReplaceAll]);
  end;
  Result := StringReplace(Result, '&lt;',      '<', [rfReplaceAll]);
  Result := StringReplace(Result, '&gt;',      '>', [rfReplaceAll]);
  Result := StringReplace(Result, '&nbsp;',    ' ', [rfReplaceAll]);
  Result := StringReplace(Result, '&iexcl;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&cent;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&pound;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&curren;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&yen;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&brvbar;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&sect;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&uml;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&copy;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ordf;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&laquo;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&not;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&shy;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&reg;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&macr;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&deg;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&plusmn;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&sup2;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&sup3;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&acute;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&micro;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&para;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&middot;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&cedil;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&sup1;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ordm;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&raquo;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&frac14;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&frac12;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&frac34;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&iquest;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Agrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Aacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Acirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Atilde;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Auml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Aring;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&AElig;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ccedil;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Egrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Eacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ecirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Euml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Igrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Iacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Icirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Iuml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ETH;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ntilde;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ograve;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Oacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ocirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Otilde;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ouml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&times;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Oslash;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ugrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Uacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Ucirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Uuml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&Yacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&THORN;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&szlig;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&agrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&aacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&acirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&atilde;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&auml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&aring;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&aelig;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ccedil;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&egrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&eacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ecirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&euml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&igrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&iacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&icirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&iuml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&eth;',     '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ntilde;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ograve;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&oacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ocirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&otilde;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ouml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&divide;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&oslash;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ugrave;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&uacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&ucirc;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&uuml;',    '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&yacute;',  '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&thorn;',   '�', [rfReplaceAll]);
  Result := StringReplace(Result, '&yuml;',    '�', [rfReplaceAll]);
end;

end.

