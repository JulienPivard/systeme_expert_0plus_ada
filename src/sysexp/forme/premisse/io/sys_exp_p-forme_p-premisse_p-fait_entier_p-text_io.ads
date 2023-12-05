--  @summary
--  Affiche une forme prémisse.
--  @description
--  Affiche une forme prémisse.
--  @group Forme Premisse Affichage
package Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Premisse_T);
   --  Affiche les parties spécifiques d'une prémisse fait entier.
   --  @param Item
   --  Une forme prémisse.

end Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Text_IO;
