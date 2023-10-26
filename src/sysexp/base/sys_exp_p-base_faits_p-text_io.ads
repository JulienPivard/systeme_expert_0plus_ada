--  @summary
--  Formate l'affichage du contenu de la base de faits.
--  @description
--  Formate l'affichage du contenu de la base de faits.
--  @group Base de faits
package Sys_Exp_P.Base_Faits_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Base_De_Faits_T);

   procedure Afficher
      (Item : in     Base_De_Faits_T);

end Sys_Exp_P.Base_Faits_P.Text_IO;
