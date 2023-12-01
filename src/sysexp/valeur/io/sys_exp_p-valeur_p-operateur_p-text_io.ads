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
   --  Affiche les parties commune de l'opérateur, puis les parties
   --  spécifique des objets enfants.
   --  @param Item
   --  L'opérateur de valeur.

   procedure Put_Line
      (Item : in     Operateur_Abstrait_T'Class);
   --  Affiche les parties commune de l'opérateur, puis les parties
   --  spécifique des objets enfants.
   --  Saute à la ligne.
   --  @param Item
   --  L'opérateur de valeur.

end Sys_Exp_P.Valeur_P.Operateur_P.Text_IO;
