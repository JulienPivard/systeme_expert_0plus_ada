--  @summary
--  Affiche une forme conclusion ou prémisse.
--  @description
--  Affiche une forme conclusion ou prémisse.
--  @group Forme
package Sys_Exp_P.Forme_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Forme_Abstraite_T'Class);

end Sys_Exp_P.Forme_P.Text_IO;
