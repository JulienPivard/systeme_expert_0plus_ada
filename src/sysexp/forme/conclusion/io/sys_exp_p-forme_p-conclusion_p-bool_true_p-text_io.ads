--  @summary
--  Affiche une forme conclusion.
--  @description
--  Affiche une forme conclusion.
--  @group Forme
package Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Conclusion_T);
   --  Affiche les parties spécifiques d'une conclusion booléenne vraie.
   --  @param Item
   --  Une forme conclusion.

end Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P.Text_IO;
