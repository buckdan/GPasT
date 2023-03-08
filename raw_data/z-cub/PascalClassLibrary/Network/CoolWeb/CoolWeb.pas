{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit CoolWeb;

interface

uses
  UHTTPServer, UHTTPServerCGI, UHTTPServerTCP, UHTTPServerTurboPower, 
  UTurboPowerForm, UHTTPSessionFile, UHTTPSessionMySQL, USqlDatabase, 
  UTCPServer, UPageList, UUser, UHtmlClasses, UMemoryStreamEx, UMIMEType, 
  UXmlClasses, UWebPage, UWebApp, LazIDEReg, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('UHTTPServerCGI', @UHTTPServerCGI.Register);
  RegisterUnit('UHTTPServerTCP', @UHTTPServerTCP.Register);
  RegisterUnit('UHTTPSessionFile', @UHTTPSessionFile.Register);
  RegisterUnit('UHTTPSessionMySQL', @UHTTPSessionMySQL.Register);
  RegisterUnit('USqlDatabase', @USqlDatabase.Register);
  RegisterUnit('UWebPage', @UWebPage.Register);
  RegisterUnit('UWebApp', @UWebApp.Register);
  RegisterUnit('LazIDEReg', @LazIDEReg.Register);
end;

initialization
  RegisterPackage('CoolWeb', @Register);
end.
