with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Lexical_P;
with Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G;

--  @summary
--  Instance concrète du parseur syntaxique.
--  @description
--  Ce parseur syntaxique acquiert son contenu au travers d'un
--  fichier dont le nom est donné en entré.
--  @group Monteur Concret
package Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Syntaxique_P is new Syntaxique_G
   (Lexical_G_P => Faux_Lexical_P);
