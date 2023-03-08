unit UFastBitmap;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dialogs;

type

  TFastBitmapPixel = Cardinal;
  (*TFastBitmapPixel = record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
  end;*)
  PFastBitmapPixel = ^TFastBitmapPixel;

  TFastBitmapPixelComponents = packed record
    B, G, R, A: Byte;
  end;

const
  FastPixelSize = SizeOf(TFastBitmapPixel);

type
  { TFastBitmap }

  TFastBitmap = class
  private
    FPixelsData: PByte;
    FSize: TPoint;
    function GetPixel(X, Y: Integer): TFastBitmapPixel; inline;
    procedure SetPixel(X, Y: Integer; const AValue: TFastBitmapPixel); inline;
    procedure SetSize(const AValue: TPoint);
  public
    constructor Create;
    destructor Destroy; override;
    procedure RandomImage(Index, Count: Integer);
    property Size: TPoint read FSize write SetSize;
    property Pixels[X, Y: Integer]: TFastBitmapPixel read GetPixel write SetPixel;
    property PixelsData: PByte read FPixelsData;
  end;

  { TFastBitmap3 }

  TFastBitmap3 = class
  private
    FPixelsData: PByte;
    FSize: TPoint;
    procedure SetSize(const AValue: TPoint);
  public
    constructor Create;
    destructor Destroy; override;
    procedure RandomImage;
    property Size: TPoint read FSize write SetSize;
    function GetPixelAddress(X, Y: Integer): PFastBitmapPixel; inline;
    function GetPixelSize: Integer; inline;
  end;

  TFastBitmap2 = class
  private
    function GetSize: TPoint;
    procedure SetSize(const AValue: TPoint);
  public
    Pixels: array of array of TFastBitmapPixel;
    procedure RandomImage;
    property Size: TPoint read GetSize write SetSize;
  end;

function SwapBRComponent(Value: Cardinal): Cardinal; inline;
function NoSwapBRComponent(Value: Cardinal): Cardinal; inline;

implementation

function SwapBRComponent(Value: Cardinal): Cardinal;
begin
//  Result := (Value and $00ff00) or ((Value shr 16) and $ff) or ((Value and $ff) shl 16);
  Result := Value;
  TFastBitmapPixelComponents(Result).R := TFastBitmapPixelComponents(Value).B;
  TFastBitmapPixelComponents(Result).B := TFastBitmapPixelComponents(Value).R;
end;

function NoSwapBRComponent(Value: Cardinal): Cardinal;
begin
//  Result := (Value and $00ff00) or ((Value shr 16) and $ff) or ((Value and $ff) shl 16);
  Result := Value;
  TFastBitmapPixelComponents(Result).B := TFastBitmapPixelComponents(Value).B;
  TFastBitmapPixelComponents(Result).R := TFastBitmapPixelComponents(Value).R;
end;

{ TFastBitmap3 }

procedure TFastBitmap3.SetSize(const AValue: TPoint);
begin
  if (FSize.X = AValue.X) and (FSize.Y = AValue.X) then Exit;
  FSize := AValue;
  FPixelsData := ReAllocMem(FPixelsData, FSize.X * FSize.Y * SizeOf(TFastBitmapPixel));
end;

constructor TFastBitmap3.Create;
begin
  inherited;
  Size := Point(0, 0);
end;

destructor TFastBitmap3.Destroy;
begin
  FreeMem(FPixelsData);
  inherited Destroy;
end;

procedure TFastBitmap3.RandomImage;
var
  I, X, Y: Integer;
  PRow: PFastBitmapPixel;
  PPixel: PFastBitmapPixel;
begin
  for I := 0 to 2 do begin
    PRow := GetPixelAddress(I * (Size.X div 3), 0);
    for Y := 0 to (Size.Y div 2) - 1 do begin
      PPixel := PRow;
      for X := 0 to (Size.X div 3) - 1 do begin
        PPixel^ := 255 shl (I * 8);
        Inc(PPixel);
      end;
      Inc(PRow, Size.X);
    end;
  end;

  PRow := GetPixelAddress(0, Size.Y div 2);
  for Y := (Size.Y div 2) to Size.Y - 1 do begin
    PPixel := PRow;
    for X := 0 to Size.X - 1 do begin
      PPixel^ := Random(256) or (Random(256) shl 16) or (Random(256) shl 8);
      Inc(PPixel);
    end;
    Inc(PRow, Size.X);
  end;
end;

function TFastBitmap3.GetPixelAddress(X, Y: Integer): PFastBitmapPixel;
begin
  Result := PFastBitmapPixel(FPixelsData) + Y * FSize.X + X;
end;

function TFastBitmap3.GetPixelSize: Integer;
begin
  Result := SizeOf(TFastBitmapPixel);
end;

{ TFastBitmap2 }

function TFastBitmap2.GetSize: TPoint;
begin
  Result.X := Length(Pixels);
  if Result.X > 0 then Result.Y := Length(Pixels[0])
    else Result.Y := 0;
end;

procedure TFastBitmap2.SetSize(const AValue: TPoint);
begin
  SetLength(Pixels, AValue.X, AValue.Y);
end;

procedure TFastBitmap2.RandomImage;
var
  X, Y: Integer;
begin
  for Y := 0 to Size.Y - 1 do
    for X := 0 to Size.X - 1 do
      Pixels[X, Y] := Random(256);
end;

{ TFastBitmap }

function TFastBitmap.GetPixel(X, Y: Integer): TFastBitmapPixel;
begin
  Result := PFastBitmapPixel(FPixelsData + (Y * FSize.X + X) * FastPixelSize)^;
end;

procedure TFastBitmap.SetPixel(X, Y: Integer; const AValue: TFastBitmapPixel);
begin
  PFastBitmapPixel(FPixelsData + (Y * FSize.X + X) * FastPixelSize)^ := AValue;
end;

procedure TFastBitmap.SetSize(const AValue: TPoint);
begin
  if (FSize.X = AValue.X) and (FSize.Y = AValue.X) then Exit;
  FSize := AValue;
  FPixelsData := ReAllocMem(FPixelsData, FSize.X * FSize.Y * FastPixelSize);
end;

constructor TFastBitmap.Create;
begin
  Size := Point(0, 0);
end;

destructor TFastBitmap.Destroy;
begin
  FreeMem(FPixelsData);
  inherited Destroy;
end;

procedure TFastBitmap.RandomImage(Index, Count: Integer);
var
  I, X, Y: Integer;
begin
  // Main three color blocks
  for I := 0 to 2 do
    for Y := 0 to (Size.Y div 3) - 1 do
      for X := 0 to (Size.X div 3) - 1 do
        Pixels[X + (I * (Size.X div 3)), Y] := (255 shl (I * 8)) and $ffffff;

  // Random noise
  for Y := (Size.Y div 3) to (Size.Y * 2 div 3) - 1 do
    for X := 0 to Size.X - 1 do
      Pixels[X, Y] := (Random(256) or (Random(256) shl 16) or (Random(256) shl 8)) and $ffffff;

  // Color gradient
  for Y := (Size.Y * 2 div 3) to (Size.Y - 1) do begin
    for X := 0 to Size.X - 1 do
      Pixels[X, Y] := (Trunc(Sin((X + Trunc(Index / Count * Size.X)) mod Size.X
        / Size.X * pi) * 255) * $010101) and $ffffff;
  end;
end;


end.

