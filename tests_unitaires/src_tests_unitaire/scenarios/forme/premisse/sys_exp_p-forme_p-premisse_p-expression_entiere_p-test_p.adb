with AUnit.Assertions;

with Facilites_P;
with Facilites_P.Entier_P;
with Facilites_P.Valeur_P;

package body Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P.Test_P
   with Spark_Mode => Off
is

   --------------------------------------
   function Test_Egal
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche = Droite);
   --------------------------------------

   --------------------------------------
   function Test_Different
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche /= Droite);
   --------------------------------------

   --------------------------------------
   function Test_Inf
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche < Droite);
   --------------------------------------

   --------------------------------------
   function Test_Sup
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche > Droite);
   --------------------------------------

   --------------------------------------
   function Test_Inf_Egale
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche <= Droite);
   --------------------------------------

   --------------------------------------
   function Test_Sup_Egale
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche >= Droite);
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
   procedure Test_Lire_Valeur
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;

      V : Sys_Exp_P.Entier_T;
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
      V := T.Premisse.Lire_Valeur (Base => Base);
      AUnit.Assertions.Assert
         (
            Condition => V = Valeur,
            Message   => "[" & V'Image & "] " &
               "devrait valoir [" & Valeur'Image & "]"
         );
   end Test_Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Egale
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Val_1 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier;
      Val_2 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier_Different (Valeur => Val_1);

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
            Condition =>
               T.Premisse.Comparer (Gauche => Val_1, Droite => Val_1),
            Message   => "Le tests d'egalite devrait etre vrais"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_1, Droite => Val_2),
            Message   => "Le tests d'egalite devrait etre vrais"
         );
   end Test_Comparaison_Egale;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Different
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Val_1 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier;
      Val_2 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier_Different (Valeur => Val_1);

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Different'Access,
            Expression  => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_1, Droite => Val_2),
            Message   => "Le tests d'inegalite devrait etre vrais"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_1, Droite => Val_1),
            Message   => "Le tests d'inegalite devrait etre faux"
         );
   end Test_Comparaison_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Inf
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Inf'Access,
            Expression  => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_1, Droite => Val_2),
            Message   => "Le test inferieur devrait etre vrais"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_1, Droite => Val_1),
            Message   => "Le test inferieur devrait etre faux"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_2, Droite => Val_1),
            Message   => "Le test inferieur devrait etre faux"
         );
   end Test_Comparaison_Inf;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Inf_Egale
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Inf_Egale'Access,
            Expression  => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_1, Droite => Val_2),
            Message   => "Le test inferieur devrait etre vrais"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_1, Droite => Val_1),
            Message   => "Le test inferieur devrait etre vrais"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_2, Droite => Val_1),
            Message   => "Le test inferieur devrait etre faux"
         );
   end Test_Comparaison_Inf_Egale;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Sup
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Sup'Access,
            Expression  => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_1, Droite => Val_2),
            Message   => "Le test superieur devrait etre faux"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_1, Droite => Val_1),
            Message   => "Le test superieur devrait etre faux"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_2, Droite => Val_1),
            Message   => "Le test superieur devrait etre vrais"
         );
   end Test_Comparaison_Sup;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Sup_Egale
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom;

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;

      Base   : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
      Valeur : Sys_Exp_P.Entier_T;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Sup_Egale'Access,
            Expression  => Facilites_P.Valeur_P.Creer_Valeur
               (
                  Base   => Base,
                  Valeur => Valeur
               )
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not T.Premisse.Comparer (Gauche => Val_1, Droite => Val_2),
            Message   => "Le test superieur devrait etre faux"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_1, Droite => Val_1),
            Message   => "Le test superieur devrait etre vrais"
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               T.Premisse.Comparer (Gauche => Val_2, Droite => Val_1),
            Message   => "Le test superieur devrait etre vrais"
         );
   end Test_Comparaison_Sup_Egale;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P.Test_P;
