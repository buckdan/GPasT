unit GKEasyComptageExport.Thread.Connexion;

interface

uses
  System.Classes,
  System.SysUtils,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.Comp.Client,
  FireDAC.Phys,
  FireDAC.Phys.IB,
  FireDAC.DApt,
  UMapping,
  GKEasyComptageExport.Ressources,
  GKEasyComptageExport.Methodes;

type
  TThreadConnexion  = class(TThread)
  private
    { D�clarations priv�es }
    FConnecte     : Boolean;
    procedure Erreur(const ATentative, ANbTentatives : Integer;
      const AType, AMessage: String);
    procedure Journaliser(AMessage: String; ANiveau: TNiveau = NivDetail);
  protected
    { D�clarations prot�g�es }
    procedure Execute(); override;
  public
    { D�clarations publiques }
    FDConnection      : TFDConnection;
    ParamsConnexion   : TParamsConnexion;
    NomPoste          : string;
    NomMag            : string;
    property Connecte : Boolean read FConnecte;
  end;

implementation

uses
  GKEasyComptageExport.Form.Main;

{ TThreadConnexion }

procedure TThreadConnexion.Erreur(const ATentative, ANbTentatives : Integer;
  const AType, AMessage: String);
begin
  // Affiche le message d'erreur
  Journaliser(Format(RS_ERR_BARRE_STATUS, [ATentative, ANbTentatives, AType, AMessage]), NivErreur);
  Synchronize(
    procedure
    begin
      FormMain.StbStatut.Panels[0].Text := Format(RS_ERR_BARRE_STATUS,
        [ATentative, ANbTentatives, AType, AMessage]);
    end);
end;

procedure TThreadConnexion.Journaliser(AMessage: String; ANiveau: TNiveau = NivDetail);
begin
  // Envoi un message au journal de l'application
  Synchronize(procedure
  begin
    FormMain.Journaliser(AMessage, ANiveau);
  end);
end;

procedure TThreadConnexion.Execute();
var
  iEssais : Integer;
begin
  // Tente de se connecter � la base de donn�es
  FDConnection.Params.Clear();
  FDConnection.Params.Add('DriverID=IB');
  FDConnection.Params.Add('User_Name=ginkoia');
  FDConnection.Params.Add('Password=ginkoia');
  FDConnection.Params.Add(Format('Database=%s', [ParamsConnexion.BaseDonnees]));

  iEssais := 0;
  repeat
    Inc(iEssais);

    try
      if not(MapGinkoia.Backup
        or MapGinkoia.LiveUpdate
        or MapGinkoia.MajAuto
        or MapGinkoia.Script) then
        FDConnection.Open()
      else
        raise EErreurIBTraitement.Create(RS_ERR_TRAITEMENT + Format(' Attente %.0f sec.', [ParamsConnexion.Delais / 1000]));
    except
      on E: Exception do
        Erreur(iEssais, ParamsConnexion.NbEssais, E.ClassName, E.Message);
    end;

    if Self.Terminated then
      Break;

    if not(FDConnection.Connected) then
      Sleep(ParamsConnexion.Delais);
  until (FDConnection.Connected or (Succ(iEssais) > ParamsConnexion.NbEssais));

  // Retour l'�tat de connexion � la base de donn�es
  FConnecte := FDConnection.Connected;
end;

end.
