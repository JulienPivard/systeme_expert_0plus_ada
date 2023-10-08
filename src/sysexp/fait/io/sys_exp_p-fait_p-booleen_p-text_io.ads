--  @summary
--  Affiche un fait booléen.
--  @description
--  Affiche un fait booléen.
--  @group Fait
package Sys_Exp_P.Fait_P.Booleen_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Fait_Booleen_T);

end Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
