with AUnit.Assertions;

with Facilites_P;

package body Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P.Test_P
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
      Nom         : constant Nom_T         := Facilites_P.Creer_Nom;
      Nom_Symbole : constant Nom_Symbole_T := Facilites_P.Creer_Symbole;
   begin
      T.Conclusion := Creer
         (
            Nom         => Nom,
            Nom_Symbole => Nom_Symbole
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
   procedure Test_Lire_Nom_Symbole
      (T : in out Test_Fixt_T)
   is
      Nom         : constant Nom_T         := Facilites_P.Creer_Nom;
      Nom_Symbole : constant Nom_Symbole_T := Facilites_P.Creer_Symbole;
   begin
      T.Conclusion := Creer
         (
            Nom         => Nom,
            Nom_Symbole => Nom_Symbole
         );
      Bloc_Verification :
      declare
         N : constant Nom_Symbole_T := T.Conclusion.Lire_Nom_Symbole;
      begin
         AUnit.Assertions.Assert
            (
               Condition => N = Nom_Symbole,
               Message   => "[" & String (N) & "] " &
                  "devrait valoir [" & String (Nom_Symbole) & "]"
            );
      end Bloc_Verification;
   end Test_Lire_Nom_Symbole;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P.Test_P;
