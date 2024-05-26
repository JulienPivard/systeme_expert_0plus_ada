with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Facilites_P;

package body Sys_Exp_P.Fait_P.Entier_P.Test_P
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
      Nom    : constant Nom_T    := Facilites_P.Creer_Nom;
      Valeur : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);
   begin
      T.Fait := Creer
         (
            Nom    => Nom,
            Valeur => Valeur
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Fait.Lire_Nom = Nom,
            Message   => "[" & String (T.Fait.Lire_Nom) & "] " &
               "devrait valoir [" & String (Nom) & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Fait.Lire_Valeur = Valeur,
            Message   => "[" & T.Fait.Lire_Valeur'Image & "] " &
               "devrait valoir [" & Valeur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Fait.Lire_Type = Entier_E,
            Message   => "[" & T.Fait.Lire_Type'Image & "] " &
               "devrait valoir [" & Type_De_Fait_T'Image (Entier_E) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Sys_Exp_P.Fait_P.Entier_P.Test_P;
