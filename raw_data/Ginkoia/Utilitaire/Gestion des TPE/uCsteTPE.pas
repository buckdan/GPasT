unit uCsteTPE;

interface
    
const
  //Vitesse du port Com
  vBaudRate110=110;
  vBaudRate300=300;
  vBaudRate600=600;
  vBaudRate1200=1200;
  vBaudRate2400=2400;
  vBaudRate4800=4800;
  vBaudRate9600=9600;
  vBaudRate14400=14400;
  vBaudRate19200=19200;
  vBaudRate38400=38400;
  vBaudRate56000=56000;
  vBaudRate57600=57600;
  vBaudRate115200=115200;
  vBaudRate128000=128000;
  vBaudRate256000=256000;

  //bit de donn�es
  vBits5=5;
  vBits6=6;
  vBits7=7;
  vBits8=8;

  //parite
  vParitePaire=1;
  vPariteImpaire=2;
  vPariteAucune=3;
  vPariteMarque=4;
  vPariteEspace=5;

  //bit d'arr�t
  vArretOneStop=1;
  vArretOne5Stop=2;
  vArretTwoStop=3;

  A_STX : byte =$02;
  A_ETX : byte =$03;
  A_EOT : byte =$04;
  A_ENQ : byte =$05;
  A_ACK : byte =$06;
  A_NAK : byte =$15;
  
  NbARecevoir=28;

var
  bOkTrace:Boolean;
  iNumPort:integer;      // N� de port COM
  bautoDetect:Boolean;   // D�tection Automatique
  sSearchTPEName:string; // Chaine de Caract�re � rechercher pour l'autodetection souvent "SAGEM MONETEL"
  iVitesse:integer;      // Vitesse port COM
  iBits:integer;         // Bits de donn�es COM
  iParite:integer;       // Parit� Port COM
  iArret:integer;                // Bit d'arret port COM
  bWarningStartMessage:Boolean;  // Boolean message Attention mauvaise Config : 1 seule fois par lancement d'exe !!
  // Port d'�coute du TServerSocket
  PortEcouteSrv: integer;

  // delai au bout duquel un d�clanchement TimeOut se produit
  DelaiTimeOut:integer;

  // Numero du TPE  (de 1 � 99)
  NumTPE: integer;


implementation

end.
