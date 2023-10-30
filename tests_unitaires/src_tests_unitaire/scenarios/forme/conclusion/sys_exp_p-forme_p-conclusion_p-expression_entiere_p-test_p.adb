with AUnit.Assertions;

with Facilites_P;
with Facilites_P.Valeur_P;

with Sys_Exp_P.Base_Faits_P;

package body Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P.Test_P
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

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Conclusion := Creer
         (
            Nom        => Nom,
            Expression => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Conclusion.Lire_Nom = Nom,
            Message   => "[" & String (T.Conclusion.Lire_Nom) & "] " &
               "devrait valoir [" & String (Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Valeur
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;

      V : Sys_Exp_P.Entier_T;
   begin
      T.Conclusion := Creer
         (
            Nom        => Nom,
            Expression => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      V := T.Conclusion.Lire_Valeur (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => V = Valeur,
            Message   => "[" & V'Image & "] " &
               "devrait valoir [" & Valeur'Image & "]"
         );
   end Test_Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P.Test_P;
