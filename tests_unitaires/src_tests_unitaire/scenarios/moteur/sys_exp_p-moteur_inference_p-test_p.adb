with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Regles_P.Sans_Premisse_P;

with Facilites_P;

package body Sys_Exp_P.Moteur_Inference_P.Test_P
   with Spark_Mode => Off
is

   package Conclusion_R renames Sys_Exp_P.Forme_P.Conclusion_P;

   package ID_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sys_Exp_P.Regles_P.ID_Regle_T);

   Generateur_ID : ID_Alea_P.Generator;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
   begin
      null;
   end Set_Up;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
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

      Nom : constant Nom_T                         := Facilites_P.Creer_Nom;
      ID  : constant Sys_Exp_P.Regles_P.ID_Regle_T :=
         ID_Alea_P.Random (Gen => Generateur_ID);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom);

      Regle : constant Sys_Exp_P.Regles_P.Sans_Premisse_P.Regle_T :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => ID,
               Conclusion => C
            );

      M : constant Moteur_Inference_T := Creer (Base_De_Regles => Regle);
   begin
      AUnit.Assertions.Assert
         (
            Condition => not M.Regles.Element.Est_Declenchee,
            Message   => "La regle ne doit pas avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => not M.Base.Contient (Nom_Fait => Nom),
            Message   => "La base ne doit pas contenir le nom " &
               "[" & String (Nom)  & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Analyser_Base_Regles
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Nom_T                         := Facilites_P.Creer_Nom;
      ID  : constant Sys_Exp_P.Regles_P.ID_Regle_T :=
         ID_Alea_P.Random (Gen => Generateur_ID);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom);

      Regle : constant Sys_Exp_P.Regles_P.Sans_Premisse_P.Regle_T :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => ID,
               Conclusion => C
            );

      M : Moteur_Inference_T := Creer (Base_De_Regles => Regle);
   begin
      M.Analyser_Base_Regles;
      AUnit.Assertions.Assert
         (
            Condition => M.Regles.Element.Est_Declenchee,
            Message   => "La regle doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => M.Base.Contient (Nom_Fait => Nom),
            Message   => "La base doit contenir le nom " &
               "[" & String (Nom)  & "]"
         );
   end Test_Analyser_Base_Regles;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   ID_Alea_P.Reset (Gen => Generateur_ID);

end Sys_Exp_P.Moteur_Inference_P.Test_P;
