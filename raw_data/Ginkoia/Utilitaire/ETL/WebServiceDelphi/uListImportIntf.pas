{ Interface invocable IListImport }

unit uListImportIntf;

interface

uses Soap.InvokeRegistry, System.Types, Soap.XSBuiltIns;

type

  { Les interfaces invocables doivent d�river de IInvokable }
  IListImport = interface(IInvokable)
  ['{953269F3-795E-4F41-8A18-7DD7BA5AEAA9}']

    { Les m�thodes de l'interface invocable ne doivent pas utiliser la valeur par d�faut }
    { convention d'appel ; stdcall est recommand� }
     function importClient(ISR_CID: Integer; CID, marketing, civilite, nom, prenom, pays, adresse, codePostal, ville, email: string): Boolean; StdCall;
     function importListClient(p_ListeClient: string): Boolean; StdCall;
  end;

implementation

initialization
  { Les interfaces invocables doivent �tre enregistr�es }
  InvRegistry.RegisterInterface(TypeInfo(IListImport));

end.
