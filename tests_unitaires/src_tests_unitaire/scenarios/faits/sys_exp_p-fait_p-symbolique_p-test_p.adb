with AUnit.Assertions;

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
      Nom     : constant Nom_T         := "ceci est un test";
      Symbole : constant Nom_Symbole_T := "ceci est un symbole";
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
            Condition => T.Fait.Lire_Type = Symbole_E,
            Message   => "[" & T.Fait.Lire_Type'Image & "] " &
               "devrait valoir [" & Type_De_Fait_T'Image (Symbole_E) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Symbolique_P.Test_P;
