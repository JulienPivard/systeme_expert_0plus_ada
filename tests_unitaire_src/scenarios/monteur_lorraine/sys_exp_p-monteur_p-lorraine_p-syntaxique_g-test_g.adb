with Ada.Characters.Latin_1;

with AUnit.Assertions;

with Sys_Exp_P.Base_Faits_P.Extension_P;
with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;
with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G is

   pragma Spark_Mode (Off);

   Fin_Ligne : constant Character := Ada.Characters.Latin_1.LF;

   package Fab_R renames Visiteur_Forme_P.Declencheur_P.Fabrique_P;

   Base : aliased Base_Faits_P.Base_De_Faits_T;

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
   procedure Test_Lire_1_Ligne
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;

      Continuer : Boolean;
   begin
      Base_Faits_P.Extension_P.R_A_Z (Base => Base);
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "riche, grand, lourd, malhonnete, " &
               "parents_riches, pauvre, travailleur;" &
               Fin_Ligne
         );

      Bloc_Parser :
      declare
         Syntaxique : Syntaxique_T := Creer
            (
               Nom_Fichier => "inutile",
               Fabrique    => F
            );

         Regles : Base_De_Regles_T := Syntaxique.Parser;
         pragma Unreferenced (Syntaxique);
         --  Le parseur syntaxique n'est plus utile.
      begin
         B_Tester :
         loop
            Continuer := Regles.Iterer (Base => Base'Access);
            exit B_Tester when not Continuer;
         end loop B_Tester;
         pragma Unreferenced (Regles);
         --  Une fois parcourue elles ne servent plus.

         AUnit.Assertions.Assert
            (
               Condition => not Continuer,
               Message   => "Creation du parseur lexical"
            );
         Bloc_Verifier_NB :
         declare
            NB : constant Integer :=
               Base_Faits_P.Extension_P.NB_Elements (B => Base);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => NB = 10,
                  Message   => "Taille de la base [" & NB'Image & "]"
               );
         end Bloc_Verifier_NB;
      end Bloc_Parser;
   exception
      when others =>
         AUnit.Assertions.Assert
            (
               Condition => True,
               Message   => "Creation du parseur lexical"
            );
   end Test_Lire_1_Ligne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G;
