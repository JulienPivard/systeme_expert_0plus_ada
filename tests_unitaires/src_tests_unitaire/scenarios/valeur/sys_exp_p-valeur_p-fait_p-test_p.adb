with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Facilites_P;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;

package body Sys_Exp_P.Valeur_P.Fait_P.Test_P
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
   procedure Fait_Inconnu;
   --  Doit déclencher une exception sur un fait introuvable.

   -------------------------
   procedure Fait_Inconnu is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Feuille : Feuille_Fait_T;

      B : Base_Faits_P.Base_De_Faits_T;
      V : Entier_T;
   begin
      Feuille := Creer (Nom => Nom);
      V       := Feuille.Interpreter (Base => B);
      pragma Unreferenced (V);
   exception
      when E_Fait_Inconnu =>
         raise;
      when others =>
         null;
   end Fait_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;
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
      Nom    : constant Nom_T    := Facilites_P.Creer_Nom;
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
   procedure Test_Interpreter_Inconnu
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert_Exception
         (
            Proc    => Fait_Inconnu'Access,
            Message => "La base de fait ne doit pas contenir le fait"
         );
   end Test_Interpreter_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Sys_Exp_P.Valeur_P.Fait_P.Test_P;
