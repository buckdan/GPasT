//------------------------------------------------------------------------------
// Nom de l'unit� :
// R�le           :
// Auteur         :
// Historique     :
// jj/mm/aaaa - Auteur - v 1.0.0 : Cr�ation
//------------------------------------------------------------------------------

UNIT GinkoiaStd;

INTERFACE

USES
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

// L'outil de d�doublonnage n'a pas besoin de ramener tout le monde (Ginkoia, Caisse, Cash, etc...).
// Cette fiche est vide pour pouvoir compiler le projet et limiter les d�pendances inutiles.   
TYPE
    TStdGinkoia = CLASS(TDataModule)
    PRIVATE
    { D�clarations priv�es }
    PUBLIC
      procedure SaveOrLoadDBGGrilleConfiguration(A: Boolean; B: TObject; C: Boolean);
    { D�clarations publiques }
    END;

VAR
    StdGinkoia: TStdGinkoia;

IMPLEMENTATION

{$R *.DFM}

{ TStdGinkoia }

procedure TStdGinkoia.SaveOrLoadDBGGrilleConfiguration(A: Boolean; B: TObject;
  C: Boolean);
begin
  // Ne rien faire.
end;

END.

