unit UThreadStatusForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  UCDClient;

type

  { TThreadStatusForm }

  TThreadStatusForm = class(TForm)
  published
    CoolDockClient1: TCDClient;
    ListView1: TListView;
    { private declarations }
  public
    { public declarations }
  end; 

var
  ThreadStatusForm: TThreadStatusForm;

implementation

{$R *.lfm}

end.

