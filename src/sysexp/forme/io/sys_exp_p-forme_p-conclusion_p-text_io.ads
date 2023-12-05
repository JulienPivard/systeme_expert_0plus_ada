--  @summary
--  Affiche une forme conclusion.
--  @description
--  Affiche une forme conclusion.
--  @group Forme Affichage
package Sys_Exp_P.Forme_P.Conclusion_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Conclusion_Abstraite_T'Class);
   --  Affiche les parties commune d'une forme conclusion,
   --  et les parties spécifiques des classes enfant.
   --  @param Item
   --  Une forme conclusion.

private

end Sys_Exp_P.Forme_P.Conclusion_P.Text_IO;
