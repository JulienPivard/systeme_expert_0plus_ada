--  @summary
--  Affiche une valeur constante.
--  @description
--  Affiche une valeur constante.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Constante_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Valeur_Constante_T);
   --  Affiche la partie spécifique de la valeur constante.
   --  @param Item
   --  La valeur constante.

   procedure Put_Line
      (Item : in     Valeur_Constante_T);
   --  Affiche la partie spécifique de la valeur constante.
   --  Saute à la ligne.
   --  @param Item
   --  La valeur constante.

end Sys_Exp_P.Valeur_P.Constante_P.Text_IO;
