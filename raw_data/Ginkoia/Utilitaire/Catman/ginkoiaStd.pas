//------------------------------------------------------------------------------
// Nom de l'unit� :
// R�le           :
// Auteur         :
// Historique     :
// jj/mm/aaaa - Auteur - v 1.0.0 : Cr�ation
//------------------------------------------------------------------------------

UNIT ginkoiaStd;

INTERFACE

USES
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    ActionRv, BmDelay;

TYPE
    TStdGinKoia = CLASS(TDataModule)
    Delay_Main: TBmDelay;
    PRIVATE
    { D�clarations priv�es }
    PUBLIC
    { D�clarations publiques }
    PROCEDURE AffecteHintEtBmp(Panel: TWinControl);


    END;

VAR
    StdGinKoia: TStdGinKoia;
     PROCEDURE Delai(Value: Integer);
IMPLEMENTATION


procedure TStdGinKoia.AffecteHintEtBmp(Panel: TWinControl);
begin
END;

PROCEDURE Delai(Value: Integer);
begin
   // value = pause indiqu�e en secondes ...
   StdGinKoia.Delay_main.WaitForDelay(Value)
END;

{$R *.DFM}

END.

