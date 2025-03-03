with AUnit.Assertions;

with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G is

   pragma Spark_Mode (Off);

   package Fab_R renames Visiteur_Forme_P.Declencheur_P.Fabrique_P;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      null;
   end Tear_Down;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;

      Syntaxique : Syntaxique_T := Creer
         (
            Nom_Fichier => "inutile",
            Fabrique    => F
         );

      Regles : constant Base_De_Regles_T := Syntaxique.Parser;
      pragma Unreferenced (Syntaxique);
      --  Le parseur syntaxique n'est plus utile.
   begin
      AUnit.Assertions.Assert
         (
            Condition => Regles.Possede_Successeur,
            Message   => "Creation du parseur lexical"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G;
