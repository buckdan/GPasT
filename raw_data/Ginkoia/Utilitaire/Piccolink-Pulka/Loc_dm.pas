//------------------------------------------------------------------------------
// Nom de l'unit� :
// R�le           :
// Auteur         :
// Historique     :
// jj/mm/aaaa - Auteur - v 1.0.0 : Cr�ation
//------------------------------------------------------------------------------

unit Loc_dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ActionRv, Db, DBTables;

type
  Tdm_loc = class(TDataModule)
    Grd_Que: TGroupDataRv;
    BASE: TDatabase;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    procedure Refresh;
  end;

var
  dm_loc: Tdm_loc;

//------------------------------------------------------------------------------
// Ressources strings
//------------------------------------------------------------------------------
//ResourceString

implementation
USES ConstStd;
{$R *.DFM}

//------------------------------------------------------------------------------
// Proc�dures et fonctions internes
//------------------------------------------------------------------------------
procedure Tdm_loc.Refresh;
begin
  Grd_Que.Refresh;
end;

//------------------------------------------------------------------------------
// Gestionnaires d'�v�nements
//------------------------------------------------------------------------------

procedure Tdm_loc.DataModuleDestroy(Sender: TObject);
begin
  Grd_Que.Close;
  base.close;
end;

procedure Tdm_loc.DataModuleCreate(Sender: TObject);
begin
     base.open;
end;

end.
