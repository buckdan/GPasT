unit uRepriseCCIllicadoUtils_RS;

interface

resourcestring

RS_RepriseAvecErreur = 'La reprise de la carte cadeau Illicado %s a renvoy� l''erreur %s : ' + #13#10 + '%s' + #13#10 + #13#10 + 'Veuillez contacter Ginkoia' + #13#10
+ 'Magasin : %s' + #13#10
+ 'Session : %s' + #13#10
+ 'Ticket : %s' + #13#10 + #13#10;

RS_RepriseEchec = 'La reprise de la carte cadeau Illicado %s n''a pas pu �tre faite dans le d�lai requis. ' + #13#10
+ 'Magasin : %s' + #13#10
+ 'Session : %s' + #13#10
+ 'Ticket : %s' + #13#10 + #13#10
+ 'Veuillez la traiter manuellement dans votre back office Illicado, puis dans Ginkoia, dans la liste des cartes cadeau, veuillez indiquer que le probl�me est "trait�". ' + #13#10
+ '(Si vous n''effectuez pas l''op�ration dans la liste des cartes cadeau de Ginkoia, un nouveau mail vous sera renvoy�)';

RS_RepriseKO = 'La reprise de la carte cadeau Illicado %s ne peut pas �tre faite car elle n''est pas li�e � un ticket. ' + #13#10
+ 'Veuillez la traiter manuellement dans votre back office Illicado, puis dans Ginkoia, dans la liste des cartes cadeau, veuillez indiquer que le probl�me est "trait�". ' + #13#10
+ '(Si vous n''effectuez pas l''op�ration dans la liste des cartes cadeau de Ginkoia, un nouveau mail vous sera renvoy�)';

RS_EmailSubject = 'Erreur Service de reprise des cartes cadeaux Illicado';

implementation

end.
