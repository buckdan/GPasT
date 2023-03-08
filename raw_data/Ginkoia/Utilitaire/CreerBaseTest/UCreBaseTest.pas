//$Log:
// 3    Utilitaires1.2         12/10/2017 10:40:34    Antoine JOLY    LDF Lot 3
//      : Mode ?cole et identification de base
// 2    Utilitaires1.1         06/09/2017 16:07:29    Antoine JOLY    LDF Lot 3
//      : Cr?er base test : cr?ation du genparambase si il n'existe pas
// 1    Utilitaires1.0         06/09/2017 15:50:55    Antoine JOLY    
//$
//$NoKeywords$
//
unit UCreBaseTest;

interface

uses
   registry,
   FileCtrl,
   inifiles,
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
   StdCtrls, Buttons, RzLabel, ArtLabel,
   DFClasses, Backgnd, IBDatabase, Db, IBCustomDataSet, IBQuery;

type
   TFrm_Crertest = class(TForm)
      Lib1: TRzLabel;
      Lib2: TRzLabel;
      BitBtn3: TBitBtn;
      Lib3: TRzLabel;
      Lab_Etat: TLabel;
      data: TIBDatabase;
      SQL: TIBQuery;
      tran: TIBTransaction;
      procedure FormCreate(Sender: TObject);
      procedure BitBtn3Click(Sender: TObject);
   private
    { D�clarations priv�es }
      Labase: string;
      creer: Boolean;
    procedure MajGenparambase(basePath: string);
   public
    { D�clarations publiques }
   end;

var
   Frm_Crertest: TFrm_Crertest;

implementation

{$R *.DFM}

procedure TFrm_Crertest.FormCreate(Sender: TObject);
var
   reg: TRegistry;
begin
   reg := TRegistry.Create;
   try
      reg.access := Key_Read;
      Reg.RootKey := HKEY_LOCAL_MACHINE;
      reg.OpenKey('SOFTWARE\Algol\Ginkoia', False);
      Labase := reg.ReadString('Base0');
   finally
      reg.free;
   end;
   if (trim(Labase) = '') or (not FileExists(Labase)) then
   begin
      creer := False;
      lib3.visible := true;
      lib1.visible := false;
      lib2.visible := false;
      //Art_Crer.visible := false;
      //Art_Modif.visible := True;
   end
   else
   begin
      creer := True;
      //Art_Crer.visible := true;
      //Art_Modif.visible := false;
      lib3.visible := false;
      lib1.visible := true;
      lib2.visible := true;
   end;
end;

procedure TFrm_Crertest.BitBtn3Click(Sender: TObject);
var
   path: string;
   chem: string;
   ini: TiniFile;
   ss: string;
   S: string;
   mag: string;
   poste: string;
   i: Integer;
   ouelleest: string;

   procedure changeChemin;
   begin
      if FileExists(Path + 'ginkoia.ini') then
      begin
         ini := tinifile.create(Path + 'ginkoia.ini');
         SS := Uppercase(Labase);
         while pos(':', SS) > 0 do
            delete(SS, 1, pos(':', SS));
         ini := tinifile.create(Path + 'ginkoia.ini');
         i := 0;
         while i < 10 do
         begin
            S := Uppercase(ini.ReadString('DATABASE', 'PATH' + Inttostr(i), ''));
            if pos(SS, S) > 0 then
               BREAK;
            inc(i);
         end;
         if i < 10 then
         begin
            Poste := ini.ReadString('NOMPOSTE', 'POSTE' + Inttostr(i), '');
            ouelleest := ini.ReadString('DATABASE', 'PATH' + Inttostr(i), '');
            i := 0;
            while i < 10 do
            begin
               S := Uppercase(ini.ReadString('NOMMAGS', 'MAG' + Inttostr(i), ''));
               if pos('TEST', S) > 0 then
                  BREAK;
               inc(i);
            end;
            if i = 10 then
            begin
               i := 0;
               while i < 10 do
               begin
                  S := Uppercase(ini.ReadString('NOMMAGS', 'MAG' + Inttostr(i), ''));
                  if trim(S) = '' then
                     BREAK;
                  inc(i);
               end;
               if i < 10 then
               begin
                  chem := ExcludeTrailingBackslash(ExtractFilePath(ouelleest));
                  while Chem[Length(chem)] <> '\' do
                     delete(chem, length(chem), 1);
                  Chem := Chem + 'test\test.IB';
                  ini.WriteString('DATABASE', 'PATH' + Inttostr(i), Chem);
                  ini.WriteString('NOMMAGS', 'MAG' + Inttostr(i), 'TEST');
                  ini.WriteString('NOMPOSTE', 'POSTE' + Inttostr(i), poste);
                  ini.WriteString('NOMBASES', 'ITEM' + Inttostr(i), 'TEST');
               end;
            end;
         end;
         ini.free;
      end;
      if FileExists(Path + 'CaisseGinkoia.ini') then
      begin
         ini := tinifile.create(Path + 'CaisseGinkoia.ini');
         SS := Uppercase(Labase);
         while pos(':', SS) > 0 do
            delete(SS, 1, pos(':', SS));
         ini := tinifile.create(Path + 'CaisseGinkoia.ini');
         i := 0;
         while i < 10 do
         begin
            S := Uppercase(ini.ReadString('DATABASE', 'PATH' + Inttostr(i), ''));
            if pos(SS, S) > 0 then
               BREAK;
            inc(i);
         end;
         if i < 10 then
         begin
            Poste := ini.ReadString('NOMPOSTE', 'POSTE' + Inttostr(i), '');
            ouelleest := ini.ReadString('DATABASE', 'PATH' + Inttostr(i), '');
            i := 0;
            while i < 10 do
            begin
               S := Uppercase(ini.ReadString('NOMMAGS', 'MAG' + Inttostr(i), ''));
               if pos('TEST', S) > 0 then
                  BREAK;
               inc(i);
            end;
            if i = 10 then
            begin
               i := 0;
               while i < 10 do
               begin
                  S := Uppercase(ini.ReadString('NOMMAGS', 'MAG' + Inttostr(i), ''));
                  if trim(S) = '' then
                     BREAK;
                  inc(i);
               end;
               if i < 10 then
               begin
                  chem := ExcludeTrailingBackslash(ExtractFilePath(ouelleest));
                  while Chem[Length(chem)] <> '\' do
                     delete(chem, length(chem), 1);
                  Chem := Chem + 'test\test.IB';
                  ini.WriteString('DATABASE', 'PATH' + Inttostr(i), Chem);
                  ini.WriteString('NOMMAGS', 'MAG' + Inttostr(i), 'TEST');
                  ini.WriteString('NOMPOSTE', 'POSTE' + Inttostr(i), poste);
                  ini.WriteString('NOMBASES', 'ITEM' + Inttostr(i), 'TEST');
               end;
            end;
         end;
         ini.free;
      end;
   end;

begin
   Screen.Cursor := crhourglass;
   try
      Path := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName));
      if creer then
      begin
         chem := ExcludeTrailingBackslash(ExtractFilePath(Labase));

         while Chem[Length(chem)] <> '\' do
            delete(chem, length(chem), 1);
         Chem := Chem + 'test\';
         ForceDirectories(chem);
         Lab_Etat.Caption := 'Cr�ation de la base de donn�es de TEST, patientez .....';
         Lab_Etat.visible := true;
         Update;
         CopyFile(Pchar(Labase), pchar(Chem + 'TEST.IB'), False);
         Lab_Etat.Caption := 'Modification de la base test';
         Update;
         if FileExists(Path + 'ginkoia.ini') then
         begin
            SS := Uppercase(Labase);
            while pos(':', SS) > 0 do
               delete(SS, 1, pos(':', SS));
            ini := tinifile.create(Path + 'ginkoia.ini');
            i := 0;
            while i < 10 do
            begin
               S := Uppercase(ini.ReadString('DATABASE', 'PATH' + Inttostr(i), ''));
               if pos(SS, S) > 0 then
                  BREAK;
               inc(i);
            end;
            if i < 10 then
            begin
               Mag := ini.ReadString('NOMMAGS', 'MAG' + Inttostr(i), '');
               data.databasename := Chem + 'TEST.IB';
               data.Open;
               Sql.sql.clear;
               Sql.sql.add('UPDATE GENMAGASIN SET MAG_NOM=''TEST'', MAG_IDENT=''TEST'', MAG_IDENTCOURT=''TEST'', MAG_ENSEIGNE=''TEST''  WHERE MAG_NOM=''' + MAG + '''');
               Sql.execsql;
               if tran.InTransaction then
                  tran.Commit;
               Data.close;
            end;
            ini.free;
         end;

         MajGenparambase(Chem);


         Lab_Etat.Caption := 'Modification de vos chemins';
         Update;
         changeChemin;
         Application.messageBox('Traitement termin�', ' Fin', Mb_OK);



      end
      else
      begin
         Lab_Etat.Caption := 'Modification de vos chemins';
         Lab_Etat.visible := true;
         Update;
         changeChemin;
         Application.messageBox('Traitement termin�', ' Fin', Mb_OK);
      end;
   finally
      Screen.Cursor := crDefault;
   end;
   Close;
end;

procedure TFrm_Crertest.MajGenparambase(basePath: string);
begin

  // mise � jour de l'info du genparambase du type de base, pour indiquer que c'est une base de test
  data.databasename := basePath + 'TEST.IB';
  data.Open;
  Sql.sql.clear;
  //on test si le genparamexiste d�j�
  Sql.sql.add('SELECT * FROM GENPARAMBASE WHERE PAR_NOM = ''BASETYPE''');
  Sql.open;

  if not (sql.Eof) then
  begin
    Sql.sql.clear;
    Sql.sql.add('UPDATE GENPARAMBASE SET PAR_FLOAT = 2, PAR_STRING = '''' WHERE PAR_NOM = ''BASETYPE''');
    Sql.execsql;
    if tran.InTransaction then
      tran.Commit;
  end
  else
  begin
    Sql.sql.clear;
    Sql.sql.add('INSERT INTO GENPARAMBASE (PAR_NOM, PAR_STRING, PAR_FLOAT) VALUES (''BASETYPE'','''',2);');
    Sql.execsql;
    if tran.InTransaction then
      tran.Commit;
  end;

  Data.close;

end;

end.

