with AUnit.Assertions;

with Encode;
with Facilites_P;
with Facilites_P.Entier_P;

package body Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Test_P
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
   procedure Test_Lire_Valeur
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
   end Test_Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Egale
      (T : in out Test_Fixt_T)
   is
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      Val_1 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier;
      Val_2 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier_Different (Valeur => Val_1);
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egal'Access,
            Nom_Fait    => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le tests d'égalité devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_2
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
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      Val_1 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier;
      Val_2 : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier_Different (Valeur => Val_1);
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Different'Access,
            Nom_Fait    => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_2
               ),
            Message   => Encode
               (Item => "Le tests d'inégalité devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le tests d'inégalité devrait être faux")
         );
   end Test_Comparaison_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Inf
      (T : in out Test_Fixt_T)
   is
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Inf'Access,
            Nom_Fait    => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_2
               ),
            Message   => Encode
               (Item => "Le test inférieur devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test inférieur devrait être faux")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_2,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test inférieur devrait être faux")
         );
   end Test_Comparaison_Inf;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Inf_Egale
      (T : in out Test_Fixt_T)
   is
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Inf_Egale'Access,
            Nom_Fait    => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_2
               ),
            Message   => Encode
               (Item => "Le test inférieur égale devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test inférieur égale devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_2,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test inférieur égale devrait être faux")
         );
   end Test_Comparaison_Inf_Egale;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Sup
      (T : in out Test_Fixt_T)
   is
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Sup'Access,
            Nom_Fait    => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_2
               ),
            Message   => Encode
               (Item => "Le test supérieur devrait être faux")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test supérieur devrait être faux")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_2,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test supérieur devrait être vrais")
         );
   end Test_Comparaison_Sup;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Comparaison_Sup_Egale
      (T : in out Test_Fixt_T)
   is
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      Val_1 : constant Sys_Exp_P.Entier_T := -20;
      Val_2 : constant Sys_Exp_P.Entier_T := +20;
   begin
      T.Premisse := Creer
         (
            Nom         => Nom,
            Comparateur => Test_Sup_Egale'Access,
            Nom_Fait    => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_2
               ),
            Message   => Encode
               (Item => "Le test supérieur égale devrait être faux")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_1,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test supérieur égale devrait être vrais")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Premisse.Comparer
               (
                  Gauche => Val_2,
                  Droite => Val_1
               ),
            Message   => Encode
               (Item => "Le test supérieur égale devrait être vrais")
         );
   end Test_Comparaison_Sup_Egale;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Test_P;
