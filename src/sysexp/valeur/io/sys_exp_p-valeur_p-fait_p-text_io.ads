--  @summary
--  Affiche une valeur fait.
--  @description
--  Affiche une valeur fait.
--  @group Valeur Affichage
package Sys_Exp_P.Valeur_P.Fait_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Valeur_Fait_T);
   --  Affiche le contenu spécifique d'une valeur fait.
   --  @param Item
   --  La valeur fait.

   procedure Put_Line
      (Item : in     Valeur_Fait_T);
   --  Affiche le contenu spécifique d'une valeur fait.
   --  Saute à la ligne.
   --  @param Item
   --  La valeur fait.

end Sys_Exp_P.Valeur_P.Fait_P.Text_IO;
