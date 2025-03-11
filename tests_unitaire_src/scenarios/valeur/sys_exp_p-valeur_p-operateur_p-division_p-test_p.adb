with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Encode;
with Facilites_P.Valeur_P;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;

package body Sys_Exp_P.Valeur_P.Operateur_P.Division_P.Test_P
   with Spark_Mode => Off
is

   subtype Class_Valeur_T is Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

   subtype Entier_Limite_T is Entier_T range -10 .. 10;

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

      V_1 : constant Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_1);
      V_2 : constant Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_2);

      V_3 : constant Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T :=
         Sys_Exp_P.Valeur_P.Constante_P.Creer
            (Valeur => Entier_Alea_P.Random (Gen => Generateur_Entier));
      V_4 : constant Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T :=
         Sys_Exp_P.Valeur_P.Constante_P.Creer
            (Valeur => Entier_Alea_P.Random (Gen => Generateur_Entier));
   begin
      T.Div := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_2
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Div := Creer
         (
            Valeur_Gauche => V_3,
            Valeur_Droite => V_4
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Div := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_4
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Div := Creer
         (
            Valeur_Gauche => V_3,
            Valeur_Droite => V_2
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Div.Droite.Is_Empty,
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
         F_1 : constant Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T :=
            Facilites_P.Valeur_P.Creer_Fait
               (
                  Base   => Base,
                  Valeur => Valeur_1
               );
         F_2 : constant Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T :=
            Facilites_P.Valeur_P.Creer_Fait
               (
                  Zero_Exclus => True,
                  Base        => Base,
                  Valeur      => Valeur_2
               );

         Resultat : constant Entier_T := Valeur_1 / Valeur_2;
      begin
         T.Div := Creer
            (
               Valeur_Gauche => F_1,
               Valeur_Droite => F_2
            );
         Valeur := T.Div.Interpreter (Base => Base);
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
         C_1 : constant Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T :=
            Facilites_P.Valeur_P.Creer_Constante (Valeur => Valeur_1);
         C_2 : constant Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T :=
            Facilites_P.Valeur_P.Creer_Constante
               (
                  Zero_Exclus => True,
                  Valeur      => Valeur_2
               );

         Resultat : constant Entier_T := Valeur_1 / Valeur_2;
      begin
         T.Div := Creer
            (
               Valeur_Gauche => C_1,
               Valeur_Droite => C_2
            );
         Valeur := T.Div.Interpreter (Base => Base);
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
                  Zero_Exclus => True,
                  Base        => Base,
                  Valeur      => Valeur_2
               );

         Resultat : constant Entier_T := Valeur_1 / Valeur_2;
      begin
         T.Div := Creer
            (
               Valeur_Gauche => V_1,
               Valeur_Droite => V_2
            );
         Valeur := T.Div.Interpreter (Base => Base);
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
         V_2 : constant Class_Valeur_T :=
            Facilites_P.Valeur_P.Creer_Fait_Ou_Constante
               (
                  Zero_Exclus => True,
                  Base        => Base,
                  Valeur      => Valeur_2
               );

         Resultat : constant Entier_T := Valeur_1 / Valeur_2;
      begin
         T.Div := Creer
            (
               Valeur_Gauche => V_1,
               Valeur_Droite => V_2
            );
         Valeur := T.Div.Interpreter (Base => Base);
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
   procedure Diviser_Par_Const_Zero;
   --  Doit lever une exception de division par zéro.

   procedure Diviser_Par_Const_Zero is
      Valeur_1 : Sys_Exp_P.Entier_T;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      V : Sys_Exp_P.Entier_T;
   begin
      Bloc_Lever_Exception :
      declare
         V_1 : constant Class_Valeur_T := Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Base,
               Valeur => Valeur_1
            );
         V_2 : constant Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T :=
            Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => 0);

         Div : constant Division_P.Operateur_Div_T := Division_P.Creer
            (
               Valeur_Gauche => V_1,
               Valeur_Droite => V_2
            );
      begin
         V := Div.Interpreter (Base => Base);
      end Bloc_Lever_Exception;
      pragma Unreferenced (V);
   exception
      when E_Division_Par_Zero =>
         raise;
      when others =>
         null;
   end Diviser_Par_Const_Zero;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Diviser_Par_Fait_Zero;
   --  Doit lever une exception de division par zéro.

   procedure Diviser_Par_Fait_Zero is
      Valeur_1 : Sys_Exp_P.Entier_T;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      V : Sys_Exp_P.Entier_T;
   begin
      Bloc_Lever_Exception :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
            Sys_Exp_P.Fait_P.Entier_P.Creer
               (
                  Nom    => Facilites_P.Creer_Nom,
                  Valeur => 0
               );

         V_1 : constant Class_Valeur_T := Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Base,
               Valeur => Valeur_1
            );
         V_2 : constant Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T :=
            Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Fait.Lire_Nom);

         Div : constant Division_P.Operateur_Div_T := Division_P.Creer
            (
               Valeur_Gauche => V_1,
               Valeur_Droite => V_2
            );
      begin
         Base.Ajouter (Nouvel_Item => Fait);
         V := Div.Interpreter (Base => Base);
      end Bloc_Lever_Exception;
      pragma Unreferenced (V);
   exception
      when E_Division_Par_Zero =>
         raise;
      when others =>
         null;
   end Diviser_Par_Fait_Zero;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Diviser_Par_Zero
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert_Exception
         (
            Proc    => Diviser_Par_Const_Zero'Access,
            Message => Encode
               (Item => "La division par zéro doit créer une exception")
         );
      AUnit.Assertions.Assert_Exception
         (
            Proc    => Diviser_Par_Fait_Zero'Access,
            Message => Encode
               (Item => "La division par zéro doit créer une exception")
         );
   end Test_Diviser_Par_Zero;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Sys_Exp_P.Valeur_P.Operateur_P.Division_P.Test_P;
