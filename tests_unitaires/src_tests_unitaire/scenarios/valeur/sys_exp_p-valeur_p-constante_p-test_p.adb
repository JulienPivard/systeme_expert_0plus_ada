with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Sys_Exp_P.Base_Faits_P;

package body Sys_Exp_P.Valeur_P.Constante_P.Test_P
   with Spark_Mode => Off
is

   package Entier_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_T);

   Generateur_Entier : Entier_Alea_P.Generator;

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
      Valeur : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);
   begin
      T.Feuille := Creer (Valeur => Valeur);
      AUnit.Assertions.Assert
         (
            Condition => T.Feuille.Valeur = Valeur,
            Message   => "[" & T.Feuille.Valeur'Image & "] " &
               "devrait valoir [" & Valeur'Image & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter
      (T : in out Test_Fixt_T)
   is
      Valeur : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);

      B : Base_Faits_P.Base_De_Faits_T;
      V : Entier_T;
   begin
      T.Feuille := Creer (Valeur => Valeur);
      V := T.Feuille.Interpreter (Base => B);
      AUnit.Assertions.Assert
         (
            Condition => V = Valeur,
            Message   => "[" & V'Image & "] " &
               "devrait valoir [" & Valeur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Feuille.Valeur = V,
            Message   => "[" & T.Feuille.Valeur'Image & "] " &
               "devrait valoir [" & V'Image & "]"
         );
   end Test_Interpreter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Sys_Exp_P.Valeur_P.Constante_P.Test_P;
