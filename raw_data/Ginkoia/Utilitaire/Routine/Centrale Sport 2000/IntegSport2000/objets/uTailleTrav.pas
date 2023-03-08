unit uTailleTrav;

interface

uses
  uSynchroObjBDD;

type
  {$M+}
  TTailleTrav = class(TMyObject)
  private
    FArtid: integer;
    FTgfid: integer;
   protected
    const
    TABLE_NAME='PLXTAILLESTRAV';
    TABLE_TRIGRAM='TTV';
    TABLE_PK='TTV_ID';
  public
    constructor create(); overload;
  published
    property Artid: integer read FArtid write FArtid;
    property Tgfid: integer read FTgfid write FTgfid;
  end;
  {$M-}

implementation

{ TTaillesTrav }
constructor TTailleTrav.create;
begin
   inherited  Create(TABLE_NAME, TABLE_TRIGRAM, TABLE_PK);
end;

end.
