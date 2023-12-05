--  @summary
--  Affiche un fait entier.
--  @description
--  Affiche un fait entier.
--  @group Fait Affichage
package Sys_Exp_P.Fait_P.Entier_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Fait_Entier_T);
   --  Affiche les parties spécifique d'un fait entier.
   --  @param Item
   --  Le fait entier.

   procedure Put_Line
      (Item : in     Fait_Entier_T);
   --  Affiche les parties spécifique d'un fait entier.
   --  Saute une ligne.
   --  @param Item
   --  Le fait entier.

end Sys_Exp_P.Fait_P.Entier_P.Text_IO;
