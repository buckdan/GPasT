{ Interface invocable IJetonLaunch }

unit JetonLaunchIntf;

interface

uses
  InvokeRegistry,
  Types;

type
  { Les interfaces invocables doivent d�river de IInvokable }
  IJetonLaunch = interface(IInvokable)
    ['{59985D3A-5B59-48E2-AAEB-33E7B36A42FD}']
    { Les m�thodes de l'interface invocable ne doivent pas utiliser la valeur par d�faut }
    { convention d'appel ; stdcall est recommand� }
    function GetToken(const ANomClient, ASender: string): string; stdcall;
    function GetVersionBdd(const ANomClient: string): string; stdcall;
    procedure FreeToken(const ANomClient, ASender: string); stdcall;
  end;

implementation

initialization
  { Les interfaces invocables doivent �tre enregistr�es }
  InvRegistry.RegisterInterface(TypeInfo(IJetonLaunch));

end.

