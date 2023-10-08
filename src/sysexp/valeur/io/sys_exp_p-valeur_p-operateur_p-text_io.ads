--  @summary
--  Affiche un opérateur.
--  @description
--  Affiche un opérateur.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Operateur_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Operateur_Abstrait_T'Class);

   procedure Put_Line
      (Item : in     Operateur_Abstrait_T'Class);

end Sys_Exp_P.Valeur_P.Operateur_P.Text_IO;
