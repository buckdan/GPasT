unit mainparam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ImgList, Winapi.ShellApi,
  ufunctions, Data.DB, Datasnap.DBClient, System.IOUtils  ;

type
  {$REGION 'Documentation'}
  ///	<summary>
  ///	  Programme de param�trage des URLs pour l'application de d�ploiement.
  ///	</summary>
  {$ENDREGION}
  TFmain = class(TForm)
    edtLame: TButtonedEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Label1: TLabel;
    ImageList1: TImageList;
    edtMAJ: TButtonedEdit;
    Label2: TLabel;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Clientdataset utilis� par g�rer le fichier XML.
    ///	</summary>
    {$ENDREGION}
    DSParam: TClientDataSet;

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  <para>
    ///	    Cet �v�nement est utilis�pour les deux zones d'�dition.
    ///	  </para>
    ///	  <para>
    ///	    Un bouton , � la droite de la zone d'�dition devient visible si la
    ///	    longueure du texte d�passe 10 caract�res. Ce bouton permet de
    ///	    tester la validit� de l'Url saisie.
    ///	  </para>
    ///	</summary>
    ///	<remarks>
    ///	  Noter l'utilisation des string helpers
    ///	</remarks>
    {$ENDREGION}
    procedure edtLameChange(Sender: TObject);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  Lancement du navigateur par d�faut pour tester la validit� de la
    ///	  l'Url.
    ///	</summary>
    {$ENDREGION}
    procedure edtLameRightButtonClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  A l'affichage de la fen�tre on cr�e dynamiquement le clientdataset.
    ///	  Si le fichier XML existe il est charg�.. Les zones d'�dition
    ///	  recoivent alors le texte concern� d�cod�. Si non le fichier XML est
    ///	  cr�� par le clientdataset et les zones d'�dition re�oivent les
    ///	  valeurs par d�faut cod�es en dur.�
    ///	</summary>
    {$ENDREGION}
    procedure FormShow(Sender: TObject);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  <para>
    ///	    L'enregistrement des param�tres se fait dans un fichier XML plac�
    ///	    dans le m�me r�pertoire que l'exe . Le fichir XML est nom�
    ///	    "Deploiement.xml"
    ///	  </para>
    ///	  <para>
    ///	    Les donn�es sont encrypt�es dans le fichier.
    ///	  </para>
    ///	  <para>
    ///	    On enregistre le fichier que si� les deux champs sont renseign�s.
    ///	  </para>
    ///	</summary>
    ///	<seealso cref="uFunctions|EnCryptDeCrypt">
    ///	  Fonction d'encryptage et de d�cryptage
    ///	</seealso>
    {$ENDREGION}
    procedure btnOkClick(Sender: TObject);

    {$REGION 'Documentation'}
    ///	<summary>
    ///	  On ferme le clientdataset qui sera sauvegard� dans le fichier XML
    ///	</summary>
    {$ENDREGION}
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmain: TFmain;

implementation

{$R *.dfm}

procedure TFmain.btnCancelClick(Sender: TObject);
begin
  Application.Terminate ;
end;

procedure TFmain.btnOkClick(Sender: TObject);
begin
if edtlame.Text = '' then 
 begin
   beep ;
   beep ;
   edtlame.SetFocus ;
   exit ;
 end;
if edtMaj.Text = '' then
begin 
   beep ;
   beep ;
   edtMaj.SetFocus ;
   exit ;
end;
if DSparam.RecordCount = 0 then
 begin
   DSParam.Insert ;
   DSParam.FieldByName('Lame').AsString := EncryptDecrypt(edtLame.Text) ;
   DSParam.FieldByName('Maj').AsString := EncryptDecrypt(edtMaj.Text) ;
   DSParam.Post ;
 end else
 begin
   Dsparam.Edit ;
   DSParam.FieldByName('Lame').AsString := EncryptDecrypt(edtLame.Text) ;
   DSParam.FieldByName('Maj').AsString := EncryptDecrypt(edtMaj.Text) ;
   DSParam.Post ;   
 end;
 Dsparam.Close ;
 Application.Terminate ;
end;

procedure TFmain.edtLameChange(Sender: TObject);
var fs : string ;
begin
 fs := TButtonedEdit(Sender).Text ;
 if fs.Length > 0 then
  begin
    TButtonedEdit(Sender).RightButton.Visible := true ;
    TButtonedEdit(Sender).Update ;
  end else
  begin
    TButtonedEdit(Sender).RightButton.Visible := false ;
    TButtonedEdit(Sender).Update ;  
  end;
end;

procedure TFmain.edtLameRightButtonClick(Sender: TObject);
var sUrl : string ;
begin
  sUrl := TButtonedEdit(Sender).Text ;
  if sUrl.IsEmpty = false then
   begin  
     ShellExecute(handle, 'open', Pwchar(sUrl),nil, nil, SW_NORMAL) ;
   end;
end;

procedure TFmain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DSParam.Close ;
end;

procedure TFmain.FormShow(Sender: TObject);
var sFile : string ;
begin
  sFile := IncludeTrailingPathDelimiter(Tpath.GetDirectoryName(Paramstr(0)))+
           'Deploiement.xml' ;
  DSParam.FileName := sFile ;
  With DSParam do
   begin         
     With Tstringfield.Create(Self) do
      begin
        Name := 'PLame' ;
        FieldKind :=fkData ;
        Fieldname := 'Lame' ;
        Size := 1024 ;
        Dataset := DSParam ;
      end;
      With Tstringfield.Create(Self) do
      begin
        Name := 'PMAJ' ;
        FieldKind :=fkData ;
        Fieldname := 'Maj' ;
        Size := 1024 ;
        Dataset := DSParam ;
      end; 
   end;

   If fileExists(sFile) then
    begin
     DSParam.Open ;
     Dsparam.First ;
     edtLame.Text := EncryptDecrypt(DSparam.FieldByName('Lame').AsString) ;
     edtMaj.Text := EncryptDecrypt(DSparam.FieldByName('Maj').AsString) ;
     
    end else
    begin
     DSParam.CreateDataSet ;
     edtLame.Text := 'http://lame2.no-ip.com/algol/Bases/' ;
     edtMaj.Text := 'http://lame2.no-ip.com/maj/' ;
     
    end;

   DSParam.AggregatesActive := True ;  
end;

end.
