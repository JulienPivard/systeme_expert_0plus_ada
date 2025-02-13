with Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G;
with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;

--  @summary
--  Instance concrète du parseur lexical.
--  @description
--  Ce parseur lexical acquiert son contenu au travers d'un
--  fichier dont le nom est donné en entré.
--  @group Monteur Concret
package Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Lexical_P is new Lexical_G
   (
      Numero_Ligne_G_T    => Faux_Fichier_P.Numero_Ligne_T,
      Contenu_G_T         => Faux_Fichier_P.Contenu_T,
      Ouvrir_G            => Faux_Fichier_P.Ouvrir,
      Lire_Ligne_G        => Faux_Fichier_P.Lire_Ligne,
      Lire_Numero_Ligne_G => Faux_Fichier_P.Lire_Numero_Ligne,
      Fin_Est_Atteinte_G  => Faux_Fichier_P.Fin_Est_Atteinte
   );
