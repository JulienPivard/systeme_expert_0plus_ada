--  @summary
--  Affiche une forme conclusion.
--  @description
--  Affiche une forme conclusion.
--  @group Forme
package Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Conclusion_Fait_T);

end Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P.Text_IO;
