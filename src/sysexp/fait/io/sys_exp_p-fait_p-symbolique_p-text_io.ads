--  @summary
--  Affiche un fait symbolique.
--  @description
--  Affiche un fait symbolique.
--  @group Fait
package Sys_Exp_P.Fait_P.Symbolique_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Fait_Symbolique_T);

   procedure Put_Line
      (Item : in     Fait_Symbolique_T);

end Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;
