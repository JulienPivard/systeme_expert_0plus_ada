with AUnit.Assertions;

package body Sys_Exp_P.Fait_P.Booleen_P.Test_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up (T : in out Test_Fixt_T) is
   begin
      null;
   end Set_Up;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down (T : in out Test_Fixt_T) is
   begin
      null;
   end Tear_Down;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer_Vrais
      (T : in out Test_Fixt_T)
   is
      Nom    : constant Nom_T   := "ceci est un test";
      Valeur : constant Boolean := True;
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
            Condition => T.Fait.Lire_Type = Booleen_E,
            Message   => "[" & T.Fait.Lire_Type'Image & "] " &
               "devrait valoir [" & Type_De_Fait_T'Image (Booleen_E) & "]"
         );
   end Test_Creer_Vrais;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer_Faux
      (T : in out Test_Fixt_T)
   is
      Nom    : constant Nom_T   := "ceci est un test";
      Valeur : constant Boolean := False;
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
            Condition => T.Fait.Lire_Type = Booleen_E,
            Message   => "[" & T.Fait.Lire_Type'Image & "] " &
               "devrait valoir [" & Type_De_Fait_T'Image (Booleen_E) & "]"
         );
   end Test_Creer_Faux;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Booleen_P.Test_P;
