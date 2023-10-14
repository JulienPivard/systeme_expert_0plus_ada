with AUnit.Assertions;

with Facilites_P;

package body Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P.Test_P
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
         Gauche : in     Nom_Symbole_T;
         Droite : in     Nom_Symbole_T
      )
      return Boolean
   is (Gauche = Droite);

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      Nom         : constant Nom_T         := Facilites_P.Creer_Nom;
      Nom_Symbole : constant Nom_Symbole_T := Facilites_P.Creer_Symbole;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egal'Access,
            Nom_Symbole => Nom_Symbole
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

end Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P.Test_P;
