with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Operateur_P;

--  @summary
--  Affiche une valeur.
--  @description
--  Affiche une valeur.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   procedure Put
      (Item : in     Valeur_Abstraite_T'Class);

   procedure Put_Line
      (Item : in     Valeur_Abstraite_T'Class);

private

   procedure Afficher
      (Fait : in     Fait_P.Feuille_Fait_T);
   --  Affiche la valeur sur une ligne.
   --  @param Fait
   --  Le fait à afficher.

   procedure Afficher
      (Constante : in     Constante_P.Feuille_Constante_T);
   --  Affiche la valeur sur une ligne.
   --  @param Constante
   --  La constante à afficher.

   procedure Afficher
      (Operateur : in     Operateur_P.Operateur_Abstrait_T'Class);
   --  Affiche la l'opération sur une ligne.
   --  @param Operateur
   --  L'opération à afficher.

end Sys_Exp_P.Valeur_P.Text_IO;
