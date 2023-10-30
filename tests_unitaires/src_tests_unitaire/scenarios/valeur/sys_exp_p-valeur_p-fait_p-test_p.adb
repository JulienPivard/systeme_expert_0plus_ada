with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Facilites_P;
with Facilites_P.Fait_P;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;

package body Sys_Exp_P.Valeur_P.Fait_P.Test_P
   with Spark_Mode => Off
is

   package Sorte_Fait_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sys_Exp_P.Fait_P.Type_De_Fait_T);

   Generateur_Sorte_Fait : Sorte_Fait_Alea_P.Generator;

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

      Feuille : constant Valeur_Fait_T := Creer (Nom => Nom);

      B : Base_Faits_P.Base_De_Faits_T;
      V : Entier_T;
   begin
      V := Feuille.Interpreter (Base => B);
      pragma Unreferenced (V);
   exception
      when E_Fait_Inconnu =>
         raise;
      when others =>
         null;
   end Fait_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Fait_N_Est_Pas_Entier;
   --  Doit déclencher une exception sur un fait déjà présent.

   --------------------
   procedure Fait_N_Est_Pas_Entier is
      use type Sys_Exp_P.Fait_P.Type_De_Fait_T;

      Nom     : constant Nom_T         := Facilites_P.Creer_Nom;
      Feuille : constant Valeur_Fait_T := Creer (Nom => Nom);

      Base  : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Sorte : Sys_Exp_P.Fait_P.Type_De_Fait_T;

      V : Entier_T;
   begin
      Boucle_Sorte_Pas_Entier :
      loop
         Sorte := Sorte_Fait_Alea_P.Random (Gen => Generateur_Sorte_Fait);
         exit Boucle_Sorte_Pas_Entier when Sorte /= Sys_Exp_P.Fait_P.Entier_E;
      end loop Boucle_Sorte_Pas_Entier;

      Bloc_Creer_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Facilites_P.Fait_P.Creer_Fait
               (
                  Nom   => Nom,
                  Sorte => Sorte
               );
      begin
         Base.Ajouter (Nouvel_Item => Fait);
      end Bloc_Creer_Fait;

      V := Feuille.Interpreter (Base => Base);
      pragma Unreferenced (V);
   exception
      when E_Fait_Non_Entier =>
         raise;
      when others =>
         null;
   end Fait_N_Est_Pas_Entier;
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
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Fait : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier (Nom => Nom);

      Valeur : constant Entier_T := Fait.Lire_Valeur;

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
   procedure Test_Interpreter_Fait_Non_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      AUnit.Assertions.Assert_Exception
         (
            Proc    => Fait_N_Est_Pas_Entier'Access,
            Message => "La base de fait ne doit pas contenir le fait"
         );
   end Test_Interpreter_Fait_Non_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Sorte_Fait_Alea_P.Reset (Gen => Generateur_Sorte_Fait);

end Sys_Exp_P.Valeur_P.Fait_P.Test_P;
