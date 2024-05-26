with AUnit.Assertions;

with Facilites_P;

package body Sys_Exp_P.Fait_P.Symbolique_P.Test_P
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
      Nom     : constant Nom_T         := Facilites_P.Creer_Nom;
      Symbole : constant Nom_Symbole_T := Facilites_P.Creer_Symbole;
   begin
      T.Fait := Creer
         (
            Nom    => Nom,
            Valeur => Symbole
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Fait.Lire_Nom = Nom,
            Message   => "[" & String (T.Fait.Lire_Nom) & "] " &
               "devrait valoir [" & String (Nom) & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Fait.Lire_Valeur = Symbole,
            Message   => "[" & String (T.Fait.Lire_Valeur) & "] " &
               "devrait valoir [" & String (Symbole) & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Fait.Lire_Type = Symbolique_E,
            Message   => "[" & T.Fait.Lire_Type'Image & "] " &
               "devrait valoir [" & Type_De_Fait_T'Image (Symbolique_E) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Symbolique_P.Test_P;
