unit UListViewSort;

// Date: 2010-11-03

interface

uses
  Windows, Types, Classes, ComCtrls, Contnrs, Graphics, SysUtils, StdCtrls,
  Controls, DateUtils, CommCtrl, Dialogs, SpecializedList;

type
  TSortOrder = (soNone, soUp, soDown);

  TListViewSort = class;

  TCompareEvent = function (Item1, Item2: TObject): Integer of object;
  TListFilterEvent = procedure (ListViewSort: TListViewSort) of object;

  TListViewSort = class
  private
    FListView: TListView;
    FOnCompareItem: TCompareEvent;
    FOnFilter: TListFilterEvent;
    FOnCustomDraw: TLVCustomDrawItemEvent;
    FHeaderHandle: HWND;
    FColumn: Integer;
    FOrder: TSortOrder;
    procedure SetListView(const Value: TListView);
    procedure ColumnClick(Sender: TObject; Column: TListColumn);
    procedure Sort(Compare: TCompareEvent);
    procedure DrawCheckMark(Item: TListItem; Checked: Boolean);
    procedure GetCheckBias(var XBias, YBias, BiasTop, BiasLeft: Integer;
      const ListView: TListView);
    procedure ListViewCustomDrawItem(Sender: TCustomListView;
      Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure ListViewClick(Sender: TObject);
    procedure UpdateColumns;
    procedure SetColumn(const Value: Integer);
    procedure SetOrder(const Value: TSortOrder);
  public
    List: TListObject;
    Source: TListObject;
    constructor Create;
    destructor Destroy; override;
    function CompareTime(Time1, Time2: TDateTime): Integer;
    function CompareInteger(Value1, Value2: Integer): Integer;
    function CompareString(Value1, Value2: string): Integer;
    function CompareBoolean(Value1, Value2: Boolean): Integer;
    procedure Refresh;
    property ListView: TListView read FListView write SetListView;
    property OnCompareItem: TCompareEvent read FOnCompareItem
      write FOnCompareItem;
    property OnFilter: TListFilterEvent read FOnFilter
      write FOnFilter;
    property OnCustomDraw: TLVCustomDrawItemEvent read FOnCustomDraw
      write FOnCustomDraw;
    property Column: Integer read FColumn write SetColumn;
    property Order: TSortOrder read FOrder write SetOrder;
  end;

implementation

{ TListViewSort }


procedure TListViewSort.ColumnClick(Sender: TObject; Column: TListColumn);
begin
  if Column.Index = Self.Column then begin
    if FOrder = soUp then FOrder := soDown
    else if FOrder = soDown then FOrder := soUp
    else FOrder := soUp;
  end else Self.Column := Column.Index;
  Refresh;
  UpdateColumns;
end;

procedure TListViewSort.SetOrder(const Value: TSortOrder);
begin
  FOrder := Value;
  UpdateColumns;
end;

procedure TListViewSort.SetColumn(const Value: Integer);
begin
  FColumn := Value;
  UpdateColumns;
end;

procedure TListViewSort.SetListView(const Value: TListView);
begin
  FListView := Value;
  FListView.OnColumnClick := ColumnClick;
  FListView.OnCustomDrawItem := ListViewCustomDrawItem;
  FListView.OnClick := ListViewClick;
end;

procedure TListViewSort.Sort(Compare: TCompareEvent);
begin
  if (List.Count > 0) then
    List.Sort(Compare);
end;

procedure TListViewSort.Refresh;
begin
  if Assigned(FOnFilter) then FOnFilter(Self)
  else if Assigned(Source) then
    List.Assign(Source) else
    List.Clear;
  if ListView.Items.Count <> List.Count then
    ListView.Items.Count := List.Count;
  if Assigned(FOnCompareItem) then Sort(FOnCompareItem);
  ListView.Items[-1]; // Workaround for not show first row if selected
  ListView.Refresh;
  // Workaround for not working item selection on first row
  if not Assigned(ListView.Selected) then begin
    ListView.Items.Count := 0;
    ListView.Items.Count := List.Count;
  end;
  //if ListView.Items.Count > 0 then
  //    ListView.Items[0].Selected := True;
  //ListView.Selected := nil;
  UpdateColumns;
end;

const
  W_64: Integer = 64; {Width of thumbnail in ICON view mode}
  H_64: Integer = 64; {Height of thumbnail size}
  CheckWidth: Integer = 14; {Width of check mark box}
  CheckHeight: Integer = 14; {Height of checkmark}
  CheckBiasTop: Integer = 2; {This aligns the checkbox to be in centered}
  CheckBiasLeft: Integer = 3; {In the row of the list item display}

function TListViewSort.CompareBoolean(Value1, Value2: Boolean): Integer;
begin
  if Value1 > Value2 then Result := 1
  else if Value1 < Value2 then Result := -1
  else Result := 0;
end;

function TListViewSort.CompareInteger(Value1, Value2: Integer): Integer;
begin
  if Value1 > Value2 then Result := 1
  else if Value1 < Value2 then Result := -1
  else Result := 0;
end;

function TListViewSort.CompareString(Value1, Value2: string): Integer;
begin
  Result := AnsiCompareStr(Value1, Value2);
//  if Value1 > Value2 then Result := -1
//  else if Value1 < Value2 then Result := 1
//  else Result := 0;
end;

function TListViewSort.CompareTime(Time1, Time2: TDateTime): Integer;
begin
  Result := DateUtils.CompareDateTime(Time1, Time2);
end;

constructor TListViewSort.Create;
begin
  List := TListObject.Create;
  List.OwnsObjects := False;
end;

destructor TListViewSort.Destroy;
begin
  List.Free;
  inherited;
end;

procedure TListViewSort.DrawCheckMark(Item: TListItem; Checked:
  Boolean);
var
  TP1: TPoint;
  XBias, YBias: Integer;
  OldColor: TColor;
  BiasTop, BiasLeft: Integer;
  Rect1: TRect;
  lRect: TRect;
  ItemLeft: Integer;
begin
  Item.Left := 0;
  GetCheckBias(XBias, YBias, BiasTop, BiasLeft, ListView);
  OldColor := ListView.Canvas.Pen.Color;
  //TP1 := Item.GetPosition;
  lRect := Item.DisplayRect(drBounds); // Windows 7 workaround
  TP1.X := lRect.Left;
  TP1.Y := lRect.Top;
  //ShowMessage(IntToStr(Item.Index) + ', ' + IntToStr(GetScrollPos(Item.ListView.Handle, SB_VERT)) + '  ' +
  //  IntToHex(Integer(Item), 8) + ', ' + IntToStr(TP1.X) + ', ' + IntToStr(TP1.Y));

//  if Checked then
    ListView.Canvas.Brush.Color := clWhite;
  ItemLeft := Item.Left;
  ItemLeft := 23; // Windows 7 workaround
  
  Rect1.Left := ItemLeft - CheckWidth - BiasLeft + 1 + XBias;
  //ShowMessage(IntToStr(Tp1.Y) + ', ' + IntToStr(BiasTop) + ', ' + IntToStr(XBias));
  Rect1.Top := Tp1.Y + BiasTop + 1 + YBias;
  Rect1.Right := ItemLeft - BiasLeft - 1 + XBias;
  Rect1.Bottom := Tp1.Y + BiasTop + CheckHeight - 1 + YBias;
  //ShowMessage(IntToStr(Rect1.Left) + ', ' + IntToStr(Rect1.Top) + ', ' + IntToStr(Rect1.Right) + ', ' + IntToStr(Rect1.Bottom));

  ListView.Canvas.FillRect(Rect1);
  //if Checked then ListView.Canvas.Brush.Color := clBlack
  ListView.Canvas.Brush.Color := clBlack;
  ListView.Canvas.FrameRect(Rect1);
  ListView.Canvas.FrameRect(Rect(Rect1.Left - 1, Rect1.Top - 1,
    Rect1.Right + 1, Rect1.Bottom + 1));
  if Checked then begin
    ListView.Canvas.Pen.Color := clBlack;
    ListView.Canvas.MoveTo(ItemLeft - BiasLeft - 2 + XBias - 2,
      Tp1.Y + BiasTop + 3 + YBias);
    ListView.Canvas.LineTo(ItemLeft - BiasLeft - (CheckWidth div 2) + XBias,
      Tp1.Y + BiasTop + (CheckHeight - 4) + YBias);
    ListView.Canvas.LineTo(ItemLeft - BiasLeft - (CheckWidth - 3) + XBias,
      Tp1.Y + BiasTop + (CheckHeight div 2) + YBias - 1);

    ListView.Canvas.MoveTo(ItemLeft - BiasLeft - 2 - 1 + XBias - 2,
      Tp1.Y + BiasTop + 3 + YBias);
    ListView.Canvas.LineTo(ItemLeft - BiasLeft - (CheckWidth div 2) - 1 + XBias,
      Tp1.Y + BiasTop + (CheckHeight - 4) + YBias);
    ListView.Canvas.LineTo(ItemLeft - BiasLeft - (CheckWidth - 3) - 1 + XBias,
      Tp1.Y + BiasTop + (CheckHeight div 2) + YBias - 1);
  end;
  //ListView.Canvas.Brush.Color := ListView.Color;
  ListView.Canvas.Brush.Color := clWindow;
  ListView.Canvas.Pen.Color := OldColor;
end;

procedure TListViewSort.GetCheckBias(var XBias, YBias, BiasTop, BiasLeft: Integer;
  const ListView: TListView);
begin
  XBias := 0;
  YBias := 0;
  if ListView.ViewStyle = vsICON then
  begin
    YBias := H_64 - CheckHeight;
    XBias := 0;
  end;
  BiasTop := CheckBiasTop;
  BiasLeft := CheckBiasLeft;
  if ListView.ViewStyle <> vsReport then
  begin
    BiasTop := 0;
    BiasLeft := 0;
  end;
end;

procedure TListViewSort.ListViewCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Assigned(Item) then begin
    if ListView.Checkboxes then
      DrawCheckMark(Item, Item.Checked);
    if Assigned(FOnCustomDraw) then
      FOnCustomDraw(Sender, Item, State, DefaultDraw);
  end;
end;

procedure TListViewSort.ListViewClick(Sender: TObject);
var
  Item: TListItem;
  Pos: TPoint;
  DefaultDraw: Boolean;
begin
  Pos := ListView.ScreenToClient(Mouse.CursorPos);
  Item := ListView.GetItemAt(Pos.X, Pos.Y);
  //ShowMessage(IntToStr(Item.Index) + ', ' + IntToStr(Pos.X) + ', ' + IntToStr(Pos.Y));
  if Assigned(Item) and (Pos.X < 20) then begin

    Item.Checked := not Item.Checked;
    //ShowMessage(IntToStr(Item.Index) + ', ' +BoolToStr(Item.Checked));
    if Assigned(ListView.OnChange) then
      ListView.OnChange(Self, Item, ctState);
    DefaultDraw := False;
    ListViewCustomDrawItem(ListView, Item, [], DefaultDraw);
      //ListView.UpdateItems(Item.Index, Item.Index);
  end;
end;

procedure TListViewSort.UpdateColumns;
const
  HDF_SORTUP = $0400;
  HDF_SORTDOWN = $0200;
  SortOrder: array[TSortOrder] of Word = (0, HDF_SORTUP, HDF_SORTDOWN);
var
  Item: THDItem;
  I: Integer;
begin
  if Assigned(FListView) then begin
    FHeaderHandle := ListView_GetHeader(FListView.Handle);
    for I := 0 to FListView.Columns.Count - 1 do begin
      FillChar(Item, SizeOf(THDItem), 0);
      Item.Mask := HDI_FORMAT;
      Header_GetItem(FHeaderHandle, I, Item);
      Item.fmt := Item.fmt and not (HDF_SORTDOWN or HDF_SORTUP);
      if (Column <> -1) and (I = Column) then
        Item.fmt := Item.fmt or SortOrder[FOrder];
      Header_SetItem(FHeaderHandle, I, Item);
    end;
  end;
end;


end.
