--  @summary
--  Affiche un fait entier.
--  @description
--  Affiche un fait entier.
--  @group Fait
package Sys_Exp_P.Fait_P.Entier_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Fait_Entier_T);

end Sys_Exp_P.Fait_P.Entier_P.Text_IO;
