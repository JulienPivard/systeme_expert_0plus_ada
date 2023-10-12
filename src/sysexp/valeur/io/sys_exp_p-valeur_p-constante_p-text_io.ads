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
      (Item : in     Feuille_Constante_T);

   procedure Put_Line
      (Item : in     Feuille_Constante_T);

end Sys_Exp_P.Valeur_P.Constante_P.Text_IO;
