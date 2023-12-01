with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;

with Facilites_P;

package body Sys_Exp_P.Regles_P.Sans_Premisse_P.Test_P
   with Spark_Mode => Off
is

   Base : aliased Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   package Declencheur_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;

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
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID  : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);
      Nom : constant Nom_T      := Facilites_P.Creer_Nom;

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom);
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
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Fabrique   => Fabrique
         );
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
            Condition => T.Regle.Conclusion.Element.Lire_Nom = Nom,
            Message   => "Le nom de la conclusion doit etre " &
               "[" & String (Nom) & "] et pas " &
               "[" & String (T.Regle.Conclusion.Element.Lire_Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_Successeur
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Fabrique   => Fabrique
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => "La regle ne doit avoir aucun successeur"
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Successeur.Is_Empty,
            Message   => "La regle doit avoir un successeur"
         );
   end Test_Ajouter_Successeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Possede_Successeur
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Fabrique   => Fabrique
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Possede_Successeur,
            Message   => "La regle ne doit avoir aucun successeur"
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => "La regle doit avoir un successeur"
         );
   end Test_Possede_Successeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Iterer
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);

      Reussi : Boolean;
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Fabrique   => Fabrique
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         C_Bis : constant Conclusion_R.Bool_False_P.Conclusion_T :=
            Conclusion_R.Bool_False_P.Creer (Nom => Nom_2);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C_Bis,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => "La regle doit avoir un successeur"
         );

      Reussi := T.Regle.Iterer (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => Reussi,
            Message   => "Au moins une regle doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Est_Declenchee,
            Message   => "La regle doit avoir ete declenchee"
         );
   end Test_Iterer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Declenchee
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);

      Reussi : Boolean;
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Fabrique   => Fabrique
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         C_Bis : constant Conclusion_R.Bool_False_P.Conclusion_T :=
            Conclusion_R.Bool_False_P.Creer (Nom => Nom_2);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C_Bis,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => "La regle doit avoir un successeur"
         );

      Reussi := T.Regle.Iterer (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => Reussi,
            Message   => "Au moins une regle doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Est_Declenchee,
            Message   => "La regle doit avoir ete declenchee"
         );
   end Test_Est_Declenchee;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   ID_Alea_P.Reset (Gen => Generateur_ID);

end Sys_Exp_P.Regles_P.Sans_Premisse_P.Test_P;
