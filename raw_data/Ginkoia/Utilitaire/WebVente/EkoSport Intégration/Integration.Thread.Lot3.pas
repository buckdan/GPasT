unit Integration.Thread.Lot3;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Types,
  System.StrUtils,
  System.Math,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.IB,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.Stan.StorageXML,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Integration.Ressources,
  Integration.Methodes;

type
  TThreadLot3 = class(TThread)
  strict private
    { D�clarations priv�es }
    FIntegre    : Boolean;
    FDossier    : string;
    FCodeMagasin: string;
    procedure Journaliser(const AMessage: string; const ANiveau: TNiveau = NivTrace; const ASurcharge: Boolean = False);
  protected
    procedure Execute(); override;
  public
    { D�clarations publiques }
    BaseDonnees     : TFileName;
    FichierClients  : TFileName;
    LblProgression  : TLabel;
    PbProgression   : TProgressBar;
    ImgClients      : TImage;
    bSauvegarde     : Boolean;
    property Integre: Boolean
      read   FIntegre;
  end;

implementation

uses
  Integration.Form.Principale;

{ TThreadLot3 }

procedure TThreadLot3.Execute();
var
  FDConnection        : TFDConnection;
  FDTransaction       : TFDTransaction;
  QueInfoDossier      : TFDQuery;
  QueIntegration      : TFDQuery;
  MemTFichier         : TFDMemTable;
  FDPhysIBDriverLink  : TFDPhysIBDriverLink;
  FDStanStorageXMLLink: TFDStanStorageXMLLink;
  cSeparateur         : Char;
  sSeparateur         : string;
  i, j                : Integer;
  slFichier           : TStringList;
  sdaLigne            : TStringDynArray;
  fsFrance            : TFormatSettings;
  flNombre            : Double;
  dtDate              : TDateTime;
  bErreurLigne        : Boolean;
  bErreurFloat        : Boolean;
  iRetour             : Integer;
  iRetourPAY          : Integer;
  iRetourVIL          : Integer;
  iRetourADR          : Integer;
  iRetourCBI          : Integer;
  iNbErreur           : Integer;
  sMessage            : string;
  sCheminDump         : string;
  slListeCourriel     : TStringList;
begin
  // R�cup�re le s�parateur
  if FindCmdLineSwitch('SEPARATEUR', sSeparateur) then
    cSeparateur := sSeparateur[1]
  else
    cSeparateur := SEPARATEUR;

  FIntegre             := False;
  FDConnection         := TFDConnection.Create(nil);
  FDTransaction        := TFDTransaction.Create(nil);
  QueInfoDossier       := TFDQuery.Create(nil);
  QueIntegration       := TFDQuery.Create(nil);
  MemTFichier          := TFDMemTable.Create(nil);
  FDPhysIBDriverLink   := TFDPhysIBDriverLink.Create(nil);
  FDStanStorageXMLLink := TFDStanStorageXMLLink.Create(nil);
  slFichier            := TStringList.Create();
  slListeCourriel      := TStringList.Create();
  // Charge les formats pour la France
  // -> http://msdn.microsoft.com/library/bb165625
  fsFrance := TFormatSettings.Create($40C);

  try
    LblProgression.Caption := Format(RS_CHARGEFICHIERLOT3, [ExtractFileName(FichierClients)]);
    Journaliser(Format(RS_CHARGEFICHIERLOT3, [ExtractFileName(FichierClients)]));

    // Initialise le nombre d'erreurs
    iNbErreur := 0;

{$REGION 'Connexion � la base de donn�es'}
    try
      LblProgression.Caption := RS_CONNEXION;
      Journaliser(RS_CONNEXION);

      FDConnection.Params.Clear();
      FDConnection.Params.Add('DriverID=IB');
      FDConnection.Params.Add('User_Name=ginkoia');
      FDConnection.Params.Add('Password=ginkoia');
      FDConnection.Params.Add('Protocol=TCPIP');
      FDConnection.Params.Add('Server=localhost');
      FDConnection.Params.Add('Port=3050');
      FDConnection.Params.Add(Format('Database=%s', [BaseDonnees]));
      FDConnection.Transaction := FDTransaction;

      FDTransaction.Connection := FDConnection;

      QueIntegration.Connection  := FDConnection;
      QueIntegration.Transaction := FDTransaction;

      QueInfoDossier.Connection  := FDConnection;
      QueInfoDossier.Transaction := FDTransaction;
      QueInfoDossier.SQL.Clear();
      QueInfoDossier.SQL.Add('SELECT BAS_NOMPOURNOUS, MAG_IDENT');
      QueInfoDossier.SQL.Add('FROM   GENBASES');
      QueInfoDossier.SQL.Add('  JOIN K KBAS       ON (KBAS.K_ID = BAS_ID AND KBAS.K_ENABLED = 1)');
      QueInfoDossier.SQL.Add('  JOIN GENPARAMBASE ON (BAS_IDENT = PAR_STRING AND PAR_NOM = ''IDGENERATEUR'')');
      QueInfoDossier.SQL.Add('  JOIN GENMAGASIN   ON (MAG_ID = BAS_MAGID)');
      QueInfoDossier.SQL.Add('  JOIN K KMAG       ON (KMAG.K_ID = MAG_ID AND KMAG.K_ENABLED = 1);');

      QueInfoDossier.Open();
      try
        if not(QueInfoDossier.IsEmpty()) then
        begin
          FDossier     := QueInfoDossier.FieldByName('BAS_NOMPOURNOUS').AsString;
          FCodeMagasin := QueInfoDossier.FieldByName('MAG_IDENT').AsString;
        end;
      finally
        QueInfoDossier.Close();
      end;

      Journaliser(RS_DEBUT, NivNotice, True);

      QueIntegration.SQL.Clear();
      QueIntegration.SQL.Add('SELECT  RETOUR,');
      QueIntegration.SQL.Add('        RETOURPAY,');
      QueIntegration.SQL.Add('        RETOURVIL,');
      QueIntegration.SQL.Add('        RETOURADR,');
      QueIntegration.SQL.Add('        RETOURCBI');
      QueIntegration.SQL.Add('FROM    EKOSPORT_INTEGRATION_LOT3(');
      QueIntegration.SQL.Add('          :CLIENT_ID,');
      QueIntegration.SQL.Add('          :EMAIL,');
      QueIntegration.SQL.Add('          :NOM,');
      QueIntegration.SQL.Add('          :PRENOM,');
      QueIntegration.SQL.Add('          :URL,');
      QueIntegration.SQL.Add('          :ADR1,');
      QueIntegration.SQL.Add('          :ADR2,');
      QueIntegration.SQL.Add('          :ADR3,');
      QueIntegration.SQL.Add('          :VILLE,');
      QueIntegration.SQL.Add('          :ZIPCODE,');
      QueIntegration.SQL.Add('          :COUNTRYCODE,');
      QueIntegration.SQL.Add('          :DATE_NAISSANCE,');
      QueIntegration.SQL.Add('          :FIDELITE,');
      QueIntegration.SQL.Add('          :TEL);');
      QueIntegration.Prepare();
    except
      on e: Exception do
      begin
        Journaliser(Format(RS_ERREUR_CONNEXION, [e.ClassName, e.Message]), NivErreur);
        FDTransaction.Rollback();
      end;
    end;

    // Arr�te le thread si annul�
    if Self.Terminated then
      Exit;
{$ENDREGION 'Connexion � la base de donn�es'}

{$REGION 'Cr�ation de la table en m�moire'}
    MemTFichier.FieldDefs.Clear();
    MemTFichier.FieldDefs.Add('CLIENT_ID', ftString, 32, True);
    MemTFichier.FieldDefs.Add('EMAIL', ftString, 64, True);
    MemTFichier.FieldDefs.Add('NOM', ftString, 64);
    MemTFichier.FieldDefs.Add('PRENOM', ftString, 64);
    MemTFichier.FieldDefs.Add('URL', ftString, 1024);
    MemTFichier.FieldDefs.Add('ADR1', ftString, 64);
    MemTFichier.FieldDefs.Add('ADR2', ftString, 64);
    MemTFichier.FieldDefs.Add('ADR3', ftString, 64);
    MemTFichier.FieldDefs.Add('VILLE', ftString, 64);
    MemTFichier.FieldDefs.Add('ZIPCODE', ftString, 32);
    MemTFichier.FieldDefs.Add('COUNTRYCODE', ftString, 32);
    MemTFichier.FieldDefs.Add('DATE_NAISSANCE', ftDateTime, 0);
    MemTFichier.FieldDefs.Add('FIDELITE', ftString, 64);
    MemTFichier.FieldDefs.Add('TEL', ftString, 32);
    MemTFichier.FieldDefs.Add('NUMLIGNE', ftInteger, 0, True);

    // Arr�te le thread si annul�
    if Self.Terminated then
      Exit;
{$ENDREGION 'Cr�ation de la table en m�moire'}

{$REGION 'Chargement du fichier en m�moire'}
    Journaliser(Format(RS_CHARGEMENT_FICHIER, [ExtractFileName(FichierClients)]), NivNotice);
    slFichier.LoadFromFile(FichierClients);
    MemTFichier.Open();

    PbProgression.Max := slFichier.Count;

{$REGION 'V�rifie l�en-t�te du fichier'}
    sdaLigne := SplitString(slFichier[0], cSeparateur);

    if Length(sdaLigne) <> MemTFichier.FieldDefs.Count - 1 then
    begin
      Journaliser(RS_ERREURENTETELOT1_NBCHAMPS, NivErreur);
      Exit;
    end;

    for i := 0 to MemTFichier.FieldDefs.Count - 2 do
    begin
      if not(SameText(MemTFichier.FieldDefs[i].Name, sdaLigne[i])) then
      begin
        Journaliser(Format(RS_ERREURENTETELOT1_NOMCHAMP, [MemTFichier.FieldDefs[i].Name, sdaLigne[i]]), NivErreur);
        Exit;
      end;
    end;
{$ENDREGION 'V�rifie l�en-t�te du fichier'}

    // V�rification des lignes du fichier
    PbProgression.Position := 0;
    PbProgression.Max      := slFichier.Count - 1;
    for i                  := 1 to slFichier.Count - 1 do
    begin
      PbProgression.Position := i;
      sdaLigne               := SplitString(slFichier[i], cSeparateur);
      bErreurLigne           := False;

{$REGION 'V�rifie de la validit� de la ligne'}
      // V�rifie que le nombre de champs est correct
      if not(Length(sdaLigne) = MemTFichier.FieldDefs.Count - 1) then
      begin
        Journaliser(Format(RS_ERREURLIGNELOT3_NBCHAMPS, [i]), NivErreur);

        // Arr�te le thread si annul�
        if Self.Terminated then
          Exit;

        Inc(iNbErreur);
        Continue;
      end;

      // V�rifie que les champs requis sont renseign�s
      for j := 0 to Length(sdaLigne) - 1 do
      begin
        bErreurLigne := False;

        // V�rifie que le champ n'est pas vide
        if MemTFichier.FieldDefs[j].Required and (sdaLigne[j] = '') then
        begin
          Journaliser(Format(RS_ERREURLIGNELOT3_CHAMPREQUI, [i, MemTFichier.FieldDefs[j].Name]), NivErreur);
          Inc(iNbErreur);
          bErreurLigne := True;
          Break;
        end;

        // V�rifie que le format de donn�es est correcte
        if sdaLigne[j] <> '' then
        begin
          case MemTFichier.FieldDefs[j].DataType of
            ftString:
              begin
                // V�rifie la taille de la cha�ne
                if Length(sdaLigne[j]) > MemTFichier.FieldDefs[j].Size then
                begin
                  Journaliser(Format(RS_ERREURLIGNELOT3_MVFORMAT, [i, MemTFichier.FieldDefs[j].Name, Format('STRING(%d)', [MemTFichier.FieldDefs[j].Size])]), NivErreur);
                  Inc(iNbErreur);
                  bErreurLigne := True;
                  Break;
                end;
              end;
            ftFloat:
              begin
                // V�rifie le format du nombre � virgule
                bErreurFloat := not(TryStrToFloat(sdaLigne[j], flNombre, fsFrance));
                if bErreurFloat or not((-99999999999.9999999 <= flNombre) and (flNombre <= 99999999999.9999999)) then
                begin
                  Journaliser(Format(RS_ERREURLIGNELOT1_MVFORMAT, [i, MemTFichier.FieldDefs[j].Name, 'NUMERIC(18,7)']), NivErreur);
                  Inc(iNbErreur);
                  bErreurLigne := True;
                  Break;
                end;
              end;
            ftDateTime:
              begin
                // V�rifie le format de la date
                if not(TryIso8601BasicToDate(sdaLigne[j], dtDate)) then
                begin
                  Journaliser(Format(RS_ERREURLIGNELOT1_MVFORMAT, [i, MemTFichier.FieldDefs[j].Name, 'AAAAMMJJ']), NivErreur);
                  Inc(iNbErreur);
                  bErreurLigne := True;
                  Break;
                end;
              end;
          end;
        end;

        // Arr�te le thread si annul�
        if Self.Terminated then
          Exit;
      end;
{$ENDREGION 'V�rifie de la validit� de la ligne'}

{$REGION 'Ajoute la ligne � la table en m�moire'}
      if not(bErreurLigne) then
      begin
        MemTFichier.Append();

        MemTFichier.FieldByName('NUMLIGNE').AsInteger := i;

        for j := 0 to Length(sdaLigne) - 1 do
        begin
          case MemTFichier.Fields[j].DataType of
            ftString:
              begin
                case AnsiIndexText(MemTFichier.Fields[j].FieldName, ['NOM', 'PRENOM', 'EMAIL']) of
                  // NOM, PRENOM
                  0 .. 1:
                    MemTFichier.Fields[j].AsString := AnsiUpperCase(sdaLigne[j]);
                  // EMAIL
                  2:
                    MemTFichier.Fields[j].AsString := AnsiLowerCase(sdaLigne[j]);
                  else
                    MemTFichier.Fields[j].AsString := sdaLigne[j];
                end;
              end;
            ftFloat:
              begin
                MemTFichier.Fields[j].AsFloat := StrToFloat(sdaLigne[j], fsFrance);
              end;
            ftDateTime:
              begin
                TryIso8601BasicToDate(sdaLigne[j], dtDate);
                MemTFichier.Fields[j].AsDateTime := dtDate;
              end;
          end;
        end;

        MemTFichier.Post();
      end;
{$ENDREGION 'Ajoute la ligne � la table en m�moire'}

      // Arr�te le thread si annul�
      if Self.Terminated then
        Exit;
    end;

    if bSauvegarde then
    begin
      try
        sCheminDump := ChangeFileExt(FichierClients, '.xml');
        Journaliser(Format(RS_VIDANGE, [sCheminDump]));
        MemTFichier.SaveToFile(sCheminDump, sfXML);
      except
        on e: Exception do
          Journaliser(Format(RS_ERREUR_VIDANGE, [e.ClassName, e.Message]), NivErreur);
      end;
    end;
{$ENDREGION 'Chargement du fichier en m�moire'}

{$REGION 'Int�gration des clients'}
    PbProgression.Position := 0;
    PbProgression.Max      := MemTFichier.RecordCount;
    LblProgression.Caption := Format(RS_MSG_LOT3_INTEGRATION, [0, MemTFichier.RecordCount, '', '', '']);
    MemTFichier.First();

    // D�marre la transaction
    FDTransaction.StartTransaction();

    // Parcours toutes les lignes r�cup�r�es du fichier
    while not(MemTFichier.Eof) do
    begin
      try
        // Met � jour la progression
        LblProgression.Caption := Format(RS_MSG_LOT3_INTEGRATION,
          [MemTFichier.RecNo, MemTFichier.RecordCount]);

        // Pr�pare la proc�dure stock�e pour l'int�gration
        QueIntegration.Params.ClearValues();
        for i := 0 to QueIntegration.ParamCount - 1 do
        begin
          // Renseigne tous les param�tres de la proc�dure avec les valeurs du fichier
          QueIntegration.Params[i].Value := MemTFichier.FieldByName(QueIntegration.Params[i].Name).Value;
        end;

        // Ex�cute la proc�dure d'int�gration
        if QueIntegration.Active then
          QueIntegration.Close();

        QueIntegration.Open();

        // R�cup�re les r�sultats de la proc�dure stock�e
        iRetour    := QueIntegration.FieldByName('RETOUR').AsInteger;
        iRetourPAY := QueIntegration.FieldByName('RETOURPAY').AsInteger;
        iRetourVIL := QueIntegration.FieldByName('RETOURVIL').AsInteger;
        iRetourADR := QueIntegration.FieldByName('RETOURADR').AsInteger;
        iRetourCBI := QueIntegration.FieldByName('RETOURCBI').AsInteger;

{$REGION 'Interpr�te les retours'}
        // Retour du client
        case iRetour of
          // Erreur
          CR_LOT3_ERREUR:
            begin
              Journaliser(Format(RS_MSG_LOT3_ERREUR,
                [MemTFichier.RecNo,
                 MemTFichier.RecordCount,
                 MemTFichier.FieldByName('EMAIL').AsString,
                 MemTFichier.FieldByName('NOM').AsString,
                 MemTFichier.FieldByName('PRENOM').AsString]),
                NivErreur);
              Inc(iNbErreur);
            end;
          // Cr�ation du client
          CR_LOT3_CREATION:
            begin
              Journaliser(Format(RS_MSG_LOT3_CREATION,
                [MemTFichier.RecNo,
                 MemTFichier.RecordCount,
                 MemTFichier.FieldByName('EMAIL').AsString,
                 MemTFichier.FieldByName('NOM').AsString,
                 MemTFichier.FieldByName('PRENOM').AsString]));
            end;
          // Mise � jour du client
          CR_LOT3_MISEAJOUR:
            begin
              Journaliser(Format(RS_MSG_LOT3_MISEAJOUR,
                [MemTFichier.RecNo,
                 MemTFichier.RecordCount,
                 MemTFichier.FieldByName('EMAIL').AsString,
                 MemTFichier.FieldByName('NOM').AsString,
                 MemTFichier.FieldByName('PRENOM').AsString]));
            end;
          // Aucune modification du client
          CR_LOT3_AUCUNEMODIFICATION:
            begin
              Journaliser(Format(RS_MSG_LOT3_AUCUNEMODIFICATION,
                [MemTFichier.RecNo,
                 MemTFichier.RecordCount,
                 MemTFichier.FieldByName('EMAIL').AsString,
                 MemTFichier.FieldByName('NOM').AsString,
                 MemTFichier.FieldByName('PRENOM').AsString]));
            end;
        end;

        // Retour pour le pays
        case iRetourPAY of
          // Pays d�j� existant
          0:
            Journaliser(RS_MSG_LOT3_PAY0);
          // Cr�ation du pays
          1:
            Journaliser(RS_MSG_LOT3_PAY1);
          // Inconnu
          else
            Journaliser(Format('[%s] - %s', [RS_MSG_LOT3_PAY, RS_MSG_LOT3_INCONNU]), NivErreur);
        end;

        // Retour pour la ville
        case iRetourVIL of
          // Ville d�j� existante
          0:
            Journaliser(RS_MSG_LOT3_VIL0);
          // Cr�ation de la ville
          1:
            Journaliser(RS_MSG_LOT3_VIL1);
          // Inconnu
          else
            Journaliser(Format('[%s] - %s', [RS_MSG_LOT3_VIL, RS_MSG_LOT3_INCONNU]), NivErreur);
        end;

        // Retour pour l'adresse
        case iRetourADR of
          // Aucune modification de l'adresse
          0:
            Journaliser(RS_MSG_LOT3_ADR0);
          // Cr�ation de l'adresse
          1:
            Journaliser(RS_MSG_LOT3_ADR1);
          // Mise � jour de l'adresse
          2:
            Journaliser(RS_MSG_LOT3_ADR2);
          // Inconnu
          else
            Journaliser(Format('[%s] - %s', [RS_MSG_LOT3_ADR, RS_MSG_LOT3_INCONNU]), NivErreur);
        end;

        // Retour pour la carte de fid�lit�
        case iRetourCBI of
          // Carte de fid�lit� non renseign�e
          0:
            Journaliser(RS_MSG_LOT3_CBI0);
          // Cr�ation de la carte de fid�lit�
          1:
            Journaliser(RS_MSG_LOT3_CBI1);
          // Mise � jour de la carte de fid�lit�
          2:
            Journaliser(RS_MSG_LOT3_CBI2);
          // Aucune modification de la carte de fid�lit�
          3:
            Journaliser(RS_MSG_LOT3_CBI3);
          // Erreur : la carte de fid�lit� existe d�j�
          4:
            Journaliser(RS_MSG_LOT3_CBI4, NivErreur);
          // Inconnu
          else
            Journaliser(Format('[%s] - %s', [RS_MSG_LOT3_CBI, RS_MSG_LOT3_INCONNU]), NivErreur);
        end;
{$ENDREGION 'Interpr�te les retours'}
      except
        on e: Exception do
        begin
          // Erreur lors de l'int�gration
          Journaliser(Format(RS_ERREUR_INTEGRATION,
            [MemTFichier.FieldByName('NUMLIGNE').AsInteger,
             MemTFichier.FieldByName('CLIENT_ID').AsString,
             MemTFichier.FieldByName('EMAIL').AsString,
             Trim(MemTFichier.FieldByName('NOM').AsString + ' ' + MemTFichier.FieldByName('PRENOM').AsString),
             e.ClassName,
             e.Message]),
            NivErreur);

          // Annule les actions sur la base de donn�es
          FDTransaction.Rollback();
        end;
      end;

      // Arr�te le thread si annul�
      if Self.Terminated then
        Exit;

      // Ligne suivante
      PbProgression.Position := MemTFichier.RecNo;
      MemTFichier.Next();
    end;

    // Validation de l'int�gration du fichier
    if (iNbErreur = 0) or (FindCmdLineSwitch('VALIDER_ERREURS')) then
    begin
      FDTransaction.Commit();
      FIntegre := True;
    end
    else
    begin
      // Annule les actions sur la base de donn�es
      FDTransaction.Rollback();
      if iNbErreur = 1 then
        Journaliser(RS_ERREUR_FICHIER, NivArret)
      else
        Journaliser(Format(RS_ERREURS_FICHIER, [iNbErreur]), NivArret);
    end;
{$ENDREGION 'Int�gration des clients'}
  finally
    // Si le thread a �t� arr�t� : annuler la transaction
    if Self.Terminated then
      FDTransaction.Rollback();

    slListeCourriel.Free();
    slFichier.Free();
    FDConnection.Free();
    FDTransaction.Free();
    QueIntegration.Free();
    QueInfoDossier.Free();
    MemTFichier.Free();
    FDPhysIBDriverLink.Free();
    FDStanStorageXMLLink.Free();
  end;

  LblProgression.Caption := RS_TERMINEE;
  Journaliser(RS_TERMINEE, NivNotice, True);
end;

procedure TThreadLot3.Journaliser(const AMessage: string; const ANiveau: TNiveau = NivTrace; const ASurcharge: Boolean = False);
begin
  // Envoi un message au journal de l'application
  Synchronize(
    procedure
    begin
      FormPrincipale.Journaliser(AMessage, ANiveau);
    end);
end;

end.
