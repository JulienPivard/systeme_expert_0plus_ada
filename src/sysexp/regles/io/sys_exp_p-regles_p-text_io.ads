--  @summary
--  Formate l'affichage du contenu de la base de règles.
--  @description
--  Formate l'affichage du contenu de la base de règles.
--  @group Regle
package Sys_Exp_P.Regles_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (I : in     Regle_Interface_T'Class);
   --  Affiche les parties communes du contenu d'une règle.
   --  @param I
   --  La règle à afficher.

   procedure Put_Line
      (Item : in     Regle_Abstraite_T'Class);
   --  Affiche les parties communes du contenu d'une règle.
   --  @param Item
   --  La règle à afficher.

end Sys_Exp_P.Regles_P.Text_IO;
