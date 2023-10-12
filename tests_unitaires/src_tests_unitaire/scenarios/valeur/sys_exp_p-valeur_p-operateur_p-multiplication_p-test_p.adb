with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Facilites_P.Valeur_P;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;

package body Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P.Test_P
   with Spark_Mode => Off
is

   subtype Class_Valeur_T is Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

   subtype Entier_Limite_T is Entier_T range -100 .. 100;

   package Entier_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_Limite_T);

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
      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      V_1 : constant Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_1);
      V_2 : constant Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_2);

      V_3 : constant Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T :=
         Sys_Exp_P.Valeur_P.Constante_P.Creer
            (Valeur => Entier_Alea_P.Random (Gen => Generateur_Entier));
      V_4 : constant Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T :=
         Sys_Exp_P.Valeur_P.Constante_P.Creer
            (Valeur => Entier_Alea_P.Random (Gen => Generateur_Entier));
   begin
      T.Mult := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_2
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Mult := Creer
         (
            Valeur_Gauche => V_3,
            Valeur_Droite => V_4
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Mult := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_4
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Mult := Creer
         (
            Valeur_Gauche => V_3,
            Valeur_Droite => V_2
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Mult.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Fait
      (T : in out Test_Fixt_T)
   is
      Valeur_1 : Entier_T;
      Valeur_2 : Entier_T;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      Bloc_Creer_Valeur :
      declare
         F_1 : constant Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T :=
            Facilites_P.Valeur_P.Creer_Fait
               (
                  Base   => Base,
                  Valeur => Valeur_1
               );
         F_2 : constant Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T :=
            Facilites_P.Valeur_P.Creer_Fait
               (
                  Base   => Base,
                  Valeur => Valeur_2
               );

         Resultat : constant Entier_T := Valeur_1 * Valeur_2;
      begin
         T.Mult := Creer
            (
               Valeur_Gauche => F_1,
               Valeur_Droite => F_2
            );
         Valeur := T.Mult.Interpreter (Base => Base);
         AUnit.Assertions.Assert
            (
               Condition => Valeur = Resultat,
               Message   => "[" & Valeur'Image & "] " &
                  "devrait valoir [" & Resultat'Image & "]"
            );
      end Bloc_Creer_Valeur;
   end Test_Interpreter_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Constante
      (T : in out Test_Fixt_T)
   is
      Valeur_1 : Entier_T;
      Valeur_2 : Entier_T;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      Bloc_Creer_Valeur :
      declare
         C_1 : constant Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T :=
            Facilites_P.Valeur_P.Creer_Constante (Valeur => Valeur_1);
         C_2 : constant Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T :=
            Facilites_P.Valeur_P.Creer_Constante (Valeur => Valeur_2);

         Resultat : constant Entier_T := Valeur_1 * Valeur_2;
      begin
         T.Mult := Creer
            (
               Valeur_Gauche => C_1,
               Valeur_Droite => C_2
            );
         Valeur := T.Mult.Interpreter (Base => Base);
         AUnit.Assertions.Assert
            (
               Condition => Valeur = Resultat,
               Message   => "[" & Valeur'Image & "] " &
                  "devrait valoir [" & Resultat'Image & "]"
            );
      end Bloc_Creer_Valeur;
   end Test_Interpreter_Constante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Mix
      (T : in out Test_Fixt_T)
   is
      Valeur_1 : Entier_T;
      Valeur_2 : Entier_T;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      Bloc_Creer_Valeur :
      declare
         V_1 : constant Class_Valeur_T :=
            Facilites_P.Valeur_P.Creer_Fait_Ou_Constante
               (
                  Base   => Base,
                  Valeur => Valeur_1
               );
         V_2 : constant Class_Valeur_T :=
            Facilites_P.Valeur_P.Creer_Fait_Ou_Constante
               (
                  Base   => Base,
                  Valeur => Valeur_2
               );

         Resultat : constant Entier_T := Valeur_1 * Valeur_2;
      begin
         T.Mult := Creer
            (
               Valeur_Gauche => V_1,
               Valeur_Droite => V_2
            );
         Valeur := T.Mult.Interpreter (Base => Base);
         AUnit.Assertions.Assert
            (
               Condition => Valeur = Resultat,
               Message   => "[" & Valeur'Image & "] " &
                  "devrait valoir [" & Resultat'Image & "]"
            );
      end Bloc_Creer_Valeur;
   end Test_Interpreter_Mix;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Mix_Etendu
      (T : in out Test_Fixt_T)
   is
      Valeur_1 : Entier_T;
      Valeur_2 : Entier_T;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      Bloc_Creer_Valeur :
      declare
         V_1 : constant Class_Valeur_T := Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Base,
               Valeur => Valeur_1
            );
         V_2 : constant Class_Valeur_T := Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Base,
               Valeur => Valeur_2
            );

         Resultat : constant Entier_T := Valeur_1 * Valeur_2;
      begin
         T.Mult := Creer
            (
               Valeur_Gauche => V_1,
               Valeur_Droite => V_2
            );
         Valeur := T.Mult.Interpreter (Base => Base);
         AUnit.Assertions.Assert
            (
               Condition => Valeur = Resultat,
               Message   => "[" & Valeur'Image & "] " &
                  "devrait valoir [" & Resultat'Image & "]"
            );
      end Bloc_Creer_Valeur;
   end Test_Interpreter_Mix_Etendu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P.Test_P;
