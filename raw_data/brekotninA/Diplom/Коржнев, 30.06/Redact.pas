unit Redact;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sButton, sDialogs, Mplayer, sGroupBox, ExtCtrls;

type
  TRedactForm = class(TForm)
    sOpenDialog: TsOpenDialog;
    sGroupBox1: TsGroupBox;
    sButton8: TsButton;
    sButton1: TsButton;
    sButton2: TsButton;
    procedure sButton8Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RedactForm: TRedactForm;

implementation

uses MyDB, ShowAudio, QuestionEditor, ShowVideo, ShowPicture;

{$R *.dfm}

procedure TRedactForm.sButton1Click(Sender: TObject);
var
  ConditionAudio_ID,ConditionVideo_ID,ConditionPhoto_ID:integer;
  SolveAudio_ID,SolveVideo_ID,SolvePhoto_ID:integer;
  Theory, TheoryHelp:string;
begin
  if Application.MessageBox('�� �������?','��������',MB_YESNO)=IDYES then
    begin
      if RedactForm.Caption='�������������� ����� �������' then
        begin
          ConditionAudio_ID:=fdb.ADOQuery117.FieldByName('ConditionAudio_ID').AsInteger;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('ConditionAudio_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=ConditionAudio_ID;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('����� ������� �������!');
        end;
      if RedactForm.Caption='�������������� ����� �������' then
        begin
          SolveAudio_ID:=fdb.ADOQuery117.FieldByName('SolveAudio_ID').AsInteger;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('SolveAudio_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=SolveAudio_ID;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('����� ������� �������!');
        end;
      if RedactForm.Caption='�������������� ����� �������' then
        begin
          ConditionVideo_ID:=fdb.ADOQuery117.FieldByName('ConditionVideo_ID').AsInteger;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('ConditionVideo_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=ConditionVideo_ID;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('����� ������� �������!');
        end;
      if RedactForm.Caption='�������������� ����� �������' then
        begin
          SolveVideo_ID:=fdb.ADOQuery117.FieldByName('SolveVideo_ID').AsInteger;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('SolveVideo_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=SolveVideo_ID;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('����� ������� �������!');
        end;
      if RedactForm.Caption='�������������� ���� �������' then
        begin
          ConditionPhoto_ID:=fdb.ADOQuery117.FieldByName('ConditionPhoto_ID').AsInteger;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('ConditionPhoto_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=ConditionPhoto_ID;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('����������� ������� �������!');
        end;
      if RedactForm.Caption='�������������� ���� �������' then
        begin
          SolvePhoto_ID:=fdb.ADOQuery117.FieldByName('SolvePhoto_ID').AsInteger;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('SolvePhoto_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=SolvePhoto_ID;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('����������� ������� �������!');
        end;
      if RedactForm.Caption='�������������� ������' then
        begin
          Theory:=fdb.ADOQuery117.FieldByName('Theory_ID').AsString;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('Theory_ID').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=Theory;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('������ �������!');
        end;
      if RedactForm.Caption='�������������� ������ ���������' then
        begin
          TheoryHelp:=fdb.ADOQuery117.FieldByName('TheoryHelp_Id').AsString;
          fdb.ADOQuery117.Edit;
          fdb.ADOQuery117.FieldByName('TheoryHelp_Id').Clear;
          fdb.ADOQuery117.Post;
          fdb.ADOQuery170.SQL.Clear;
          fdb.ADOQuery170.SQL.Add('DELETE FROM Multim WHERE ID=:1');
          fdb.ADOQuery170.Parameters.ParamByName('1').Value:=TheoryHelp;
          fdb.ADOQuery170.ExecSQL;
          ShowMessage('������ ��������� �������!');
        end;
      if RedactForm.Caption='�������������� ���� ������' then
        begin
           fdb.Picture_path[QuestionEditorForm.Global_Number-1]:='';
           TImage(QuestionEditorForm.FindComponent('Image'+IntToStr(QuestionEditorForm.Global_Number))).picture:=Nil;
           ShowMessage('���� ����� ������!');
        end;
    end;
end;

procedure TRedactForm.sButton8Click(Sender: TObject);
begin
  if RedactForm.Caption='�������������� ����� �������' then
    begin
      sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
      if sOpenDialog.Execute then
        begin
          fdb.AudioCondition:=sOpenDialog.FileName;
          ShowAudioForm := TShowAudioForm.Create(nil);
          try
            ShowAudioForm.Mode:=0;
            ShowAudioForm.FileName:=fdb.AudioCondition;
            try
              ShowAudioForm.MediaPlayer1.FileName:=ShowAudioForm.FileName;
              ShowAudioForm.MediaPlayer1.Open;
            except
              ShowMessage('�������������� ������ �����!');
              exit;
            end;
            if ShowAudioForm.ShowModal=mrCancel then
              fdb.AudioCondition:='';
            if ShowAudioForm.MediaPlayer1.Mode=mpPlaying then
              ShowAudioForm.MediaPlayer1.Stop;
            finally
              FreeAndNil(ShowAudioForm);
            end;
          if fdb.AudioCondition<>'' then
            ShowMessage('����� ������� ���������!');
        end;
    end; 
  if RedactForm.Caption='�������������� ����� �������' then
    begin
      sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
      if sOpenDialog.Execute then
        begin
          fdb.AudioSolve:=sOpenDialog.FileName;
          ShowAudioForm := TShowAudioForm.Create(nil);
          try
            ShowAudioForm.Mode:=0;
            ShowAudioForm.FileName:=fdb.AudioSolve;
            try
              ShowAudioForm.MediaPlayer1.FileName:=ShowAudioForm.FileName;
              ShowAudioForm.MediaPlayer1.Open;
            except
              ShowMessage('�������������� ������ �����!');
              exit;
            end;
            if ShowAudioForm.ShowModal=mrCancel then
              fdb.AudioSolve:='';
            if ShowAudioForm.MediaPlayer1.Mode=mpPlaying then
              ShowAudioForm.MediaPlayer1.Stop;
          finally
            FreeAndNil(ShowAudioForm);
          end;
          if fdb.AudioSolve<>'' then
            ShowMessage('����� ������� ���������!');
        end;
    end;
  if RedactForm.Caption='�������������� ����� �������' then
    begin
      sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
      if sOpenDialog.Execute then
        begin
          fdb.VideoCondition:=sOpenDialog.FileName;
          ShowVideoForm := TShowVideoForm.Create(nil);
          try
            ShowVideoForm.Mode:=0;
            ShowVideoForm.FileName:=fdb.VideoCondition;
            try
              ShowVideoForm.MediaPlayer1.FileName:=ShowVideoForm.FileName;
              ShowVideoForm.MediaPlayer1.Open;
            except
              ShowMessage('�������������� ������ �����!');
              exit;
            end;
            if ShowVideoForm.ShowModal=mrCancel then
              fdb.VideoCondition:='';
            if ShowVideoForm.MediaPlayer1.Mode=mpPlaying then
              ShowVideoForm.MediaPlayer1.Stop;
            finally
              FreeAndNil(ShowVideoForm);
            end;
            if fdb.VideoCondition<>'' then
              ShowMessage('����� ������� ���������!');
        end;
    end;
  if RedactForm.Caption='�������������� ����� �������' then
    begin
      sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
      if sOpenDialog.Execute then
        begin
          fdb.VideoSolve:=sOpenDialog.FileName;
          ShowVideoForm := TShowVideoForm.Create(nil);
          try
            ShowVideoForm.Mode:=0;
            ShowVideoForm.FileName:=fdb.VideoSolve;
            try
              ShowVideoForm.MediaPlayer1.FileName:=ShowVideoForm.FileName;
              ShowVideoForm.MediaPlayer1.Open;
            except
              ShowMessage('�������������� ������ �����!');
              exit;
            end;
            if ShowVideoForm.ShowModal=mrCancel then
              fdb.VideoSolve:='';
            if ShowVideoForm.MediaPlayer1.Mode=mpPlaying then
              ShowVideoForm.MediaPlayer1.Stop;
            finally
              FreeAndNil(ShowVideoForm);
            end;
            if fdb.VideoSolve<>'' then
              ShowMessage('����� ������� ���������!');
        end;
    end;
    if RedactForm.Caption='�������������� ���� �������' then
      begin
        sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
        if sOpenDialog.Execute then
          begin
            fdb.PhotoCondition:=sOpenDialog.FileName;
            ShowPictureForm := TShowPictureForm.Create(nil);
            try
              ShowPictureForm.Mode:=0;
              ShowPictureForm.FileName:=fdb.PhotoCondition;
              try
                ShowPictureForm.Image1.Picture.LoadFromFile(ShowPictureForm.FileName);
              except
                ShowMessage('�������������� ������ �����!');
                exit;
              end;
              if ShowPictureForm.ShowModal=mrCancel then
                fdb.PhotoCondition:='';
              finally
                FreeAndNil(ShowPictureForm);
              end;
              if fdb.PhotoCondition<>'' then
                ShowMessage('����������� ������� ���������!');
          end;
      end;
    if RedactForm.Caption='�������������� ���� �������' then
      begin
        sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
        if sOpenDialog.Execute then
          begin
            fdb.PhotoSolve:=sOpenDialog.FileName;
            ShowPictureForm := TShowPictureForm.Create(nil);
            try
              ShowPictureForm.Mode:=0;
              ShowPictureForm.FileName:=fdb.PhotoSolve;
              try
                ShowPictureForm.Image1.Picture.LoadFromFile(ShowPictureForm.FileName);
              except
                ShowMessage('�������������� ������ �����!');
                exit;
              end;
              if ShowPictureForm.ShowModal=mrCancel then
                fdb.PhotoSolve:='';
              finally
                FreeAndNil(ShowPictureForm);
              end;
              if fdb.PhotoSolve<>'' then
                ShowMessage('����������� ������� ���������!');
          end;
      end;
    if RedactForm.Caption='�������������� ������' then
      begin
        sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
        if sOpenDialog.Execute then
          begin
            fdb.Theory:=StringReplace(sOpenDialog.FileName, ExtractFilePath(Application.ExeName), '', [rfReplaceAll, rfIgnoreCase]);
            if fdb.Theory<>'' then
              ShowMessage('������ ���������!');
          end;
      end;
    if RedactForm.Caption='�������������� ������ ���������' then
      begin
        sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
        if sOpenDialog.Execute then
          begin
            fdb.TheoryHelp:=StringReplace(sOpenDialog.FileName, ExtractFilePath(Application.ExeName), '', [rfReplaceAll, rfIgnoreCase]);
            if fdb.TheoryHelp<>'' then
              ShowMessage('������ ��������� ���������!');
          end;
      end;
  if RedactForm.Caption='�������������� ���� ������' then
     begin
      sOpenDialog.InitialDir:=ExtractFilePath(Application.ExeName)+'\';
      if sOpenDialog.Execute then
        begin
          fdb.Picture_path[QuestionEditorForm.Global_Number-1]:=StringReplace(sOpenDialog.FileName, ExtractFilePath(Application.ExeName), '', [rfReplaceAll, rfIgnoreCase]);
          TImage(QuestionEditorForm.FindComponent('Image'+IntToStr(QuestionEditorForm.Global_Number))).picture.LoadFromFile(sOpenDialog.FileName);
          ShowMessage('���� ����� ��������!');
        end;
    end;
end;

end.
