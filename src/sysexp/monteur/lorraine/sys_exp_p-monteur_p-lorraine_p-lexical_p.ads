with Ada.Text_IO;

with Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G;
with Sys_Exp_P.Monteur_P.Lorraine_P.Fichier_P;

--  @summary
--  Instance concrète du parseur lexical.
--  @description
--  Ce parseur lexical acquiert son contenu au travers d'un
--  fichier dont le nom est donné en entré.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_P is new Lexical_G
   (
      Numero_Ligne_G_T    => Ada.Text_IO.Positive_Count,
      Contenu_G_T         => Ada.Text_IO.File_Type,
      Ouvrir_G            => Fichier_P.Ouvrir,
      Lire_Ligne_G        => Fichier_P.Lire_Ligne,
      Lire_Numero_Ligne_G => Ada.Text_IO.Line,
      Fin_Est_Atteinte_G  => Ada.Text_IO.End_Of_File
   );
