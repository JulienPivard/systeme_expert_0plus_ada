with Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_P;
with Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G;

--  @summary
--  Analyseur syntaxique concret.
--  @description
--  On utilise un parseur lexical de grammaire lorraine pour
--  générer les jetons qui seront analysé par le parseur
--  syntaxique.
--  @group Monteur Concret
package Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_P is new Syntaxique_G
   (Lexical_G_P => Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_P);
