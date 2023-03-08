unit uExecNettoieGinkoia;

interface

uses SysUtils, StrUtils, uLog, LaunchProcess;

  function ExecNettoieGinkoia(const nDureeMax: Integer; const sRepertoireDestination, sBasDossier, sBasGuid: String): Boolean;

const
  TIMEOUT = -1;
  DERNIERE_EXECUTION_MEME_JOUR = -2;
  ERREUR_REPERTOIRE_INEXISTANT = -3;
  ERREUR_COMPRESSION_REPERTOIRE = -4;
  ERREUR_SUPPRESSION_REPERTOIRE = -5;
  ERREUR_SUPPRESSION_FICHIER_COMPRESSE = -6;
  ERREUR_NOM_REPERTOIRE_JOUR = -7;
  ERREUR_SUPPRESSION_FICHIER_LOGS = -8;
  ERREUR_SUPPRESSION_FICHIER = -9;
  ERREUR_CREATION_SOUS_REPERTOIRES = -10;
  ERREUR_DEPLACEMENT_FICHIER_COMPRESSE = -11;

implementation

function ExecNettoieGinkoia(const nDureeMax: Integer; const sRepertoireDestination, sBasDossier, sBasGuid: String): Boolean;
{$REGION 'ExecNettoieGinkoia'}
  function GetLibelleErreur(const nCodeRetour: Integer): String;
  begin
    case nCodeRetour of
      TIMEOUT:
        Result := 'Time out';
      DERNIERE_EXECUTION_MEME_JOUR:
        Result := 'Derni�re ex�cution le m�me jour';
      ERREUR_REPERTOIRE_INEXISTANT:
        Result := 'Erreur r�pertoire inexistant';
      ERREUR_COMPRESSION_REPERTOIRE:
        Result := 'Erreur lors de la compression d''un r�pertoire';
      ERREUR_SUPPRESSION_REPERTOIRE:
        Result := 'Erreur lors de la suppression d''un r�pertoire';
      ERREUR_SUPPRESSION_FICHIER_COMPRESSE:
        Result := 'Erreur lors de la suppression d''un fichier compress�';
      ERREUR_NOM_REPERTOIRE_JOUR:
        Result := 'Erreur de nom de r�pertoire jour';
      ERREUR_SUPPRESSION_FICHIER_LOGS:
        Result := 'Erreur lors de la suppression d''un fichier LOGS';
      ERREUR_SUPPRESSION_FICHIER:
        Result := 'Erreur lors de la suppression d''un fichier';
      ERREUR_CREATION_SOUS_REPERTOIRES:
        Result := 'Erreur lors de la suppression d''un sous-r�pertoire';
      ERREUR_DEPLACEMENT_FICHIER_COMPRESSE:
        Result := 'Erreur lors du d�placement d''un fichier compress�';
    else
      Result := 'Autre erreur [' + IntToStr(nCodeRetour) + ']';
    end;
  end;
{$ENDREGION}
var
  nCodeRetour: Integer;
  sErreur: String;
begin
  Result := True;
  if FileExists(ExtractFilePath(ParamStr(0)) + 'NettoieGinkoia.exe') then
  begin
    // Ex�cution de NettoieGinkoia (dur�e maximum = nDureeMax).
    nCodeRetour := ExecAndWaitProcessTimeout(sErreur, ExtractFilePath(ParamStr(0)) + 'NettoieGinkoia.exe', '/AUTO' + IfThen(sRepertoireDestination <> '', ' /MV"' + sRepertoireDestination + '"'), nDureeMax);
    if nCodeRetour = 0 then
      Log.Log('NettoieGinkoia', sBasGuid, 'OK' , logInfo, True, 0, ltServer)
    else
      Log.Log('NettoieGinkoia', sBasGuid, GetLibelleErreur(nCodeRetour) , logError, True, 0, ltServer);

    if nCodeRetour = TIMEOUT then
      Result := False;
  end
  else
    Log.Log('NettoieGinkoia', sBasGuid,'Programme introuvable' , logError, True, 0, ltServer);
end;

end.

