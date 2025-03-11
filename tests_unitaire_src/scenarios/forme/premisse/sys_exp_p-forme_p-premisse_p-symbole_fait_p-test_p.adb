with AUnit.Assertions;

with Encode;
with Facilites_P;

package body Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P.Test_P
   with Spark_Mode => Off
is

   --------------------------------------
   function Test_Egal
      (
         Gauche : in     Nom_Symbole_T;
         Droite : in     Nom_Symbole_T
      )
      return Boolean
   is (Gauche = Droite);
   --------------------------------------

   --------------------------------------
   function Test_Different
      (
         Gauche : in     Nom_Symbole_T;
         Droite : in     Nom_Symbole_T
      )
      return Boolean
   is (Gauche /= Droite);
   --------------------------------------

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
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);
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
   procedure Test_Lire_Nom_Fait
      (T : in out Test_Fixt_T)
   is
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egal'Access,
            Nom_Fait    => Nom_Fait
         );
      Bloc_Verification :
      declare
         N : constant Nom_T := T.Premisse.Lire_Nom_Fait;
      begin
         AUnit.Assertions.Assert
            (
               Condition => N = Nom_Fait,
               Message   => "[" & String (N) & "] " &
                  "devrait valoir [" & String (Nom_Fait) & "]"
            );
      end Bloc_Verification;
   end Test_Lire_Nom_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Egale
      (T : in out Test_Fixt_T)
   is
      Nom   : constant Nom_T         := Facilites_P.Creer_Nom;
      Nom_1 : constant Nom_Symbole_T := Facilites_P.Creer_Symbole;
      Nom_2 : constant Nom_Symbole_T :=
         Facilites_P.Creer_Symbole_Different (Nom => Nom_1);
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egal'Access,
            Nom_Fait    => Nom
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Nom_1,
                  Droite => Nom_1
               ),
            Message   => Encode
               (Item => "Le tests d'égalité devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Nom_1,
                  Droite => Nom_2
               ),
            Message   => Encode
               (Item => "Le tests d'égalité devrait être faux")
         );
   end Test_Comparaison_Egale;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Different
      (T : in out Test_Fixt_T)
   is
      Nom   : constant Nom_T         := Facilites_P.Creer_Nom;
      Nom_1 : constant Nom_Symbole_T := Facilites_P.Creer_Symbole;
      Nom_2 : constant Nom_Symbole_T :=
         Facilites_P.Creer_Symbole_Different (Nom => Nom_1);
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Different'Access,
            Nom_Fait    => Nom
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Nom_1,
                  Droite => Nom_2
               ),
            Message   => Encode
               (Item => "Le tests d'inégalité devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Nom_1,
                  Droite => Nom_1
               ),
            Message   => Encode
               (Item => "Le tests d'inégalité devrait être faux")
         );
   end Test_Comparaison_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P.Test_P;
