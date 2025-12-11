--  @summary
--  Affiche un fait.
--  @description
--  Affiche un fait.
--  @group Fait Affichage
package Sys_Exp_P.Fait_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Fait_Abstrait_T'Class);
   --  Affiche les parties communes d'un fait,
   --  puis les parties spécifique du fait.
   --  @param Item
   --  Le fait.

   procedure Put_Line
      (Item : in     Fait_Abstrait_T'Class);
   --  Affiche les parties communes d'un fait,
   --  puis les parties spécifique du fait.
   --  Saute une ligne.
   --  @param Item
   --  Le fait.

private

end Sys_Exp_P.Fait_P.Text_IO;
