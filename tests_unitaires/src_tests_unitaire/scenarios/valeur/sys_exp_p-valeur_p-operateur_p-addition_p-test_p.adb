with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Facilites_P.Fait_Entier_G;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;

package body Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Test_P
   with Spark_Mode => Off
is

   subtype Entier_Limite_T is Entier_T range -100 .. 100;

   package Fait_Entier_Alea_P is new Facilites_P.Fait_Entier_G
      (
         Min => Entier_Limite_T'First,
         Max => Entier_Limite_T'Last
      );

   type Const_Ou_Fait_T is (Constante_E, Fait_E);

   package Entier_Alea_P        is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_Limite_T);
   package Const_Ou_Fait_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Const_Ou_Fait_T);

   Generateur_Entier        : Entier_Alea_P.Generator;
   Generateur_Const_Ou_Fait : Const_Ou_Fait_Alea_P.Generator;

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
      T.Plus := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_2
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Plus := Creer
         (
            Valeur_Gauche => V_3,
            Valeur_Droite => V_4
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Plus := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_4
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
      T.Plus := Creer
         (
            Valeur_Gauche => V_3,
            Valeur_Droite => V_2
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Gauche.Is_Empty,
            Message   => "La valeur gauche ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Plus.Droite.Is_Empty,
            Message   => "La valeur Droite ne doit pas être vide"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Fait
      (T : in out Test_Fixt_T)
   is
      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      Fait_1 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Fait_Entier_Alea_P.Creer_Fait_Entier (Nom => Nom_1);
      Fait_2 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Fait_Entier_Alea_P.Creer_Fait_Entier_Different
            (
               Fait => Fait_1,
               Nom  => Nom_2
            );

      F_1 : constant Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_1);
      F_2 : constant Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_2);

      Resultat : constant Entier_T := Fait_1.Lire_Valeur + Fait_2.Lire_Valeur;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      Base.Ajouter (Nouvel_Item => Fait_1);
      Base.Ajouter (Nouvel_Item => Fait_2);
      T.Plus := Creer
         (
            Valeur_Gauche => F_1,
            Valeur_Droite => F_2
         );
      Valeur := T.Plus.Interpreter (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => Valeur = Resultat,
            Message   => "[" & Valeur'Image & "] " &
               "devrait valoir [" & Resultat'Image & "]"
         );
   end Test_Interpreter_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Constante
      (T : in out Test_Fixt_T)
   is
      Valeur_1 : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);
      Valeur_2 : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);

      C_1 : constant Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T :=
         Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => Valeur_1);
      C_2 : constant Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T :=
         Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => Valeur_2);

      Resultat : constant Entier_T := Valeur_1 + Valeur_2;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      T.Plus := Creer
         (
            Valeur_Gauche => C_1,
            Valeur_Droite => C_2
         );
      Valeur := T.Plus.Interpreter (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => Valeur = Resultat,
            Message   => "[" & Valeur'Image & "] " &
               "devrait valoir [" & Resultat'Image & "]"
         );
   end Test_Interpreter_Constante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter_Mix
      (T : in out Test_Fixt_T)
   is
      Choix_1 : constant Const_Ou_Fait_T :=
         Const_Ou_Fait_Alea_P.Random (Gen => Generateur_Const_Ou_Fait);
      Choix_2 : constant Const_Ou_Fait_T :=
         Const_Ou_Fait_Alea_P.Random (Gen => Generateur_Const_Ou_Fait);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom;

      Fait_1 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Fait_Entier_Alea_P.Creer_Fait_Entier (Nom => Nom_1);
      Fait_2 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Fait_Entier_Alea_P.Creer_Fait_Entier (Nom => Nom_2);

      Valeur_1 : constant Entier_T := Fait_1.Lire_Valeur;
      Valeur_2 : constant Entier_T := Fait_2.Lire_Valeur;

      V_1 : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         (
            case Choix_1 is
               when Constante_E =>
                  Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => Valeur_1),
               when Fait_E      =>
                  Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_1)
         );
      V_2 : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         (
            case Choix_2 is
               when Constante_E =>
                  Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => Valeur_2),
               when Fait_E      =>
                  Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom_2)
         );

      Resultat : constant Entier_T := Valeur_1 + Valeur_2;

      Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      Valeur : Entier_T;
   begin
      Base.Ajouter (Nouvel_Item => Fait_1);
      Base.Ajouter (Nouvel_Item => Fait_2);

      T.Plus := Creer
         (
            Valeur_Gauche => V_1,
            Valeur_Droite => V_2
         );
      Valeur := T.Plus.Interpreter (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => Valeur = Resultat,
            Message   => "[" & Valeur'Image & "] " &
               "devrait valoir [" & Resultat'Image & "]"
         );
   end Test_Interpreter_Mix;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset        (Gen => Generateur_Entier);
   Const_Ou_Fait_Alea_P.Reset (Gen => Generateur_Const_Ou_Fait);

end Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Test_P;
