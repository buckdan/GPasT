unit UMyConsoleApp;

interface

uses
  SysUtils, Forms, UConsoleApp, UObjectType, UConsole, UFileSystem,
  UTextScreen, Graphics;

type
  TMyConsoleApp = class(TConsoleApp)
    procedure Execute; override;
  end;

implementation

{ TMyConsoleApp }

procedure TMyConsoleApp.Execute;
var
  I: Integer;
  Text: string;
begin
  Randomize;
  with Screen, Keyboard do begin
    WriteLn('Zav�d�n� syst�mu ChronOS...');
    TextColor := clSilver;
    ClearEol;
    Sleep(500);
    for I := 0 to 10 do begin
      WriteLn(' Slu�ba ' + IntToStr(I) + ' na�tena');
      Sleep(Random(300));
    end;
    repeat
      WriteLn;
      Write('[u�ivatel@server /]: ');
      Text := ReadLn;
      WriteLn;
      if Text = 'verze' then WriteLn(' Verze: 0.0.1')
      else if Text = 'n�pov�da' then begin
        WriteLn('Seznam p��kaz�');
        WriteLn(' n�pov�da - zobraz� tento v�pis');
        WriteLn(' verze - zobraz� verzi syst�mu');
        WriteLn(' konec - ukon�� syst�m');
      end else if Text = 'konec' then WriteLn('Syst�m ukon�en')
      else WriteLn('Nezn�m� p��kaz');
    until Text = 'konec';
  end;
end;

end.
