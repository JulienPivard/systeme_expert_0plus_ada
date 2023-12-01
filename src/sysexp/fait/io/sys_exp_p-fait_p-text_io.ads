with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Symbolique_P;

--  @summary
--  Affiche un fait.
--  @description
--  Affiche un fait.
--  @group Fait
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

   procedure Afficher
      (Bool : in     Fait_P.Booleen_P.Fait_Booleen_T);
   --  Affiche le fait booléen.
   --  @param Bool
   --  Le fait booléen à afficher.

   procedure Afficher
      (Entier : in     Fait_P.Entier_P.Fait_Entier_T);
   --  Affiche le fait entier.
   --  @param Entier
   --  Le fait entier à afficher.

   procedure Afficher
      (Symbole : in     Fait_P.Symbolique_P.Fait_Symbolique_T);
   --  Affiche le fait symbolique.
   --  @param Symbole
   --  Le fait symbolique à afficher.

end Sys_Exp_P.Fait_P.Text_IO;
