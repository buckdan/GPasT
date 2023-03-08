UNIT Ping_thread;

INTERFACE

USES
    idHTTP,
    StdCtrls, ScktComp,
    Windows,
    sysutils,
    Classes;

TYPE
    Tping = CLASS(TThread)
    PRIVATE
        FOnChange: TNotiFyEvent;
        PROCEDURE SetOnChange(CONST Value: TNotiFyEvent);
        { D�clarations priv�es }
    PROTECTED
        letemps: DWord;
        httpPing: TidHTTP;
        sResult: String;
        tsSource: TStrings;
        PROCEDURE Execute; OVERRIDE;
        PROCEDURE Change;
    PUBLIC
        LastOK: TDateTime;
        URL: STRING;
        CONSTRUCTOR Create(URL: STRING; Temps: DWord);
        PROPERTY OnChange: TNotiFyEvent READ FOnChange WRITE SetOnChange;
    END;

IMPLEMENTATION

{ Important : les m�thodes et les propri�t�s des objets dans la VCL ne peuvent
  �tre utilis�es que dans une m�thode appel�e en utilisant Synchronize, par exemple :

      Synchronize(UpdateCaption);

  o� UpdateCaption pourrait �tre du type :

    procedure Tping.UpdateCaption;
    begin
      Form1.Caption := 'Mis � jour dans un thread';
    end; }

{ Tping }

PROCEDURE Tping.Change;
BEGIN
    fonChange(Self);
END;

CONSTRUCTOR Tping.Create(URL: STRING; Temps: DWord);
BEGIN
    letemps := Temps;
    self.url := url;
    INHERITED Create(False);
END;

PROCEDURE Tping.Execute;
VAR
    LastAppel: DWord;
BEGIN
    { Placez le code du thread ici}
    LastAppel := GettickCount - LeTemps;
    FreeOnTerminate := true;
    tsSource := TStringList.Create;
    httpPing := TidHTTP.Create(NIL);
    TRY
      LastOK := Now;
      WHILE NOT Terminated DO
      BEGIN
          IF LastAppel < GettickCount THEN
          BEGIN
              LastAppel := GettickCount + Letemps;
              tsSource.Add('Caller=TOTO');
              tsSource.Add('Provider=TATA');
              sResult := httpPing.Post(Url, tsSource);
              IF Copy(sResult,1,4) = 'PONG' THEN
              BEGIN
                  LastOK := Now;
                  IF assigned(FOnChange) THEN
                      Synchronize(Change);
              END;
          END;
          Sleep(5000);
      END;
    FINALLY
      httpPing.free;
      tsSource.Free;
    end;
END;

PROCEDURE Tping.SetOnChange(CONST Value: TNotiFyEvent);
BEGIN
    FOnChange := Value;
END;

END.
