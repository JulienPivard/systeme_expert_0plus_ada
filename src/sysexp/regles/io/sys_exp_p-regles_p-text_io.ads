--  @summary
--  Formate l'affichage du contenu de la base de règles.
--  @description
--  Formate l'affichage du contenu de la base de règles.
--  @group Regle
package Sys_Exp_P.Regles_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Regle_Abstraite_T'Class);

end Sys_Exp_P.Regles_P.Text_IO;
