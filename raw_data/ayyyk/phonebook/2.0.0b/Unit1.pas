unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPMan, ExtCtrls, Menus, StdCtrls, Buttons, ActnMan,
  ComCtrls, ToolWin, ImgList;

type

  PTelList=^TelList;
  TelList=Record
    Part:String[50];
    Name:string[100];
    NameComments:string[200];
    Tel:String[50];
    TelComments:string[50];
    Next, Prev:PTelList;
  end;

  TTelephones = class(TForm)
    Panel1: TPanel;
    TelInfo: TLabel;
    NameInfo: TLabel;
    Tema: TComboBox;
    Teleph: TListBox;
    Names: TListBox;
    Popup: TPopupMenu;
    N3: TMenuItem;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    XP: TXPManifest;
    MainMenu: TMainMenu;
    ActionList: TActionList;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N20: TMenuItem;
    quit: TAction;
    about: TAction;
    NewElem: TAction;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    DelElem: TAction;
    EditElem: TAction;
    Comments: TAction;
    Find: TAction;
    FindNext: TAction;
    ToolBar: TToolBar;
    NewButton: TToolButton;
    EditButton: TToolButton;
    DelButton: TToolButton;
    CommentButton: TToolButton;
    ToolButton8: TToolButton;
    AboutButton: TToolButton;
    QuitButton: TToolButton;
    FindButton: TToolButton;
    ToolButton13: TToolButton;
    FindNextButton: TToolButton;
    ImageList: TImageList;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure TemaChange(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure NamesClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure TelephClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    

    function  InputSt(st1, st2, st3:string; long :Word):string;
    procedure CreateItem(st1, st2, st3:string);
    procedure DeleteItem(st1, st2, st3:string; b1, b2, b3:boolean);
    procedure AddToFile;
    procedure RewriteFile;
    procedure FindNameItems;
    function  FindCommentItems(st1, st2:string; b:boolean):string;
    procedure FindTelephItems(st:string);
    function  can(st:string; List:TStrings):boolean;
    procedure quitExecute(Sender: TObject);
    procedure aboutExecute(Sender: TObject);
    procedure FindExecute(Sender: TObject);
    procedure FindNextExecute(Sender: TObject);
    procedure NewElemUpdate(Sender: TObject);
    procedure DelElemUpdate(Sender: TObject);
    procedure EditElemUpdate(Sender: TObject);
    procedure CommentsUpdate(Sender: TObject);
    procedure NamesContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TelephContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure TemaContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);


    private
    FindSt:string;
    StMaxPos, StPos:byte;
    ArrPtr:array[1..9999] of PTelList;
    ArrPos:array[1..9999] of byte;
  end;

var
  Telephones: TTelephones;
  Ver:string='2.0.0b';

implementation

{$R *.dfm}

uses about;

var
  TelF:File of TelList;
  TelP:PTelList;

procedure TTelephones.FormCreate(Sender: TObject);
var
  FileT:TelList;
  PtrTel :PTelList;
begin
    begin //���� ��� ��������� ���������

    TelInfo.Caption:='';
    NameInfo.Caption:='';

    // �������� ����� ������
    AssignFile(TelF, 'Book.dat');
    if not(FileExists('Book.dat')) then
    Begin
     Application.MessageBox
     ('����� ������ ����� ���� ���� ������ !',
      '���� ������ ����������� (Book.dat) ����������� !',
       MB_ICONEXCLAMATION+MB_OK);
     Rewrite(TelF);
     CloseFile(TelF);
    end else
    begin
      Reset(TelF);
      CloseFile(TelF);
    end;

    //���������� ���������
    Reset(TelF);

    //���������� ������ � ������
    TelP:=nil;
    While not eof(TelF) do
    begin
      Read(TelF, FileT);
      PtrTel:=New(PTelList);
      PtrTel^:=FileT;
      PtrTel^.Next:=TelP;
      if TelP<>nil then TelP^.Prev:=PtrTel;
      TelP:=PtrTel;
    end;
    CloseFile(TelF);
    if TelP<>nil then TelP^.Prev:=nil;

    //��������� ���������� ���� "Tema"
    PtrTel:=TelP;
    While not (PtrTel=nil) do
    begin
      if (PtrTel^.Part<>'') and (PtrTel^.Name='') and (PtrTel^.Tel='') then
        Tema.Items.Add(PtrTel^.Part);
      PtrTel:=PtrTel^.Next;
    end;
    Tema.ItemIndex:=0;

    //���������� ��������� ����
    TemaChange(sender);
  end
  //else halt;
end;

procedure TTelephones.FormDestroy(Sender: TObject);
var
  PtrTel:PTelList;
begin
  While not (TelP=nil) do
  begin
    PtrTel:=TelP;
    TelP:=TelP^.Next;
    Dispose(PtrTel);
  end;
end;

procedure TTelephones.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose:=false;
  if (Application.MessageBox('������������� ����� ?','��������� ������',
  MB_ICONQUESTION+MB_YESNO )=IDYES) then CanClose:=True;
end;

{************************** ������ � ��������� ********************************}
procedure TTelephones.N2Click(Sender: TObject); //����� ������
var
  st:string[50];
begin
  //���� ��������������
  st:=InputSt('����� ������', '������� �������� ������� (�� 50 ��������)', '', 50);

  if st<>'' then
    if can(st, Tema.Items) then
      Application.MessageBox('����� ������ ��� �������', '�������� �������� !',
      MB_ICONWARNING)
    else begin
      // �������� � ������
      CreateItem(st, '', '');

      // �������� � ����
      AddToFile;

      // �������� � ���������� ������
      Tema.ItemIndex:=Tema.Items.Add(TelP^.Part);

      //�������� �����
      Names.Items.Clear;
      NameInfo.Caption:='';
      Teleph.Items.Clear;
      TelInfo.Caption:='';
    end;
end;

procedure TTelephones.N9Click(Sender: TObject);//��������  �������
begin
  //������������� ��������
  if Application.MessageBox('�� �������, ��� ���� ������� ������ ������ ?',
    '�������� �������', MB_ICONQUESTION+MB_YESNO)=IDYES then
     begin
       //������ �� ������
       DeleteItem(Tema.Text, '', '', false, true, true);

       //������ �� �����
       RewriteFile;

       //������ �� ����������� ������
       Tema.DeleteSelected;
       Tema.ItemIndex:=0;

       //�������������� ���� Names
       Names.Items.Clear;
       FindNameItems;
       Names.ItemIndex:=0;

       //�����������
       if Names.Items.Count<>0 then
         NameInfo.Caption:=FindCommentItems(Names.Items[0], '', true);

       //������������� ���� Teleph
       Teleph.Items.Clear;
       if Names.Items.Count<>0 then
         FindTelephItems(Names.Items[Names.ItemIndex]);
       Teleph.ItemIndex:=0;

       //����������� � ������
       TelInfo.Caption:='';
       if Names.Items.Count<>0 then
         TelInfo.Caption:=FindCommentItems(Names.Items[Names.ItemIndex],
       Teleph.Items[Teleph.ItemIndex], false);
     end;
end;

procedure TTelephones.N10Click(Sender: TObject); //�������������� �������
var
  st:string[50];
  PtrTel:PTelList;
begin
  st:=InputSt('������������� ������', '������� �������� �������', Tema.Text, 50);

  if st<>'' then
    if can(st, Tema.Items) then
      Application.MessageBox('����� ������ ��� �������', '�������� �������� !',
      MB_ICONWARNING)
    else begin
      //�������� ������
      PtrTel:=TelP;
      While not (PtrTel=nil) do
      begin
        if PtrTel^.Part=Tema.Text then
          PtrTel^.Part:=st;
        PtrTel:=PtrTel^.Next;
      end;

      //�������� ����
      RewriteFile;

      //�������� ���������� ������
      Tema.Items[Tema.ItemIndex]:=st;
      Tema.ItemIndex:=0;
    end;
end;


{**************************** ������ � ������� ********************************}
procedure TTelephones.N3Click(Sender: TObject); //���������� �������.
VAR
  st:string;
begin
  //���� �����
  st:=InputSt('����� ���','������� ����� ��� (�� 100 ��������)','', 100);

  if st<>'' then
    if can(st, Names.Items) then
      Application.MessageBox('����� ��� ��� �������', '�������� �������� !',
      MB_ICONWARNING)
    else begin
      //�������� � ������
      CreateItem(Tema.Text, st, '');

      //�������� � ����
      AddToFile;

      //�������� � ����
      Names.ItemIndex:=Names.Items.Add(st);

      //������� ����
      NameInfo.Caption:='';
      Teleph.Items.Clear;
      TelInfo.Caption:='';
    end;
end;

procedure TTelephones.N4Click(Sender: TObject);  //�������� ��������������
begin
  if Application.MessageBox('�� �������, ��� ���� ������� ������ ��� ?',
    '�������� ����� ', MB_ICONQUESTION+MB_YESNO)=IDYES then
  begin
    //������� �� ������
    DeleteItem(Tema.Text, Names.Items[Names.ItemIndex], '', false, false, true);

    //������� �� �����
    RewriteFile;

    //������� �� ����
    Names.DeleteSelected;
    Names.ItemIndex:=0;

    //��������������� ������������
    if Names.Items.Count<>0 then
      NameInfo.Caption:=FindCommentItems(Names.Items[0], '', true);

    //��������������� ���������
    Teleph.Items.Clear;
    if Names.Items.Count<>0 then
      FindTelephItems(Names.Items[Names.ItemIndex]);
    Teleph.ItemIndex:=0;

    //����������� � ������
    TelInfo.Caption:='';
    if Names.Items.Count<>0 then
      TelInfo.Caption:=FindCommentItems(Names.Items[Names.ItemIndex],
    Teleph.Items[Teleph.ItemIndex], false);
  end;
end;

procedure TTelephones.N5Click(Sender: TObject);   //�������������� ��������������
var
  st:string;
  PtrTel:PTelList;
begin
  st:=InputSt('������������� ������������� ?','������� ����� ��� (�� 100 ��������)',
  Names.Items[Names.ItemIndex], 100);

  if (st<>'') and (st<>Names.Items[Names.ItemIndex]) then
    if can(st, Names.Items) then
      Application.MessageBox('����� ��� ��� ����', '�������� �������� !',
      MB_ICONWARNING)
    else begin
      // � ������
      PtrTel:=TelP;
      While not (PtrTel=nil) do
      begin
        if (PtrTel^.Part=Tema.Text) and
          (PtrTel^.Name=Names.Items[Names.ItemIndex])
          then PtrTel^.Name:=st;
        PtrTel:=PtrTel^.Next;
      end;

      // � �����
      RewriteFile;

      // � ����
      Names.Items[Names.ItemIndex]:=st;
    end;
end;

procedure TTelephones.N1Click(Sender: TObject); //����������� � �������.
var
  st:string;
  PtrTel:PTelList;
begin
  st:=InputSt('����������� � �����', '������� ����������� (�� 200 ��������)',
  NameInfo.Caption, 200);

  //������
  PtrTel:=TelP;
  While not (PtrTel=nil) do
  begin
    if (PtrTel^.Part=Tema.Text) and
      (PtrTel^.Name=Names.Items[Names.ItemIndex])
      then PtrTel^.NameComments:=st;
    PtrTel:=PtrTel^.Next;
  end;

  //����
  RewriteFile;

  //������
  NameInfo.Caption:=st;

end;

{************************* ����������� ������� ********************************}
procedure TTelephones.TemaChange(Sender: TObject);   //����� ���������� ����
begin
  Names.Items.Clear;
  FindNameItems;
  Names.ItemIndex:=0;

  //�����������
  NamesClick(Sender);
end;

procedure TTelephones.NamesClick(Sender: TObject);
begin
  //�����������
  NameInfo.Caption:='';
  if Names.Items.Count<>0 then
    NameInfo.Caption:=FindCommentItems(Names.Items[Names.ItemIndex], '', true);

  //������ ���������
  Teleph.Items.Clear;
  if Names.Items.Count<>0 then
    FindTelephItems(Names.Items[Names.ItemIndex]);
  Teleph.ItemIndex:=0;

  //����������� � ��������
  TelephClick(Sender);
end;

procedure TTelephones.TelephClick(Sender: TObject);
begin
  TelInfo.Caption:='';
  if Teleph.Items.Count<>0 then
    TelInfo.Caption:=FindCommentItems(Names.Items[Names.ItemIndex],
  Teleph.Items[Teleph.ItemIndex], false);
end;

procedure TTelephones.N6Click(Sender: TObject); //���������� ����������� ������
var
  st:string;
begin
  st:=InputSt('����� �������', '������� �����', '', 50);

  if st<>'' then
    if can(st, Teleph.Items) then
      Application.MessageBox('����� ����� ��� ������', '�������� �������� !',
      MB_ICONWARNING)
    else begin
      //�������� � ������
      CreateItem(Tema.Text, Names.Items[Names.ItemIndex], st);

      //�������� � ����
      AddToFile;

      //�������� � ����
      Teleph.ItemIndex:=Teleph.Items.Add(st);

      //������� ����
      TelInfo.Caption:='';
    end;
end;

procedure TTelephones.N8Click(Sender: TObject);   //�������� ��������
begin
  if Application.MessageBox('�� �������, ��� ���� ������� ������ ����� ?',
    '�������� ������ ', MB_ICONQUESTION+MB_YESNO)=IDYES then
  begin
    //������� �� ������
    DeleteItem(Tema.Text, Names.Items[Names.ItemIndex],
    Teleph.Items[Teleph.ItemIndex], false, false, false);

    //������� �� �����
    RewriteFile;

    //������� �� ����
    Teleph.DeleteSelected;
    Teleph.ItemIndex:=0;

    //�����������
    TelInfo.Caption:='';
    if Teleph.Items.Count<>0 then
      TelInfo.Caption:=FindCommentItems(Names.Items[Names.ItemIndex],
    Teleph.Items[Teleph.ItemIndex], false);

  end;
end;

procedure TTelephones.N11Click(Sender: TObject);  //����������� � ��������
var
  st:string;
  PtrTel:PTelList;
begin
  st:=InputSt('����������� � ������', '������� ����������� (�� 50 ��������)',
  TelInfo.Caption, 50);

  //������
  PtrTel:=TelP;
  While not (PtrTel=nil) do
  begin
    if (PtrTel^.Part=Tema.Text) and (PtrTel^.Name=Names.Items[Names.ItemIndex])
    and (PtrTel^.Tel=Teleph.Items[Teleph.ItemIndex]) then PtrTel^.TelComments:=st;
    PtrTel:=PtrTel^.Next;
  end;

  //����
  RewriteFile;

  //������
  TelInfo.Caption:=st;
end;

procedure TTelephones.N7Click(Sender: TObject);//�������������� ���������� �����
var
  st:string;
  PtrTel:PTelList;
begin
  st:=InputSt('�������� ����� ?','������� ����� ����� (�� 50 ��������)',
  Teleph.Items[Teleph.ItemIndex], 50);

  if (st<>'') and (st<>Teleph.Items[Teleph.ItemIndex]) then
    if can(st, Teleph.Items) then
      Application.MessageBox('����� ����� ��� ����', '�������� �������� !',
      MB_ICONWARNING)
    else begin
      // � ������
      PtrTel:=TelP;
      While not (PtrTel=nil) do
      begin
        if (PtrTel^.Part=Tema.Text) and (PtrTel^.Name=Names.Items[Names.ItemIndex])
        and (PtrTel^.Tel=Teleph.Items[Teleph.ItemIndex]) then PtrTel^.Tel:=st;
        PtrTel:=PtrTel^.Next;
      end;

      // � �����
      RewriteFile;

      // � ����
      Teleph.Items[Teleph.ItemIndex]:=st;
    end;
end;

{********************************* ������ *************************************}
function TTelephones.InputSt(st1, st2, st3 :string; long :Word):string; //���� ������
var
  st:string;
begin
  st:='';
  st:=InputBox(st1, st2, st3);
  While not (Length(st)<=long) do
    st:=InputBox('������� ����� �������� !'+'(�� '+FloatToStr(long)+'��������)', st2, st3);
  InputSt:=st;
end;

procedure TTelephones.DeleteItem(st1, st2, st3:string; b1, b2,b3:boolean);
var                                                   //�������� �������� ������
  PtrTel:PTelList;
begin
  PtrTel:=TelP;
  While not (PtrTel=nil) do
  begin
    if ((PtrTel^.Part=st1)or b1) and ((PtrTel^.Name=st2) or b2)
    and ((PtrTel^.Tel=st3) or b3) then
    begin
      if PtrTel^.Next<>nil then PtrTel^.Next^.Prev:=PtrTel^.Prev;
      if PtrTel^.Prev<>nil then PtrTel^.Prev^.Next:=PtrTel^.Next
      else if TelP<>nil then TelP:=TelP^.Next;
      Dispose(PtrTel);
    end;
    PtrTel:=PtrTel^.Next;
  end;
end;

procedure TTelephones.CreateItem(st1, st2, st3:string); //���������� �������� ������
var
  PtrTel:PTelList;
begin
  PtrTel:=New(PTelList);
  PtrTel^.Next:=TelP;
  PtrTel^.Prev:=nil;
  if TelP<>nil then TelP^.Prev:=PtrTel;
  TelP:=PtrTel;
  TelP^.Part:=st1;
  TelP^.Name:=st2;
  TelP^.Tel:=st3;
end;

procedure TTelephones.AddToFile;  //���������� � ����
var
  FileT:TelList;
begin
  FileT:=TelP^;
  Reset(TelF);
  seek(TelF, FileSize(TelF));
  Write(TelF, TelP^);
  CloseFile(TelF);
end;

procedure TTelephones.RewriteFile;  //���������� �����
var
  PtrTel:PTelList;
begin
  Rewrite(TelF);
  
  PtrTel:=TelP;
  While not (PtrTel=nil) do
  begin
    Write(TelF, PtrTel^);
    PtrTel:=PtrTel^.Next;
  end;
  CloseFile(TelF);
end;

procedure TTelephones.FindNameItems;  //���������� ������� ���������  Names
var
  PtrTel:PTelList;
Begin
  PtrTel:=TelP;
  While not (PtrTel=nil) do
  begin
    if (PtrTel^.Part=Tema.Text) and (PtrTel^.Name<>'') and (PtrTel^.Tel='') then
      Names.Items.Add(PtrTel^.Name);
    PtrTel:=PtrTel^.Next;
  end;
end;

function TTelephones.FindCommentItems(st1, st2:string; b:boolean):string;
var                                                     //���������� �����������
  PtrTel:PTelList;
  st:string;
begin
  st:='';
  PtrTel:=TelP;
  While (PtrTel<>nil) and ((PtrTel^.Part<>Tema.Text) or (PtrTel^.Name<>st1)
  or (PtrTel^.Tel<>st2)) do PtrTel:=PtrTel^.Next;
  if (PtrTel^.Part=Tema.Text) and (PtrTel^.Name=st1) and (PtrTel^.Tel=st2) then
    if b then st:=PtrTel^.NameComments
    else st:=PtrTel^.TelComments;
  FindCommentItems:=st;
end;

procedure TTelephones.FindTelephItems(st:string);  //���������� ������� ���������  Teleph
var
  PtrTel:PTelList;
begin
  PtrTel:=TelP;
  While not (PtrTel=nil) do
  begin
    if (PtrTel^.Part=Tema.Text) and (PtrTel^.Name=st) and (PtrTel^.Tel<>'') then
      Teleph.Items.Add(PtrTel^.Tel);
    PtrTel:=PtrTel^.Next;
  end;
end;

function TTelephones.can(st:string; List:TStrings):boolean; //�������� �������
var
  i:integer;
  b:boolean;
begin
  i:=List.IndexOf(st);
  if i=-1 then b:=false
  else b:=true;
  can:=b;
end;

{**************************����������� ��������********************************}
procedure TTelephones.quitExecute(Sender: TObject);//�����
begin
  Telephones.Close;
end;

procedure TTelephones.aboutExecute(Sender: TObject); //� ���������
begin
  AboutForm.ShowModal;
end;

procedure TTelephones.FindExecute(Sender: TObject);   //����� ����� �� ��������� ������
var
  b:boolean;
  PtrTel:PTelList;
  i:word;

begin
  i:=0;
  //���� ������
  b:=InputQuery('�����','������� ������� �����',FindSt);
  if (b) and (FindSt<>'') then
  begin
    PtrTel:=TelP;
    While PtrTel<>nil do
    begin
      if (Pos(FindSt, PtrTel^.Part)<>0) and (PtrTel^.Name='') and (PtrTel.Tel='') then
      begin
        i:=i+1;
        ArrPtr[i]:=PtrTel;
        ArrPos[i]:=1;
      end;

      if (Pos(FindSt, PtrTel^.Name)<>0) and (PtrTel.Tel='') then
      begin
        i:=i+1;
        ArrPtr[i]:=PtrTel;
        ArrPos[i]:=2;
      end;

      if (Pos(FindSt, PtrTel^.Tel)<>0) then
      begin
        i:=i+1;
        ArrPtr[i]:=PtrTel;
        ArrPos[i]:=3;
      end;
      PtrTel:=PtrTel^.Next;
    end;
    StMaxPos:=i;
    // ������� �� ������ ������
    if i<>0 then
    begin
      //���� ������ �� ���� - ������� � ����
      if ArrPos[1]=1 then
      begin
        Tema.ItemIndex:=Tema.Items.IndexOf(ArrPtr[1]^.Part);
        TemaChange(Sender);

        Tema.SetFocus;
      end;

      //������� � �����
      if ArrPos[1]=2 then
      begin
        Tema.ItemIndex:=Tema.Items.IndexOf(ArrPtr[1]^.Part);
        TemaChange(Sender);

        Names.ItemIndex:=Names.Items.IndexOf(ArrPtr[1]^.Name);
        NamesClick(Sender);

        Names.SetFocus;
      end;

      //������� � ��������
      if ArrPos[1]=3 then
      begin
        Tema.ItemIndex:=Tema.Items.IndexOf(ArrPtr[1]^.Part);
        TemaChange(Sender);

        Names.ItemIndex:=Names.Items.IndexOf(ArrPtr[1]^.Name);
        NamesClick(Sender);

        Teleph.ItemIndex:=Teleph.Items.IndexOf(ArrPtr[1]^.Tel);
        TelephClick(Sender);

        Teleph.SetFocus;
      end;
      if i>1 then
      begin
        FindNext.Enabled:=True;
        //NextFind.SetFocus;
        StPos:=2;
      end;
    end
    else Application.MessageBox('�� ������� ������ �� �������', '�����', MB_ICONEXCLAMATION+MB_OK);
  end;
end;

procedure TTelephones.FindNextExecute(Sender: TObject);//����� ����� �� ��������� ������
begin
  //���� ������ �� ���� - ������� � ����
  if ArrPos[StPos]=1 then
  begin
    Tema.ItemIndex:=Tema.Items.IndexOf(ArrPtr[StPos]^.Part);
    TemaChange(Sender);

    Tema.SetFocus;
  end;

  //������� � �����
  if ArrPos[StPos]=2 then
  begin
    Tema.ItemIndex:=Tema.Items.IndexOf(ArrPtr[StPos]^.Part);
    TemaChange(Sender);

    Names.ItemIndex:=Names.Items.IndexOf(ArrPtr[StPos]^.Name);
    NamesClick(Sender);

    Names.SetFocus;
  end;

  //������� � ��������
  if ArrPos[StPos]=3 then
  begin
    Tema.ItemIndex:=Tema.Items.IndexOf(ArrPtr[StPos]^.Part);
    TemaChange(Sender);

    Names.ItemIndex:=Names.Items.IndexOf(ArrPtr[StPos]^.Name);
    NamesClick(Sender);

    Teleph.ItemIndex:=Teleph.Items.IndexOf(ArrPtr[StPos]^.Tel);
    TelephClick(Sender);

    Teleph.SetFocus;
  end;
  StPos:=StPos+1;
  if StPos>StMaxPos then FindNext.Enabled:=false;
end;

procedure TTelephones.NewElemUpdate(Sender: TObject);
begin
  //�������� ��������� ������ �� ���� Part, Name, Tel
  if Names.Focused=True then
  begin
    if Tema.Items.Count=0 then NewElem.Enabled:=false
    else begin
      NewElem.OnExecute:=N3Click; //���� ���� Names � ������
      NewElem.Enabled:=true;
    end
  end
  else begin
    if Teleph.Focused=true then
    begin
      if Names.Items.Count=0 then NewElem.Enabled:=false
      else begin
        NewElem.OnExecute:=N6Click; //���� ���� Teleph � ������
        NewElem.Enabled:=true;
      end
    end
    else begin
      NewElem.OnExecute:=N2Click; //���� ���� Tema ��� ���-�� ������ � ������
      NewElem.Enabled:=true;
    end;
  end;
end;

procedure TTelephones.DelElemUpdate(Sender: TObject);
begin
  //�������� ��������� ������ �� ���� Part, Name, Tel
  if Names.Focused=True then
  begin
    if Names.Items.Count=0 then DelElem.Enabled:=false
    else begin
      DelElem.OnExecute:=N4Click; //���� ���� Names � ������
      DelElem.Enabled:=true;
    end
  end
  else begin
    if Teleph.Focused=true then
    begin
      if Teleph.Items.Count=0 then DelElem.Enabled:=false
      else begin
        DelElem.OnExecute:=N8Click; //���� ���� Teleph � ������
        DelElem.Enabled:=true;
      end
    end
    else begin
      if Tema.Items.Count=0 then DelElem.Enabled:=false
      else begin
        DelElem.OnExecute:=N9Click; //���� ���� Tema ��� ���-�� ������ � ������
        DelElem.Enabled:=true;
      end;
    end;
  end;
end;

procedure TTelephones.EditElemUpdate(Sender: TObject);
begin
  //�������� ��������� ������ �� ���� Part, Name, Tel
  if Names.Focused=True then
  begin
    if Names.Items.Count=0 then EditElem.Enabled:=false
    else begin
      EditElem.OnExecute:=N5Click; //���� ���� Names � ������
      EditElem.Enabled:=true;
    end
  end
  else begin
    if Teleph.Focused=true then
    begin
      if Teleph.Items.Count=0 then EditElem.Enabled:=false
      else begin
        EditElem.OnExecute:=N7Click; //���� ���� Teleph � ������
        EditElem.Enabled:=true;
      end
    end
    else begin
      if Tema.Items.Count=0 then EditElem.Enabled:=false
      else begin
        EditElem.OnExecute:=N10Click; //���� ���� Tema ��� ���-�� ������ � ������
        EditElem.Enabled:=true;
      end;
    end;
  end;

end;

procedure TTelephones.CommentsUpdate(Sender: TObject);
begin
  //�������� ��������� ������ �� ���� Part, Name, Tel
  if Names.Focused=True then
  begin
    if Names.Items.Count=0 then
    begin
      Comments.Enabled:=false;
     // CommentButton.Indeterminate:=true;
    end
    else begin
      Comments.OnExecute:=N1Click; //���� ���� Names � ������
      Comments.Enabled:=true;
    end
  end
  else begin
    if Teleph.Focused=true then
    begin
      if Teleph.Items.Count=0 then Comments.Enabled:=false
      else begin
        Comments.OnExecute:=N11Click; //���� ���� Teleph � ������
        Comments.Enabled:=true;
      end
    end
    else Comments.Enabled:=false
  end;

end;

procedure TTelephones.NamesContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Names.SetFocus;
end;

procedure TTelephones.TelephContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Teleph.SetFocus;
end;

procedure TTelephones.TemaContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin
  Tema.SetFocus;
end;

end.

