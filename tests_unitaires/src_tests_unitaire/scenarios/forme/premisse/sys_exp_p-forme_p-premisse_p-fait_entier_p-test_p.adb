with AUnit.Assertions;

with Facilites_P;
--  with Facilites_P.Fait_P;

--  with Sys_Exp_P.Fait_P.Entier_P;

package body Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Test_P
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
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      --  Fait : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
      --     Facilites_P.Fait_P.Creer_Fait_Entier (Nom => Nom_Fait);
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egal'Access,
            Nom_Fait    => Nom_Fait
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

end Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Test_P;
