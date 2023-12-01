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

   procedure Put
      (Item : in     Fait_Booleen_T);
   --  Affiche les parties spécifique d'un fait booléen.
   --  @param Item
   --  Le fait booléen.

   procedure Put_Line
      (Item : in     Fait_Booleen_T);
   --  Affiche les parties spécifique d'un fait booléen.
   --  Saute une ligne.
   --  @param Item
   --  Le fait booléen.

end Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
