--  @summary
--  Affiche une forme prémisse.
--  @description
--  Affiche une forme prémisse.
--  @group Forme
package Sys_Exp_P.Forme_P.Premisse_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Premisse_Abstraite_T'Class);
   --  Affiche les parties commune d'une forme prémisse,
   --  et les parties spécifiques des classes enfant.
   --  @param Item
   --  Une forme prémisse.

private

end Sys_Exp_P.Forme_P.Premisse_P.Text_IO;
