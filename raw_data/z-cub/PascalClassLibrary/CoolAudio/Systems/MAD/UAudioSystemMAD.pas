unit UAudioSystemMAD;

{$I UCoolAudioConfig.inc}
{$mode delphi}{$H+}

interface

{$IFDEF AudioSystemMAD}
uses
  Classes, SysUtils, mad, UAudioSystem;

type
  TAudioSystemMAD = class(TAudioSystem)
  public
    function GetMediaPlayerDriverClass: TMediaPlayerDriverClass; override;
  end;

  { TPlayerMAD }

  TPlayerMAD = class(TMediaPlayerDriver)
  public
    procedure Play; override;
    procedure Pause; override;
    procedure Stop; override;
  end;

{$ENDIF}

implementation

{$IFDEF AudioSystemMAD}

{ TAudioSystemMAD }

function TAudioSystemMAD.GetMediaPlayerDriverClass: TMediaPlayerDriverClass;
begin
  Result := TPlayerMAD;
end;

{ TPlayerMAD }

procedure TPlayerMAD.Play;
begin
  inherited Play;

end;

procedure TPlayerMAD.Pause;
begin
  inherited Pause;
end;

procedure TPlayerMAD.Stop;
begin
  inherited Stop;
end;

{$ENDIF}

end.
