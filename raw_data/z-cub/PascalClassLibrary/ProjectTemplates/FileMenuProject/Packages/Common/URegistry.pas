unit URegistry;

{$MODE Delphi}

interface

uses
  Classes, Registry;

type
  TRegistryRoot = (rrKeyClassesRoot, rrKeyCurrentUser, rrKeyLocalMachine,
    rrKeyUsers, rrKeyPerformanceData, rrKeyCurrentConfig, rrKeyDynData);

  { TRegistryContext }

  TRegistryContext = record
    RootKey: HKEY;
    Key: string;
    class operator Equal(A, B: TRegistryContext): Boolean;
    function Create(RootKey: TRegistryRoot; Key: string): TRegistryContext; overload;
    function Create(RootKey: HKEY; Key: string): TRegistryContext; overload;
  end;

  { TRegistryEx }

  TRegistryEx = class(TRegistry)
  private
    function GetCurrentContext: TRegistryContext;
    procedure SetCurrentContext(AValue: TRegistryContext);
  public
    function ReadBoolWithDefault(const Name: string;
      DefaultValue: Boolean): Boolean;
    function ReadIntegerWithDefault(const Name: string; DefaultValue: Integer): Integer;
    function ReadStringWithDefault(const Name: string; DefaultValue: string): string;
    function ReadFloatWithDefault(const Name: string;
      DefaultValue: Double): Double;
    function DeleteKeyRecursive(const Key: string): Boolean;
    function OpenKey(const Key: string; CanCreate: Boolean): Boolean;
    property CurrentContext: TRegistryContext read GetCurrentContext write SetCurrentContext;
  end;

const
  RegistryRootHKEY: array[TRegistryRoot] of HKEY = (HKEY_CLASSES_ROOT,
    HKEY_CURRENT_USER, HKEY_LOCAL_MACHINE, HKEY_USERS, HKEY_PERFORMANCE_DATA,
    HKEY_CURRENT_CONFIG, HKEY_DYN_DATA);

implementation


{ TRegistryContext }

class operator TRegistryContext.Equal(A, B: TRegistryContext): Boolean;
begin
  Result := (A.Key = B.Key) and (A.RootKey = B.RootKey);
end;

function TRegistryContext.Create(RootKey: TRegistryRoot; Key: string): TRegistryContext;
begin
  Result.RootKey := RegistryRootHKEY[RootKey];
  Result.Key := Key;
end;

function TRegistryContext.Create(RootKey: HKEY; Key: string): TRegistryContext;
begin
  Result.RootKey := RootKey;
  Result.Key := Key;
end;

{ TRegistryEx }

function TRegistryEx.ReadIntegerWithDefault(const Name: string;
  DefaultValue: Integer): Integer;
begin
  if ValueExists(Name) then Result := ReadInteger(Name)
    else begin
      WriteInteger(Name, DefaultValue);
      Result := DefaultValue;
    end;
end;

function TRegistryEx.ReadStringWithDefault(const Name: string;
  DefaultValue: string): string;
begin
  if ValueExists(Name) then Result := ReadString(Name)
    else begin
      WriteString(Name, DefaultValue);
      Result := DefaultValue;
    end;
end;

function TRegistryEx.ReadFloatWithDefault(const Name: string;
  DefaultValue: Double): Double;
begin
  if ValueExists(Name) then Result := ReadFloat(Name)
    else begin
      WriteFloat(Name, DefaultValue);
      Result := DefaultValue;
    end;
end;

function TRegistryEx.DeleteKeyRecursive(const Key: string): Boolean;
var
  SubKeys: TStringList;
  I: Integer;
begin
  try
    SubKeys := TStringList.Create;
    if OpenKey(Key, False) and HasSubKeys then begin
      GetKeyNames(SubKeys);
      for I := 0 to SubKeys.Count - 1 do
        DeleteKeyRecursive(Key + '\' + SubKeys[I]);
    end;
    Result := DeleteKey(Key);
  finally
    SubKeys.Free;
  end;
end;

function TRegistryEx.OpenKey(const Key: string; CanCreate: Boolean): Boolean;
begin
  {$IFDEF Linux}
  CloseKey;
  {$ENDIF}
  Result := inherited OpenKey(Key, CanCreate);
end;

function TRegistryEx.GetCurrentContext: TRegistryContext;
begin
  Result.Key := CurrentPath;
  Result.RootKey := RootKey;
end;

procedure TRegistryEx.SetCurrentContext(AValue: TRegistryContext);
begin
  RootKey := AValue.RootKey;
  OpenKey(AValue.Key, True);
end;

function TRegistryEx.ReadBoolWithDefault(const Name: string;
  DefaultValue: Boolean): Boolean;
begin
  if ValueExists(Name) then Result := ReadBool(Name)
    else begin
      WriteBool(Name, DefaultValue);
      Result := DefaultValue;
    end;
end;

end.
