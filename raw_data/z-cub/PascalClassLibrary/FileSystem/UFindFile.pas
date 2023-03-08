{TFindFile

Article:
http://delphi.about.com/library/weekly/aa052300a.htm

Tired of using FindFirst, Next and Close?
Come see how to encapsulate all those functions
in a single "find-files-recursively" component.
It's easy to use, free and with code.


********************************************
Zarko Gajic
About.com Guide to Delphi Programming
http://delphi.about.com
email: delphi.guide@about.com
********************************************

}

unit UFindFile;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, FileCtrl;

type
  EDirNotFound = class(Exception);

  TFileAttrKind = (ffaReadOnly, ffaHidden, ffaSysFile, ffaVolumeID, ffaDirectory, ffaArchive, ffaAnyFile);
  TFileAttr = set of TFileAttrKind;

  TFindFile = class(TComponent)
  private
    s : TStringList;

    fSubFolder : boolean;
    fAttr: TFileAttr;
    fPath : string;
    fFileMask : string;

    procedure SetPath(Value: string);
    procedure FileSearch(const inPath : string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function SearchForFiles: TStringList;
  published
    property FileAttr: TFileAttr read fAttr write fAttr;
    property InSubFolders : boolean read fSubFolder write fSubFolder;
    property Path : string read fPath write SetPath;
    property FileMask : string read fFileMask write fFileMask ;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TFindFile]);
end;

constructor TFindFile.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Path := IncludeTrailingBackslash(GetCurrentDir); 
  FileMask := '*.*';
  FileAttr := [ffaAnyFile];
  s := TStringList.Create;
end;

destructor TFindFile.Destroy;
begin
  s.Free;
  inherited Destroy;
end;

procedure TFindFile.SetPath(Value: string);
begin
  if fPath <> Value then
  begin
    if Value <> '' then
      if DirectoryExists(UTF8Decode(Value)) then
        fPath := IncludeTrailingBackslash(Value)
        else raise EDirNotFound.Create('Adresář nenalezen');
  end;
end;

function TFindFile.SearchForFiles: TStringList;
begin
  s.Clear;
  try
    FileSearch(Path);
  finally
    Result := s;
  end;
end;

procedure TFindFile.FileSearch(const InPath : string);
var Rec  : TSearchRec;
    Attr : integer;
begin
  Attr := 0;
  if ffaReadOnly in FileAttr then Attr := Attr + faReadOnly;
  if ffaHidden in FileAttr then Attr := Attr + faHidden;
  if ffaSysFile in FileAttr then Attr := Attr + faSysFile;
  if ffaVolumeID in FileAttr then Attr := Attr + faVolumeID;
  if ffaDirectory in FileAttr then Attr := Attr + faDirectory;
  if ffaArchive in FileAttr then Attr := Attr + faArchive;
  if ffaAnyFile in FileAttr then Attr := Attr + faAnyFile;

  if SysUtils.FindFirst(UTF8Decode(inPath + FileMask), Attr, Rec) = 0 then
  try
    repeat
      s.Add(inPath + UTF8Encode(Rec.Name));
    until SysUtils.FindNext(Rec) <> 0;
  finally
    SysUtils.FindClose(Rec);
  end;

  If not InSubFolders then Exit;

  if SysUtils.FindFirst(UTF8Decode(inPath + '*.*'), faDirectory, Rec) = 0 then
  try
    repeat
      if ((Rec.Attr and faDirectory) > 0) and (Rec.Name <> '.')
      and (Rec.Name <> '..') then
        FileSearch(IncludeTrailingBackslash(inPath + UTF8Encode(Rec.Name)));
    until SysUtils.FindNext(Rec) <> 0;
  finally
    SysUtils.FindClose(Rec);
  end;
end; 

end.

