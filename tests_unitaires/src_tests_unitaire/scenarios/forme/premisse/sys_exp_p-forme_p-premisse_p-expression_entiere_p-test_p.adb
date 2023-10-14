with AUnit.Assertions;

with Facilites_P;
with Facilites_P.Valeur_P;

package body Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P.Test_P
   with Spark_Mode => Off
is

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

   function Test_Egal
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche = Droite);

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egal'Access,
            Expression  => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Lire_Nom = Nom,
            Message   => "[" & String (T.Premisse.Lire_Nom) & "] " &
               "devrait valoir [" & String (Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P.Test_P;
