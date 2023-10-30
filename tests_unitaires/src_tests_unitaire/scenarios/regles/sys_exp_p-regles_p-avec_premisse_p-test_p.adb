with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;

with Facilites_P;

package body Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P
   with Spark_Mode => Off
is

   package ID_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => ID_Regle_T);

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
      use type Ada.Containers.Count_Type;

      ID  : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);
      Nom : constant Nom_T      := Facilites_P.Creer_Nom;

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom);
      P : constant Premisse_R.Bool_False_P.Premisse_False_T :=
         Premisse_R.Bool_False_P.Creer (Nom => Nom);
   begin
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Conclusion.Is_Empty,
            Message   => "La conclusion doit être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Regle_Declenchee,
            Message   => "Aucune regle ne doit avoir été déclenchée"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => "La regle ne doit avoir aucun successeur"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Is_Empty,
            Message   => "Les premisses doivent être vide"
         );
      T.Regle := Creer (ID_Regle => ID, Conclusion => C, Premisse => P);
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.ID_Regle = ID,
            Message   => "L'ID doit etre [" & ID'Image & "] et pas " &
               "[" & T.Regle.ID_Regle'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Conclusion.Is_Empty,
            Message   => "La conclusion ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Regle_Declenchee,
            Message   => "Aucune regle ne doit avoir été déclenchée"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => "La regle ne doit avoir aucun successeur"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 1,
            Message   => "Les premisses doivent en contenir au " &
               "moins une et pas " &
               "[" & T.Regle.Premisses.Length'Image & "] "
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Conclusion.Element.Lire_Nom = Nom,
            Message   => "Le nom de la conclusion doit etre " &
               "[" & String (Nom) & "] et pas " &
               "[" & String (T.Regle.Conclusion.Element.Lire_Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   ID_Alea_P.Reset (Gen => Generateur_ID);

end Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P;
