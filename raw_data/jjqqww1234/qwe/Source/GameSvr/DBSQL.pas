 ////////////////////////////////////////////////////////////////////////////////
 // SQL 로 데이터를 읽는다.
 // 이곳의 함수들은 단일 쓰레드환경을 고려해 에서 제작되었으며
 // SQlEngine 에서만 불려져야한다.
 // MakeData:2004-01-29
 ////////////////////////////////////////////////////////////////////////////////
unit DBSQL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, ADODB, Grobal2, mudutil;

const
  GABOARD_NOTICE_LINE = 3;
  KIND_NOTICE = 0;

type
  // SQL 데이터베이스
  TDBSql = class(TObject)
  private
    FADOConnection: TADOConnection;
    FADOQuery:      TADOQuery;
    FAutoConnectable: boolean;

    FConnFile:     TStringList;
    FConnInfo:     string;
    FFileName:     string;
    FServerName:   string;
    FLastConnTime: TDateTime;
    FLastConnMsec: DWord;

    procedure LoadItemFromDB(pItem: pTMarketLoad; SqlDB: TADOQuery);
    procedure LoadBoardListFromDB(pList: PTGaBoardArticleLoad; SqlDB: TADOQuery);
  public
    constructor Create;
    destructor Destroy; override;

    function Connect(ServerName: string; FileName: string): boolean;
    function ReConnect: boolean;
    procedure DisConnect;

    property AutoConnectable: boolean Read FAutoConnectable Write FAutoConnectable;
    function Connected: boolean;


    //아이템 상점 관련

    //판매 올린 아이템을 한 페이지 읽음(실제로는 더 읽음)
    function LoadPageUserMarket(marketname: string; sellwho: string;
      itemname: string; itemtype: integer; itemset: integer;
      sellitemlist: TList): integer;
    //판매에 추가
    function AddSellUserMarket(psellitem: PTMarketLoad): integer;
    //위탁가능한지 알아본다.
    function ReadyToSell(var Readyitem: PTMarketLoad): integer;
    //물건을 산다.
    function BuyOneUserMarket(var buyitem: PTMarketLoad): integer;
    //자신이 올린 물건을 취소함(다시 찾음)
    function CancelUserMarket(var Cancelitem: PTMarketLoad): integer;
    //판매된 물품의 가격을 회수함
    function GetPayUserMarket(var GetPayitem: PTMarketLoad): integer;

    // 추가 디비 체크
    function ChkAddSellUserMarket(pSearchInfo: PTSearchSellItem;
      IsSucess: boolean): integer;
    // 사기 디비 체크
    function ChkBuyOneUserMarket(pSearchInfo: PTSearchSellItem;
      IsSucess: boolean): integer;
    // 츼소 디비 체크
    function ChkCancelUserMarket(pSearchInfo: PTSearchSellItem;
      IsSucess: boolean): integer;
    // 회수 디비 체크
    function ChkGetPayUserMarket(pSearchInfo: PTSearchSellItem;
      IsSucess: boolean): integer;

    // 장원게시판
    function LoadPageGaBoardList(gname: string; nKind: integer;
      BoardList: TList): integer;
    function AddGaBoardArticle(pArticleLoad: PTGaBoardArticleLoad): integer;
    function DelGaBoardArticle(pArticleLoad: PTGaBoardArticleLoad): integer;
    function EditGaBoardArticle(pArticleLoad: PTGaBoardArticleLoad): integer;

  end;

var
  g_DBSQL: TDBSQL;

implementation

uses
  svMain;

// 생성자
constructor TDBSql.Create;
begin
  FADOConnection := TADOConnection.Create(nil);
  FADOQuery      := TADOQuery.Create(nil);

  FConnFile     := TStringList.Create;
  FConnInfo     := '';
  FLastConnTime := 0;
  FLastConnMSec := 0;

  FAutoConnectable := False;
end;

// 소멸자
destructor TDBSql.Destroy;
begin
  Disconnect;

  FADOConnection.Free;
  FADOQuery.Free;

  FConnFile.Free;
end;

// 데이터 베이스 커넥션
function TDBSql.Connect(ServerName: string; FileName: string): boolean;
begin
  Result := False;

  FFileName   := FileName;
  FServerName := ServerName;

  // Load ODBC Connection Infomations...
  FConnFile.LoadFromFile(FileName);

  //-------------------------------------------
  // 서버이름으로 값을 얻어온다.
  FConnInfo := FConnFile.Values[ServerName];
  //-------------------------------------------

  // 커넥션 정보
  if FConnInfo <> '' then begin
    // Try Connect...
    FADOConnection.ConnectionString := FConnInfo;
    FADOConnection.LoginPrompt := False;
    FADOConnection.Connected := True;
    Result := FADOConnection.Connected;

    if Result = True then begin
      // ADO_Query setting...
      FADOQuery.Active     := False;
      FADOQuery.Connection := FADOConnection;

      FLastConnTime := Now;

      MainOutMessage('SUCCESS DBSQL CONNECTION ');

    end;
  end else begin
    MainOutMessage(ServerName + ' : DBSQL CONNECTION INFO IS NULL!');
  end;

  // 시도된 타이머값 저장
  FlastConnMSec := GetTickCount;

end;

// 다시 접속을 시도한다.. 어떤경우에 의해 접속이 끊어진 경우를 대비
function TDBSql.ReConnect: boolean;
begin
  Result := False;

  // 15 초에 한번씩 다시 리커넥션 해본다.
  if (FlastConnMSec + 15 * 1000) < GetTickCount then begin

    DisConnect;

    MainOutMessage('[TestCode]Try to reconnect with DBSQL');
    Result := Connect(FServerName, FFileName);

    MainOutMessage('CAUTION! DBSQL RECONNECTION');
  end;
end;

// 접속되어 있는지 알아본다.
function TDBSql.Connected: boolean;
begin
  Result := FADOConnection.Connected;
end;

// DB 연결 끊기
procedure TDBSql.DisConnect;
begin

  FAdoQuery.Active := False;
  FADOConnection.Connected := False;

end;

 //==============================================================================
 // 위탁판매 시스템용 데이터 입출력 함수
 //==============================================================================
procedure TDBSql.LoadItemFromDB(pItem: pTMarketLoad; SqlDB: TADOQuery);
var
  k:      integer;
  prefix: string;
begin
  if SqlDB = nil then
    MainOutMessage('[Exception] SqlDB = nil');

  with SqlDB do begin
    pItem.Index     := FieldByName('FLD_SELLINDEX').AsInteger;
    pItem.SellState := FieldByName('FLD_SELLOK').AsInteger;
    pItem.SellWho   := Trim(FieldByName('FLD_SELLWHO').AsString);
    pItem.ItemName  := Trim(FieldByName('FLD_ITEMNAME').AsString);
    pItem.SellPrice := FieldByName('FLD_SELLPRICE').AsInteger;
    pItem.SellDate  :=
      FormatDateTime('YYMMDDHHNNSS', FieldByName('FLD_SELLDATE').AsDateTime);

    //TUserItem
    pItem.UserItem.MakeIndex := FieldByName('FLD_MAKEINDEX').AsInteger;
    pItem.UserItem.Index     := FieldByName('FLD_INDEX').AsInteger;
    pItem.UserItem.Dura      := FieldByName('FLD_DURA').AsInteger;
    pItem.UserItem.DuraMax   := FieldByName('FLD_DURAMAX').AsInteger;
    for k := 0 to 13 do
      pItem.UserItem.Desc[k] := FieldByName('FLD_DESC' + IntToStr(k)).AsInteger;
    pItem.UserItem.ColorR := FieldByName('FLD_COLORR').AsInteger;
    pItem.UserItem.ColorG := FieldByName('FLD_COLORG').AsInteger;
    pItem.UserItem.ColorB := FieldByName('FLD_COLORB').AsInteger;
    prefix := Trim(FieldByName('FLD_PREFIX').AsString);
    StrPCopy(pItem.UserItem.Prefix, prefix);
  end;

end;

//판매 올린 아이템을 한 페이지 읽음(실제로는 더 읽음)
function TDBSql.LoadPageUserMarket(marketname: string; sellwho: string;
  itemname: string; itemtype: integer; itemset: integer; sellitemlist: TList): integer;
var
  SearchStr: string;
  pSellItem: PTMarketLoad;
  i: integer;
begin
  Result := UMResult_Fail;
  with FADOQuery do begin
    if (itemname <> '') then
      SearchStr := 'EXEC UM_LOAD_ITEMNAME ''' + marketname + ''',''' + itemname + ''''
    else if (sellwho <> '') then
      SearchStr := 'EXEC UM_LOAD_USERNAME ''' + marketname + ''',''' + sellwho + ''''
    else if (itemset <> 0) then
      SearchStr := 'EXEC UM_LOAD_ITEMSET ''' + marketname + ''',' + IntToStr(itemset)
    else if (itemtype >= 0) then
      SearchStr := 'EXEC UM_LOAD_ITEMTYPE ''' + marketname + ''',' + IntToStr(itemtype);

    try
      if Active then
        Close;

      SQL.Clear;
      SQL.ADD(SearchStr);

      MainOutMessage('LoadPageUserMarket: ' + SearchStr);

      if not Active then
        Open;
    except
      MainOutMessage('Exception) TFrmSql.LoadPageUserMarket -> Open (' +
        IntToStr(SQL.Count) + ')');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    try
      First;
      for i := 0 to RecordCount - 1 do begin
        new(pSellItem);
        LoadItemFromDB(pSellItem, FADOQuery);
        sellitemlist.Add(pSellItem);
        if not EOF then
          Next;
      end;

      if Active then
        Close;
      Result := UMResult_Success;
    except
      MainOutMessage('Exception) TFrmSql.LoadPageUserMarket -> LoadItemFromDB (' +
        IntToStr(RecordCount) + ')');
      Result := UMResult_ReadFail;
      if Active then
        Close;
    end;

  end;
end;

//판매에 추가
function TDBSql.AddSellUserMarket(psellitem: PTMarketLoad): integer;
var
  i: integer;
begin
  // 등록한뒤에 플레그를 가등록상태로 한다.
  Result := UMResult_Fail;

  with FADOQuery do begin
    SQL.Clear;
    SQL.Add('INSERT INTO TBL_ITEMMARKET (' + 'FLD_MARKETNAME,' +
      'FLD_SELLOK,' + 'FLD_ITEMTYPE,' + 'FLD_ITEMSET,' + 'FLD_ITEMNAME,' +
      'FLD_SELLWHO,' + 'FLD_SELLPRICE,' + 'FLD_SELLDATE,' +
      //                    'FLD_BUYER,'+
      //                    'FLD_BUYDATE,'+
      'FLD_MAKEINDEX,' + 'FLD_INDEX,' + 'FLD_DURA,' + 'FLD_DURAMAX,' +
      'FLD_DESC0,' + 'FLD_DESC1,' + 'FLD_DESC2,' + 'FLD_DESC3,' +
      'FLD_DESC4,' + 'FLD_DESC5,' + 'FLD_DESC6,' + 'FLD_DESC7,' +
      'FLD_DESC8,' + 'FLD_DESC9,' + 'FLD_DESC10,' + 'FLD_DESC11,' +
      'FLD_DESC12,' + 'FLD_DESC13,' + 'FLD_COLORR,' + 'FLD_COLORG,' +
      'FLD_COLORB,' + 'FLD_PREFIX' + ')'
      );
    SQL.Add(' Values(''' + psellitem.MarketName + ''',' + IntToStr(
      MARKEY_DBSELLTYPE_READYSELL) + ',' + // 가등록상태가되야됨 주의
      IntToStr(psellitem.MarketType) + ',' + IntToStr(psellitem.SetType) +
      ',''' + psellitem.ItemName + ''',''' + psellitem.SellWho +
      ''',' + IntToStr(psellitem.SellPrice) + ',' + 'GETDATE(),' +
      IntToStr(psellitem.UserItem.MakeIndex) + ',' +
      IntToStr(psellitem.UserItem.Index) + ',' + IntToStr(psellitem.UserItem.Dura) +
      ',' + IntToStr(psellitem.UserItem.DuraMax) + ',' +
      IntToStr(psellitem.UserItem.Desc[0]) + ',' +
      IntToStr(psellitem.UserItem.Desc[1]) + ',' +
      IntToStr(psellitem.UserItem.Desc[2]) + ',' +
      IntToStr(psellitem.UserItem.Desc[3]) + ',' +
      IntToStr(psellitem.UserItem.Desc[4]) + ',' +
      IntToStr(psellitem.UserItem.Desc[5]) + ',' +
      IntToStr(psellitem.UserItem.Desc[6]) + ',' +
      IntToStr(psellitem.UserItem.Desc[7]) + ',' +
      IntToStr(psellitem.UserItem.Desc[8]) + ',' +
      IntToStr(psellitem.UserItem.Desc[9]) + ',' +
      IntToStr(psellitem.UserItem.Desc[10]) + ',' +
      IntToStr(psellitem.UserItem.Desc[11]) + ',' +
      IntToStr(psellitem.UserItem.Desc[12]) + ',' +
      IntToStr(psellitem.UserItem.Desc[13]) + ',' +
      IntToStr(psellitem.UserItem.ColorR) + ',' +
      IntToStr(psellitem.UserItem.ColorG) + ',' +
      IntToStr(psellitem.UserItem.ColorB) + ',''' +
      string(psellitem.UserItem.Prefix) + '''' + ')'
      );
    try
      ExecSQL;
      Result := UMResult_Success;
    except
      MainOutMessage('Exception) TFrmSql.AddSellUserMarket -> ExecSQL');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
    end;

  end;
end;

//판매 가능한지 알아본다.
function TDBSql.ReadyToSell(var Readyitem: PTMarketLoad): integer;
var
  SearchStr: string;
  i: integer;
begin
  // 물건을 읽어들이고
  // 물건을 가판매 상태로 변경한다.
  Result := UMResult_Fail;
  with FADOQuery do begin
    // SearchQuery...
    SearchStr := 'EXEC UM_READYTOSELL_NEW ''' + ReadyItem.MarketName +
      ''',''' + ReadyItem.SellWho + '''';

    try
      if Active then
        Close;

      SQL.Clear;
      SQL.ADD(SearchStr);

      if not Active then
        Open;
    except
      MainOutMessage('Exception) TFrmSql.ReadyToSell -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    try
      //--------UM_READYTOSELL_NEW----------
      if RecordCount >= 0 then begin
        ReadyItem.SellCount := RecordCount;
        Result := UMResult_Success;
      end else begin
        ReadyItem.SellCount := 0;
        Result := UMResult_Fail;
      end;
      //--------UM_READYTOSELL_NEW----------

{
         if RecordCount = 1 then begin
            ReadyItem.SellCount := FieldByName('FLD_COUNT').AsInteger;
            Result := UMResult_Success;
         end else begin
            Result := UMResult_Fail;
         end;
}

      if Active then
        Close;
    except
      MainOutMessage('Exception) TFrmSql.ReadyToSell -> RecordCount');
      ReadyItem.SellCount := 0;  //UM_READYTOSELL_NEW
      Result := UMResult_Fail;
      if Active then
        Close;
    end;

  end;

end;

//물건을 산다.
function TDBSql.BuyOneUserMarket(var Buyitem: PTMarketLoad): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeTYpe: integer;
  ItemIndex: integer;
  i: integer;
begin
  // 물건을 읽어들이고
  // 물건을 가판매 상태로 변경한다.
  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType  := MARKEY_DBSELLTYPE_SELL;
    ChangeType := MARKEY_DBSELLTYPE_READYBUY;
    ItemIndex  := BuyItem.Index;
    // SearchQuery...
    SearchStr  := 'EXEC UM_LOAD_INDEX ' + IntToStr(ItemIndex) + ',' +
      IntToStr(CheckType) + ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      if not Active then
        Open;
    except
      MainOutMessage('Exception) TFrmSql.BuyOnUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    if RecordCount = 1 then begin
      LoadItemFromDB(@BuyItem.UserItem, FADOQuery);
      Result := UMResult_Success;
    end else begin
      Result := UMResult_Fail;
    end;

    if Active then
      Close;

  end;

end;

//자신이 올린 물건을 취소함(다시 찾음)
function TDBSql.CancelUserMarket(var Cancelitem: PTMarketLoad): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeTYpe: integer;
  ItemIndex: integer;
  i: integer;
begin
  // 물건을 읽어들이고
  // 물건을 가취소 상태로 변경한다.
  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType  := MARKEY_DBSELLTYPE_SELL;
    ChangeType := MARKEY_DBSELLTYPE_READYCANCEL;
    ItemIndex  := Cancelitem.Index;
    // SearchQuery...
    SearchStr  := 'EXEC UM_LOAD_INDEX ' + IntToStr(ItemIndex) + ',' +
      IntToStr(CheckType) + ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      if not Active then
        Open;
    except
      MainOutMessage('Exception) TFrmSql.CancelUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    if RecordCount = 1 then begin
      LoadItemFromDB(@CancelItem.UserItem, FADOQuery);
      Result := UMResult_Success;
    end else begin
      Result := UMResult_Fail;
    end;

    if Active then
      Close;

  end;

end;

//금액을 회수
function TDBSql.GetPayUserMarket(var GetPayitem: PTMarketLoad): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeTYpe: integer;
  ItemIndex: integer;
  i: integer;
begin
  // 물건을 읽어들이고
  // 물건을 가회수 상태로 변경한다.

  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType  := MARKEY_DBSELLTYPE_BUY;
    ChangeType := MARKEY_DBSELLTYPE_READYGETPAY;
    ItemIndex  := GetPayItem.Index;
    // SearchQuery...
    SearchStr  := 'EXEC UM_LOAD_INDEX ' + IntToStr(ItemIndex) + ',' +
      IntToStr(CheckType) + ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      if not Active then
        Open;
    except
      MainOutMessage('Exception) TFrmSql.BuyOnUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    if RecordCount = 1 then begin
      LoadItemFromDB(@GetPayItem.UserItem, FADOQuery);
      Result := UMResult_Success;
    end else begin
      Result := UMResult_Fail;
    end;

    if Active then
      Close;

  end;
end;

// 추가 디비 체크
function TDBSql.ChkAddSellUserMarket(pSearchInfo: PTSearchSellItem;
  IsSucess: boolean): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeType: integer;
  MakeIndex: integer;
  sellwho: string;
  marketname: string;
  i: integer;
begin
  // 정상적으로 판매된것이라면 디비의 플레그를 정상 판매 플레그로 변경
  // 비정상적이라면 디비에서 삭제

  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType := MARKEY_DBSELLTYPE_READYSELL;
    if IsSucess then
      ChangeType := MARKEY_DBSELLTYPE_SELL
    else
      ChangeType := MARKEY_DBSELLTYPE_DELETE;

    MakeIndex  := pSearchInfo.MakeIndex;
    sellwho    := pSearchInfo.Who;
    marketname := pSearchInfo.MarketName;
    // SearchQuery...
    SearchStr  := 'EXEC UM_CHECK_MAKEINDEX ''' + MarketName + ''',''' +
      SellWho + ''',' + IntToStr(MakeIndex) + ',' + IntToStr(CheckType) +
      ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      ExecSql;
    except
      MainOutMessage('Exception) TFrmSql.ChkAddSellUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    // Check RESULT...
{        if RecordCount = 0 then
            Result := UMResult_Success
        else
            Result := UMResult_Fail;
}
    Result := UMResult_Success;
    if Active then
      Close;

  end;

end;
// 사기 디비 체크
function TDBSql.ChkBuyOneUserMarket(pSearchInfo: PTSearchSellItem;
  IsSucess: boolean): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeTYpe: integer;
  Index: integer;
  sellwho: string;
  marketname: string;
  i: integer;
begin
  // 정상적으로 사졌다면 디비에서 삭제
  //  비정상적이라면 디비플레그를 정상 판매 플레그로 변경

  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType := MARKEY_DBSELLTYPE_READYBUY;
    if IsSucess then
      ChangeType := MARKEY_DBSELLTYPE_BUY
    else
      ChangeType := MARKEY_DBSELLTYPE_SELL;

    Index      := pSearchInfo.SellIndex;
    sellwho    := pSearchInfo.Who;
    marketname := pSearchInfo.MarketName;
    // SearchQuery...
    SearchStr  := 'EXEC UM_CHECK_INDEX_BUY ''' + MarketName + ''',''' +
      SellWho + ''',' + IntToStr(Index) + ',' + IntToStr(CheckType) +
      ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      MainOutMessage('ChkBuyOneUserMarket: ' + SearchStr);
      ExecSql;
    except
      MainOutMessage('Exception) TFrmSql.ChkBuyOneUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    // Check RESULT...
    Result := UMResult_Success;
    if Active then
      Close;

  end;

end;
// 츼소 디비 체크
function TDBSql.ChkCancelUserMarket(pSearchInfo: PTSearchSellItem;
  IsSucess: boolean): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeTYpe: integer;
  Index: integer;
  sellwho: string;
  marketname: string;
  i: integer;
begin
  // 정상적으로 취소 되었다면 디비에서 삭제
  // 비정상적이라면 디비 플레그를 정상 판매 플레그로 변경

  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType := MARKEY_DBSELLTYPE_READYCANCEL;
    if IsSucess then
      ChangeType := MARKEY_DBSELLTYPE_DELETE
    else
      ChangeType := MARKEY_DBSELLTYPE_SELL;

    Index      := pSearchInfo.SellIndex;
    sellwho    := pSearchInfo.Who;
    marketname := pSearchInfo.MarketName;

    // SearchQuery...
    SearchStr := 'EXEC UM_CHECK_INDEX ''' + MarketName + ''',''' +
      SellWho + ''',' + IntToStr(Index) + ',' + IntToStr(CheckType) +
      ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      ExecSql;
    except
      MainOutMessage('Exception) TFrmSql.BuyOnUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    // Check RESULT...
    Result := UMResult_Success;
    if Active then
      Close;

  end;

end;
// 회수 디비 체크
function TDBSql.ChkGetPayUserMarket(pSearchInfo: PTSearchSellItem;
  IsSucess: boolean): integer;
var
  SearchStr: string;
  CheckType: integer;
  ChangeTYpe: integer;
  Index: integer;
  sellwho: string;
  marketname: string;
  i: integer;
begin
  // 정상적인 회수인 경우에는 디비에서 삭제
  // 비정상 적인 경우에는 디비플레그를 판매되었음으로 변경

  Result := UMResult_Fail;
  with FADOQuery do begin
    CheckType := MARKEY_DBSELLTYPE_READYGETPAY;
    if IsSucess then
      ChangeType := MARKEY_DBSELLTYPE_DELETE
    else
      ChangeType := MARKEY_DBSELLTYPE_BUY;

    Index      := pSearchInfo.SellIndex;
    sellwho    := pSearchInfo.Who;
    marketname := pSearchInfo.MarketName;
    // SearchQuery...
    SearchStr  := 'EXEC UM_CHECK_INDEX ''' + MarketName + ''',''' +
      SellWho + ''',' + IntToStr(Index) + ',' + IntToStr(CheckType) +
      ',' + IntToStr(ChangeType);

    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      ExecSql;
    except
      MainOutMessage('Exception) TFrmSql.BuyOnUserMarket -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    // Check RESULT...
    Result := UMResult_Success;
    if Active then
      Close;

  end;

end;

 //==============================================================================
 // 장원 게시판용 데이터 입출력 함수
 //==============================================================================
procedure TDBSql.LoadBoardListFromDB(pList: PTGaBoardArticleLoad; SqlDB: TADOQuery);
begin
  with SqlDB do begin
    pList.AgitNum   := FieldByName('FLD_AGITNUM').AsInteger;
    pList.GuildName := Trim(FieldByName('FLD_GUILDNAME').AsString);
    pList.OrgNum    := FieldByName('FLD_ORGNUM').AsInteger;
    pList.SrcNum1   := FieldByName('FLD_SRCNUM1').AsInteger;
    pList.SrcNum2   := FieldByName('FLD_SRCNUM2').AsInteger;
    pList.SrcNum3   := FieldByName('FLD_SRCNUM3').AsInteger;
    pList.UserName  := Trim(FieldByName('FLD_USERNAME').AsString);
    FillChar(pList.Content, sizeof(pList.Content), #0);
    StrPLCopy(pList.Content, Trim(FieldByName('FLD_CONTENT').AsString),
      sizeof(pList.Content) - 1);
  end;
end;

{----------------------장원게시판------------------------}

function TDBSql.LoadPageGaBoardList(gname: string; nKind: integer;
  BoardList: TList): integer;
var
  SearchStr: string;
  pArticle: PTGaBoardArticleLoad;
  i: integer;
begin
  Result := UMResult_Fail;
  with FADOQuery do begin
    if gname = '' then
      exit;

    //-------------------------------
    //공지사항 로드...
    SearchStr := 'EXEC GABOARD_LOAD ''' + gname + ''',' + IntToStr(KIND_NOTICE);
    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      if not Active then
        Open;
    except
      MainOutMessage('Exception) TDBSql.LoadPageGaBoardList -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    First;
    // 공지사항 라인수...
    if RecordCount <= GABOARD_NOTICE_LINE then begin
      for i := 0 to RecordCount - 1 do begin
        new(pArticle);
        LoadBoardListFromDB(pArticle, FADOQuery);
        BoardList.Add(pArticle);
        if not EOF then
          Next;
      end;
      // 비어 있는 공지사항 채우기.
      for i := RecordCount to GABOARD_NOTICE_LINE - 1 do begin
        new(pArticle);
        pArticle.AgitNum  := 0;
        pArticle.OrgNum   := 0;
        pArticle.SrcNum1  := 0;
        pArticle.SrcNum2  := 0;
        pArticle.SrcNum3  := 0;
        pArticle.Kind     := KIND_NOTICE;
        pArticle.UserName := '문주';
        pArticle.Content  := '문주 공지사항이 비어 있습니다.';
        BoardList.Add(pArticle);
      end;
    end else begin // 공지사항이 3개 넘으면 위에서부터 3개만...
      for i := 0 to GABOARD_NOTICE_LINE - 1 do begin
        new(pArticle);
        LoadBoardListFromDB(pArticle, FADOQuery);
        BoardList.Add(pArticle);
        if not EOF then
          Next;
      end;
    end;

    if Active then
      Close;

    //-------------------------------
    //일반 게시물 로드...
    SearchStr := 'EXEC GABOARD_LOAD ''' + gname + ''',' + IntToStr(nKind);
    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      if not Active then
        Open;
    except
      MainOutMessage('Exception) TDBSql.LoadPageGaBoardList -> Open');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
      Result := UMResult_ReadFail;
      exit;
    end;

    First;
    for i := 0 to RecordCount - 1 do begin
      new(pArticle);
      LoadBoardListFromDB(pArticle, FADOQuery);
      BoardList.Add(pArticle);
      if not EOF then
        Next;
    end;

    if Active then
      Close;

    Result := UMResult_Success;
  end;
end;

function TDBSql.AddGaBoardArticle(pArticleLoad: PTGaBoardArticleLoad): integer;
var
  i: integer;
begin
  Result := UMResult_Fail;

  with FADOQuery do begin
    //INSERT INTO TBL_GABOARD Values(2, '밍기문파', 21, 0, 0, 0, 1, '밍기', '안녕하세요!!!' )
    SQL.Clear;
    SQL.Add('INSERT INTO TBL_GABOARD Values(' + IntToStr(pArticleLoad.AgitNum) +
      ',''' + pArticleLoad.GuildName + ''',' + IntToStr(pArticleLoad.OrgNum) +
      ',' + IntToStr(pArticleLoad.SrcNum1) + ',' + IntToStr(pArticleLoad.SrcNum2) +
      ',' + IntToStr(pArticleLoad.SrcNum3) + ',' + IntToStr(pArticleLoad.Kind) +
      ',''' + pArticleLoad.UserName + ''',''' + string(pArticleLoad.Content) +
      '''' + ')'
      );
    try
      ExecSQL;
      Result := UMResult_Success;
    except
      MainOutMessage('Exception) TDBSql.AddGaBoardArticle -> ExecSQL');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
    end;

  end;

end;

function TDBSql.DelGaBoardArticle(pArticleLoad: PTGaBoardArticleLoad): integer;
var
  SearchStr: string;
  i: integer;
begin
  Result := UMResult_Fail;

  if pArticleLoad = nil then
    exit;
  if pArticleLoad.GuildName = '' then
    exit;
  if pArticleLoad.UserName = '' then
    exit;

  with FADOQuery do begin
    SearchStr := 'EXEC GABOARD_DEL ''' + pArticleLoad.GuildName +
      ''',' + IntToStr(pArticleLoad.OrgNum) + ',' +
      IntToStr(pArticleLoad.SrcNum1) + ',' + IntToStr(pArticleLoad.SrcNum2) +
      ',' + IntToStr(pArticleLoad.SrcNum3);
    SQL.Clear;
    SQL.ADD(SearchStr);

    try
      ExecSQL;
      Result := UMResult_Success;
    except
      MainOutMessage('Exception) TDBSql.DelGaBoardArticle -> ExecSQL');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
    end;

  end;

end;

function TDBSql.EditGaBoardArticle(pArticleLoad: PTGaBoardArticleLoad): integer;
var
  i: integer;
begin
  Result := UMResult_Fail;

  with FADOQuery do begin
    //UPDATE TBL_GABOARD SET FLD_CONTENT = '수정내용' WHERE FLD_GUILDNAME = '문파명' AND
    // FLD_ORGNUM = 1 AND FLD_SRCNUM1 = 0 AND FLD_SRCNUM2 = 0 AND FLD_SRCNUM3 = 0
    SQL.Clear;
    SQL.Add('UPDATE TBL_GABOARD SET FLD_CONTENT = ''' +
      string(pArticleLoad.Content) + ''' WHERE ' + 'FLD_GUILDNAME = ''' +
      pArticleLoad.GuildName + ''' AND ' + 'FLD_ORGNUM = ' +
      IntToStr(pArticleLoad.OrgNum) + ' AND ' + 'FLD_SRCNUM1 = ' +
      IntToStr(pArticleLoad.SrcNum1) + ' AND ' + 'FLD_SRCNUM2 = ' +
      IntToStr(pArticleLoad.SrcNum2) + ' AND ' + 'FLD_SRCNUM3 = ' +
      IntToStr(pArticleLoad.SrcNum3)
      );

    try
      ExecSQL;
      Result := UMResult_Success;
    except
      MainOutMessage('Exception) TDBSql.EditGaBoardArticle -> ExecSQL');
      for i := 0 to SQL.Count - 1 do
        MainOutMessage(' :' + SQL[i]);
    end;

  end;

end;


end.
