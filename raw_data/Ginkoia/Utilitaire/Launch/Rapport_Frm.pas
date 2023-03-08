//------------------------------------------------------------------------------
// Nom de l'unit� :
// R�le           :
// Auteur         :
// Historique     :
// jj/mm/aaaa - Auteur - v 1.0.0 : Cr�ation
//------------------------------------------------------------------------------

UNIT Rapport_Frm;

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
    AlgolStdFrm,
    FileCtrl,
    Launch_Frm,
    LMDControl,
    LMDBaseControl,
    LMDBaseGraphicButton,
    LMDCustomSpeedButton,
    LMDSpeedButton,
    ExtCtrls,
    RzPanel,
    fcStatusBar,
    RzBorder,
    LMDCustomComponent,
    LMDWndProcComponent,
    LMDFormShadow,
    Db,
    dxmdaset,
    dxDBCtrl,
    dxDBGrid,
    dxDBTLCl,
    dxGrClms,
    dxTL,
    dxCntner,
    dxDBGridRv,
    dxPSCore,
    dxPSdxTLLnk,
    dxPSdxDBCtrlLnk,
    dxPSdxDBGrLnk,
    RvCustomDbg,
    Buttons,
    DBSBtn,
    RzPanelRv,
    UserDlg;

TYPE
    TFrm_Rapport = CLASS(TAlgolStdFrm)
        Stat_Dlg: TfcStatusBar;
        Pan_Btn: TRzPanel;
        SBtn_Ok: TLMDSpeedButton;
        Bev_Dlg: TRzBorder;
        MemD_Rapport: TdxMemData;
        MemD_RapportidDate: TDateTimeField;
        MemD_Rapportdate: TDateField;
        MemD_RapportHeure: TTimeField;
        MemD_RapportType: TStringField;
        MemD_RapportModule: TStringField;
        Dbg_Rapport: TdxDBGridRv;
        Ds_Rapport: TDataSource;
        Dbg_RapportDate: TdxDBGridDateColumn;
        Dbg_RapportHeure: TdxDBGridTimeColumn;
        Dbg_RapportType: TdxDBGridMaskColumn;
        Dbg_RapportModule: TdxDBGridMaskColumn;
        RzPanelRv1: TRzPanelRv;
        Nbt_CmzDbg: TDBSpeedButton;
        Nbt_Popup: TDBSpeedButton;
        Nbt_Excel: TDBSpeedButton;
        SBtn_Suppr: TLMDSpeedButton;
        DxCmz_Rapport: TCustomDxDbg;
        DxPrt_Rapport: TdxComponentPrinter;
        dxImp_Replic: TdxDBGridReportLink;
        UserDlg_PrintGrille: TUserDlg;
        DBSpeedButton1: TDBSpeedButton;
        DBSpeedButton2: TDBSpeedButton;
        PROCEDURE SBtn_OkClick(Sender: TObject);
        PROCEDURE SBtn_CancelClick(Sender: TObject);
        PROCEDURE AlgolMainFrmKeyDown(Sender: TObject; VAR Key: Word;
            Shift: TShiftState);
        PROCEDURE AlgolStdFrmCreate(Sender: TObject);
        PROCEDURE AlgolStdFrmClose(Sender: TObject; VAR Action: TCloseAction);
        PROCEDURE Nbt_CmzDbgClick(Sender: TObject);
        PROCEDURE Nbt_PopupClick(Sender: TObject);
        PROCEDURE Nbt_ExcelClick(Sender: TObject);
        PROCEDURE SBtn_SupprClick(Sender: TObject);
        PROCEDURE DBSpeedButton1Click(Sender: TObject);
        PROCEDURE DBSpeedButton2Click(Sender: TObject);
    PRIVATE
    { Private declarations }
    PROTECTED
    { Protected declarations }
    PUBLIC
    { Public declarations }
        FUNCTION Execute: TModalResult;
    PUBLISHED

    END;

VAR
    Frm_Rapport: TFrm_Rapport;

//------------------------------------------------------------------------------
// Ressources strings
//------------------------------------------------------------------------------
//ResourceString

IMPLEMENTATION
{$R *.DFM}
//USES ConstStd;

//------------------------------------------------------------------------------
// Proc�dures et fonctions internes
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Gestionnaires d'�v�nements
//------------------------------------------------------------------------------

FUNCTION TFrm_Rapport.Execute: TModalResult;
BEGIN
    Frm_Rapport := TFrm_Rapport.Create(Application);
    TRY
        Result := Frm_Rapport.Showmodal;
    FINALLY
        Frm_Rapport.Free;
    END;
END;

PROCEDURE TFrm_Rapport.AlgolMainFrmKeyDown(Sender: TObject;
    VAR Key: Word; Shift: TShiftState);
BEGIN
    CASE key OF
        VK_ESCAPE: SBtn_CancelClick(Sender);
        VK_F12: SBtn_OkClick(Sender);
    END;
END;

PROCEDURE TFrm_Rapport.SBtn_OkClick(Sender: TObject);
BEGIN
    ModalResult := mrOk;
END;

PROCEDURE TFrm_Rapport.SBtn_CancelClick(Sender: TObject);
BEGIN
    ModalResult := mrCancel;
END;

PROCEDURE TFrm_Rapport.AlgolStdFrmCreate(Sender: TObject);
BEGIN
    MemD_Rapport.Close;
    MemD_Rapport.LoadFromTextFile(PathEAI1 + 'Rapport.txt');
    MemD_Rapport.Filtered := True;
    MemD_Rapport.Open;
END;

PROCEDURE TFrm_Rapport.AlgolStdFrmClose(Sender: TObject;
    VAR Action: TCloseAction);
BEGIN
    MemD_Rapport.Close;
END;

PROCEDURE TFrm_Rapport.Nbt_CmzDbgClick(Sender: TObject);
VAR
    Flag: Boolean;
BEGIN
    Flag := Dbg_Rapport.ShowGroupPanel;
    Dbg_Rapport.ShowGroupPanel := True;
    IF DxCmz_Rapport.execute THEN
    BEGIN
        IF Dbg_Rapport.count > 0 THEN
            Dbg_Rapport.focusedNode.Selected := True;
        Dbg_Rapport.FullExpand;
    END;
    Dbg_Rapport.ShowGroupPanel := Flag;
END;

PROCEDURE TFrm_Rapport.Nbt_PopupClick(Sender: TObject);
BEGIN
    dxImp_Replic.ExtendedSelect := False;
    dxImp_Replic.OnlySelected := False;
    dxImp_Replic.Options := dxImp_Replic.Options + [tlpoHeaders,
        tlpoPreviewGrid, tlpoGrid, tlpoFlatCheckMarks];
    IF Dbg_Rapport.SelectedCount = 0 THEN
        Dbg_Rapport.FocusedNode.Selected := True;
    IF Dbg_Rapport.GroupColumnCount > 0 THEN
        dxImp_Replic.Options := dxImp_Replic.Options +
            [tlpoFooters, tlpoRowFooters];
    CASE UserDlg_PrintGrille.Show OF
        0: dxImp_Replic.OnlySelected := True;
        1: dxImp_Replic.OnlySelected := False;
        2: Exit;
    END;

    dxImp_Replic.Preview(True);
END;

PROCEDURE TFrm_Rapport.Nbt_ExcelClick(Sender: TObject);
BEGIN
    IF Trim(Dbg_Rapport.ExcelFileName) = '' THEN
        IF NOT DirectoryExists(ExtractFilePath(Application.ExeName) + 'Exports') THEN
        BEGIN
            TRY
                CreateDir(ExtractFilePath(Application.ExeName) + 'Exports');
                Dbg_Rapport.ExcelFileName := ExtractFilePath(Application.ExeName) + 'Exports';
            EXCEPT
            END;
        END;

    Dbg_Rapport.OpenExcel(Dbg_Rapport.ExcelFileName + '\RapportReplication', True);
END;

PROCEDURE TFrm_Rapport.SBtn_SupprClick(Sender: TObject);
VAR LaDate: TDateTime;
BEGIN
     // Choisir la adte : Effacer jusqu'au ?
     // LaDate :=

     // Effacer
    MemD_Rapport.First;
    WHILE NOT MemD_Rapport.Eof DO
    BEGIN
//          if (MemD_Rapport.FieldByname('Date').AsDateTime < Ladate) then
//             MemD_Rapport.Delete;
        MemD_Rapport.next;
    END;
     // Sauve le Rapport
    MemD_Rapport.Filtered := True;
    MemD_Rapport.SaveToTextFile(PathEAI1 + 'Rapport.txt');
END;

PROCEDURE TFrm_Rapport.DBSpeedButton1Click(Sender: TObject);
BEGIN
    Dbg_Rapport.FullExpand;
END;

PROCEDURE TFrm_Rapport.DBSpeedButton2Click(Sender: TObject);
BEGIN
    Dbg_Rapport.FullCollapse;
END;

END.
