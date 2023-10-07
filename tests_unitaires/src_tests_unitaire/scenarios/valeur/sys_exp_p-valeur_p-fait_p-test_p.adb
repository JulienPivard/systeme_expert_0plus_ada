with AUnit.Assertions;

with Ada.Numerics.Discrete_Random;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;

package body Sys_Exp_P.Valeur_P.Fait_P.Test_P
   with Spark_Mode => Off
is

   subtype Taille_Min_Nom_T is Taille_Nom_T range
      Taille_Nom_T'First + 3 .. Taille_Nom_T'Last;

   subtype Lettre_T is Character range 'a' .. 'z';

   package Entier_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_T);
   package Lettre_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Lettre_T);

   package Taille_Nom_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Taille_Min_Nom_T);

   Generateur_Entier : Entier_Alea_P.Generator;
   Generateur_Lettre : Lettre_Alea_P.Generator;
   Generateur_Taille : Taille_Nom_Alea_P.Generator;

   function Creer_Nom
      return Nom_T;

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
      Nom : constant Nom_T := Creer_Nom;
   begin
      T.Feuille := Creer (Nom => Nom);
      AUnit.Assertions.Assert
         (
            Condition => T.Feuille.Nom.Element = Nom,
            Message   => "[" & String (T.Feuille.Nom.Element) & "] " &
               "devrait valoir [" & String (Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Interpreter
      (T : in out Test_Fixt_T)
   is
      Nom    : constant Nom_T := Creer_Nom;
      Valeur : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);

      Fait : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Sys_Exp_P.Fait_P.Entier_P.Creer
            (
               Nom    => Nom,
               Valeur => Valeur
            );

      B : Base_Faits_P.Base_De_Faits_T;
      V : Entier_T;
   begin
      B.Ajouter (Nouvel_Item => Fait);

      T.Feuille := Creer (Nom => Nom);
      V := T.Feuille.Interpreter (Base => B);
      AUnit.Assertions.Assert
         (
            Condition => V = Valeur,
            Message   => "[" & V'Image & "] " &
               "devrait valoir [" & Valeur'Image & "]"
         );
   end Test_Interpreter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Nom
      return Nom_T
   is
      Taille : constant Taille_Nom_T :=
         Taille_Nom_Alea_P.Random (Gen => Generateur_Taille);

      Debut : constant Taille_Nom_T := Taille_Nom_T'First;
      Fin   : constant Taille_Nom_T := Debut + Taille - 1;

      subtype Taille_T is Taille_Nom_T range Debut .. Fin;

      Nom : Nom_T (Taille_T);
   begin
      for I in Taille_T loop
         Nom (I) := Lettre_Alea_P.Random (Gen => Generateur_Lettre);
      end loop;

      return Nom;
   end Creer_Nom;
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Sys_Exp_P.Valeur_P.Fait_P.Test_P;
