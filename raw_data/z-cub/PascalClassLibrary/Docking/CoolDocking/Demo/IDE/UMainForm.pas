unit UMainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, ExtCtrls, ComCtrls, StdCtrls, UCDClient, UCDLayout,
  UToolPaletteForm, UObjectInspectorForm, UProjectManagerForm, UStructureForm,
  UMessagesForm, UCallStackForm, ULocalVariablesForm, UToDoListForm,
  UWatchListForm, UThreadStatusForm, USourceEditorForm, UCDWindowList,
  UCDCustomize, UComponentTree, UCDConjoinForm, UCDManager,
  UCDMaster, UCDCommon;

const
  DefaultLayoutName = 'Default Layout';
  DockLayoutFileName = 'Layout.xml';

type

  { TMainForm }

  TMainForm = class(TForm)
  published
    AResetDefaultLayout: TAction;
    AViewComponentTree: TAction;
    AExit: TAction;
    ANewFile: TAction;
    ACustomizeDocking: TAction;
    ADesktopSave: TAction;
    AViewThreadStatus: TAction;
    AViewWatchList: TAction;
    AViewToDoList: TAction;
    AViewLocalVariables: TAction;
    AViewCallStack: TAction;
    AViewMessages: TAction;
    AViewStructure: TAction;
    AViewToolPalette: TAction;
    AViewProjectManager: TAction;
    AViewObjectInspector: TAction;
    AViewWindowList: TAction;
    ComboBox1: TComboBox;
    CoolDockClient1: TCDClient;
    CoolDockCustomize1: TCDCustomize;
    CoolDockLayoutList1: TCDLayoutList;
    CoolDockMaster1: TCDMaster;
    CoolDockWindowList1: TCDWindowList;
    ImageList1: TImageList;
    Label1: TLabel;
    MenuItem11: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem2: TMenuItem;
    ActionList1: TActionList;
    MenuItem1: TMenuItem;
    MainMenu1: TMainMenu;
    DockPanel: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure ACustomizeDockingExecute(Sender: TObject);
    procedure ADesktopSaveExecute(Sender: TObject);
    procedure AExitExecute(Sender: TObject);
    procedure ANewFileExecute(Sender: TObject);
    procedure AResetDefaultLayoutExecute(Sender: TObject);
    procedure AViewComponentTreeExecute(Sender: TObject);
    procedure AViewThreadStatusExecute(Sender: TObject);
    procedure AViewCallStackExecute(Sender: TObject);
    procedure AViewLocalVariablesExecute(Sender: TObject);
    procedure AViewMessagesExecute(Sender: TObject);
    procedure AViewObjectInspectorExecute(Sender: TObject);
    procedure AViewProjectManagerExecute(Sender: TObject);
    procedure AViewStructureExecute(Sender: TObject);
    procedure AViewToDoListExecute(Sender: TObject);
    procedure AViewToolPaletteExecute(Sender: TObject);
    procedure AViewWatchListExecute(Sender: TObject);
    procedure AViewWindowListExecute(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  public
    NewFileIndex: Integer;
    SourceCodeContainer: TCDConjoinForm;
    procedure InitDefaultDockLayout;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

{ TMainForm }

procedure TMainForm.AViewToolPaletteExecute(Sender: TObject);
begin
  ToolPaletteForm.Show;
end;

procedure TMainForm.AViewWatchListExecute(Sender: TObject);
begin
  WatchListForm.Show;
end;

procedure TMainForm.AViewWindowListExecute(Sender: TObject);
begin
  CoolDockWindowList1.Execute;
end;

procedure TMainForm.ComboBox1Select(Sender: TObject);
begin
  if (ComboBox1.ItemIndex <> - 1) and (ComboBox1.ItemIndex < CoolDockLayoutList1.Items.Count) then
    TCDLayout(CoolDockLayoutList1.Items[ComboBox1.ItemIndex]).Restore;
end;

procedure TMainForm.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CoolDockLayoutList1.SaveToFile(DockLayoutFileName);
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  with CoolDockLayoutList1 do begin
    if FileExistsUTF8(DockLayoutFileName) then
      LoadFromFile(DockLayoutFileName);
    InitDefaultDockLayout;
    PopulateStringList(ComboBox1.Items);
  end;
end;

procedure TMainForm.InitDefaultDockLayout;
var
  NewContainer1: TCDConjoinForm;
  NewContainer2: TCDConjoinForm;
  DefaultLayout: TCDLayout;
begin
  DefaultLayout := CoolDockLayoutList1.FindByName(DefaultLayoutName);
  if not Assigned(DefaultLayout) then begin
    NewContainer1 := TCDManager(DockPanel.DockManager).CreateConjoinForm;
    TCDManager(NewContainer1.DockManager).DockStyle := dsPopupTabs;
    TCDManager(NewContainer1.DockManager).HeaderPos := hpLeft;
    NewContainer1.Visible := True;

    StructureForm.ManualDock(NewContainer1, nil, alTop);
    StructureForm.Show;
    ObjectInspectorForm.ManualDock(NewContainer1, nil, alTop);
    ObjectInspectorForm.Show;

    NewContainer2 := TCDManager(DockPanel.DockManager).CreateConjoinForm;
    TCDManager(NewContainer2.DockManager).DockStyle := dsPopupTabs;
    TCDManager(NewContainer2.DockManager).HeaderPos := hpRight;
    NewContainer2.Visible := True;

    ProjectManagerForm.ManualDock(NewContainer2, nil, alTop);
    ProjectManagerForm.Show;
    ToolPaletteForm.ManualDock(NewContainer2, nil, alTop);
    ToolPaletteForm.Show;

    SourceCodeContainer := TCDManager(DockPanel.DockManager).CreateConjoinForm;
    TCDManager(SourceCodeContainer.DockManager).DockStyle := dsTabs;
    TCDManager(SourceCodeContainer.DockManager).HeaderPos := hpTop;
    SourceCodeContainer.Visible := True;

    //NewContainer1.ManualDock(DockPanel);
    NewContainer1.Show;
    SourceCodeContainer.ManualDock(DockPanel);
    SourceCodeContainer.Show;
    //NewContainer2.ManualDock(DockPanel);
    NewContainer2.Show;

    DefaultLayout := TCDLayout.Create;
    DefaultLayout.Name := DefaultLayoutName;
    CoolDockLayoutList1.Items.Add(DefaultLayout);
    DefaultLayout.Store;
  end;
end;

procedure TMainForm.AViewProjectManagerExecute(Sender: TObject);
begin
  ProjectManagerForm.Show;
end;

procedure TMainForm.AViewStructureExecute(Sender: TObject);
begin
  StructureForm.Show;
end;

procedure TMainForm.AViewToDoListExecute(Sender: TObject);
begin
  ToDoListForm.Show;
end;

procedure TMainForm.AViewObjectInspectorExecute(Sender: TObject);
begin
  ObjectInspectorForm.Show;
end;

procedure TMainForm.AViewCallStackExecute(Sender: TObject);
begin
  CallStackForm.Show;
end;

procedure TMainForm.AViewThreadStatusExecute(Sender: TObject);
begin
  ThreadStatusForm.Show;
end;

procedure TMainForm.ADesktopSaveExecute(Sender: TObject);
var
  NewLayout: TCDLayout;
begin
  if ComboBox1.Text <> '' then begin
    if ComboBox1.Items.IndexOf(ComboBox1.Text) = -1 then begin
      NewLayout := TCDLayout.Create;
      NewLayout.Name := ComboBox1.Text;
      NewLayout.Store;
      CoolDockLayoutList1.Items.Add(NewLayout);
    end else
      TCDLayout(CoolDockLayoutList1.Items[ComboBox1.Items.IndexOf(ComboBox1.Text)]).Store;
    CoolDockLayoutList1.SaveToFile(DockLayoutFileName);
    CoolDockLayoutList1.PopulateStringList(ComboBox1.Items);
  end else ShowMessage('Enter layout name');
end;

procedure TMainForm.AExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ANewFileExecute(Sender: TObject);
var
  NewFile: TSourceEditorForm;
begin
  Application.CreateForm(TSourceEditorForm, NewFile);
  //NewFile := TSourceEditorForm.Create(nil);
  Inc(NewFileIndex);
  NewFile.Caption := 'Unit ' + IntToStr(NewFileIndex);
  NewFile.ManualDock(SourceCodeContainer);
  NewFile.Show;
end;

procedure TMainForm.AResetDefaultLayoutExecute(Sender: TObject);
var
  DefaultLayout: TCDLayout;
begin
  DefaultLayout := CoolDockLayoutList1.FindByName(DefaultLayoutName);
  if Assigned(DefaultLayout) then
    CoolDockLayoutList1.Items.Remove(DefaultLayout);
  InitDefaultDockLayout;
end;

procedure TMainForm.AViewComponentTreeExecute(Sender: TObject);
begin
  ComponentTree.Show;
end;

procedure TMainForm.ACustomizeDockingExecute(Sender: TObject);
begin
  CoolDockCustomize1.Execute;
  CoolDockLayoutList1.PopulateStringList(ComboBox1.Items);
end;

procedure TMainForm.AViewLocalVariablesExecute(Sender: TObject);
begin
  LocalVariablesForm.Show;
end;

procedure TMainForm.AViewMessagesExecute(Sender: TObject);
begin
  MessagesForm.Show;
end;

end.

