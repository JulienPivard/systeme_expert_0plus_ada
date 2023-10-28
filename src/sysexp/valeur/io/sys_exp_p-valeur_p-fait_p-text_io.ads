--  @summary
--  Affiche une valeur fait.
--  @description
--  Affiche une valeur fait.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Fait_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Valeur_Fait_T);

   procedure Put_Line
      (Item : in     Valeur_Fait_T);

end Sys_Exp_P.Valeur_P.Fait_P.Text_IO;
