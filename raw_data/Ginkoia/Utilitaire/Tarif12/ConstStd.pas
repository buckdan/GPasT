//------------------------------------------------------------------------------
// Nom de l'unit� :  ConstStd
// R�le           : Mise en place des variables globales de l'application
// Auteur         : Herve PULLUARD
// Historique     :
//------------------------------------------------------------------------------

UNIT ConstStd;

INTERFACE

USES
    Windows,
    Messages,
    SysUtils,
    Classes,
    Graphics,
    Controls,
    Forms,
    Dialogs,
    LMDIniCtrl,
    vgStndrt,
    ALSTDlg,
    BmDelay,
    LMDSysInfo,
    LMDCustomComponent,
    LMDContainerComponent,
    lmdmsg,
    RxCalc;

TYPE
    TStdConst = CLASS ( TDataModule )
        Calc_Main: TRxCalculator;
        Mbox_Mess: TLMDMessageBoxDlg;
        SysInf_Main: TLMDSysInfo;
        Delay_Main: TBmDelay;
        Tip_Main: TALSTipDlg;
        PropSto_Const: TPropStorage;
        AppIni_Main: TAppIniFile;
        IniCtrl: TLMDIniCtrl;
        CurSto_Main: TCurrencyStorage;
    TimeSto_Main: TDateTimeStorage;
        PROCEDURE DataModuleCreate ( Sender: TObject ) ;
    Private
    { D�clarations priv�es }
        Fnl, Fcl: Boolean;
        FCalc: Double;

        FNM, FNP, FPatBase, FIniApp, FPatLect, FPatApp, FPatHelp: STRING;
        PROCEDURE SetFnl ( Value: Boolean ) ;
        PROCEDURE SetFcl ( Value: Boolean ) ;
        PROCEDURE ConstDoInit;

    Public
    { D�clarations publiques }
        PROPERTY NumLock: Boolean Read Fnl Write SetFnl;
        PROPERTY Capslock: Boolean Read Fcl Write SetFcl;
        PROPERTY CalcResult: Double Read FCalc;

        PROPERTY IniFileName: STRING Read FIniApp;
        PROPERTY PathApp: STRING Read FPatApp;
        PROPERTY PathLecteur: STRING Read FPatLect;
        PROPERTY PathHelp: STRING Read FPatHelp;
        PROPERTY PathBase: STRING Read FPatBase Write FPatBase;
        PROPERTY NomPoste: STRING Read FNP Write FNP;
        PROPERTY NomDuMag: STRING Read FNM Write FNM;

    Published
    END;

VAR
    StdConst: TStdConst;

//------------------------------------------------------------------------------
// Ressources strings
//------------------------------------------------------------------------------
RESOURCESTRING
{$I C:\Borland\Algol\Standards\Includes\ConstRes.Pas}
// **************************************************
// Ce fichier inclu contient toutes les ressources globales communes � nos applications
// ***********************************************************************

{$I C:\Borland\Algol\Standards\Includes\ConstUIL.Pas}
// **************************************************
// Ce fichier inclu contient toutes les ressources globales pour la gestion des droits utilisateur communes � nos applications
// ***********************************************************************

// D�clarer ci-dessous les ressources globales de cette application
// ***********************************************************************

{$I C:\Borland\Algol\Standards\Includes\ConstRoutines.Pas}
// *******************************************************
// Ce fichier inclu contient la d�claration de toutes les routines globales
// communes � nos applications
// ***********************************************************************
// D�clarer ci-dessous les routines globales de cette application
// ***********************************************************************

IMPLEMENTATION

USES StdUtils;

{$R *.DFM}
{$I C:\Borland\Algol\Standards\Includes\ConstCode.Pas}
// ***************************************************
// Ce fichier inclu contient tout le code des routines globales communes

//------------------------------------------------------------------------------
// Proc�dures et fonctions internes
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Gestionnaires d'�v�nements
//------------------------------------------------------------------------------

PROCEDURE TStdConst.DataModuleCreate ( Sender: TObject ) ;
BEGIN

     ConstDoInit;
    { ConstDoInit initialise
           - nom et path init (PathAppli\NomAppli.Ini)
           - path application
           - nom fichier et path help (PathAppli\Help)
           - connecte le composant IniCtrl au fichier INI
           - initialise les Tips (charge PathAppli\NomAppli.Tip)
           - initialise les propri�t�s de la forme }
    Application.HelpFile := '';
    // Lorsque le fichier Help existe, supprimer cette ligne

    { A rajouter ici toute la gestion propre du fichier ini de d�marrage
      Le Dm_main s'occupe de sa partie
      Nota : si on veut utiliser un autre fichier ini que celui par d�faut
      il suffit d'�craser ici avec son code perso ... }

END;

END.
