--  @summary
--  Affiche une valeur.
--  @description
--  Affiche une valeur.
--  @group Valeur Affichage
package Sys_Exp_P.Valeur_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Valeur_Abstraite_T'Class);
   --  Affiche le contenu d'une valeur abstraite. On test
   --  le type réel de l'objet pour afficher les parties
   --  spécifique.
   --  @param Item
   --  La valeur abstraite.

   procedure Put_Line
      (Item : in     Valeur_Abstraite_T'Class);
   --  Affiche le contenu d'une valeur abstraite. On test
   --  le type réel de l'objet pour afficher les parties
   --  spécifique.
   --  On saute à la ligne à la fin.
   --  @param Item
   --  La valeur abstraite.

private

end Sys_Exp_P.Valeur_P.Text_IO;
