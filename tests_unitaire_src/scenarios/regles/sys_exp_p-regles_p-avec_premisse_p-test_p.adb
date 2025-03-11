with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Sys_Exp_P.Fait_P.Booleen_P;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;

with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;

with Sys_Exp_P.Base_Faits_P;

with Encode;
with Facilites_P;

package body Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P
   with Spark_Mode => Off
is

   package Declencheur_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;

   package ID_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => ID_Regle_T);

   Generateur_ID : ID_Alea_P.Generator;

   Base : aliased Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      Base.Vider;
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
      use type Ada.Containers.Count_Type;

      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID  : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);
      Nom : constant Nom_T      := Facilites_P.Creer_Nom;

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom);
      P : constant Premisse_R.Bool_False_P.Premisse_T     :=
         Premisse_R.Bool_False_P.Creer   (Nom => Nom);
   begin
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Conclusion.Is_Empty,
            Message   => "La conclusion doit être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Regle_Declenchee,
            Message   => Encode
               (Item => "Aucune règle ne doit avoir été déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => Encode
               (Item => "La règle ne doit avoir aucun successeur")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Is_Empty,
            Message   => Encode (Item => "Les prémisses doivent être vide")
         );
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.ID_Regle = ID,
            Message   => Encode
               (
                  Item => "L'ID doit être [" & ID'Image & "] et pas " &
                     "[" & T.Regle.ID_Regle'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Conclusion.Is_Empty,
            Message   => "La conclusion ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Regle_Declenchee,
            Message   => Encode
               (Item => "Aucune règle ne doit avoir été déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => Encode
               (Item => "La règle ne doit avoir aucun successeur")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 1,
            Message   => Encode
               (
                  Item => "Les prémisses doivent en contenir au " &
                     "moins une et pas " &
                     "[" & T.Regle.Premisses.Length'Image & "] "
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Conclusion.Element.Lire_Nom = Nom,
            Message   => Encode
               (
                  Item => "Le nom de la conclusion doit être " &
                     "[" & String (Nom) & "] et pas " &
                     "[" & String (T.Regle.Conclusion.Element.Lire_Nom) & "]"
               )
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_Successeur
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_T      :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => Encode
               (Item => "La règle ne doit avoir aucun successeur")
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C,
               Premisse   => P,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Successeur.Is_Empty,
            Message   => Encode
               (Item => "La règle doit avoir un successeur")
         );
   end Test_Ajouter_Successeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Possede_Successeur
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_T      :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Possede_Successeur,
            Message   => Encode
               (Item => "La règle ne doit avoir aucun successeur")
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C,
               Premisse   => P,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => Encode
               (Item => "La règle doit avoir un successeur")
         );
   end Test_Possede_Successeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Iterer
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);
      Nom_3 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_T      :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_3);

      F_V : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => Nom_2,
               Valeur => True
            );

      Reussi : Boolean;
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         C_Bis : constant Conclusion_R.Bool_False_P.Conclusion_T :=
            Conclusion_R.Bool_False_P.Creer (Nom => Nom_3);
         P_Bis : constant Premisse_R.Bool_True_P.Premisse_T      :=
            Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C_Bis,
               Premisse   => P_Bis,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => Encode
               (Item => "La règle doit avoir un successeur")
         );

      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => not Reussi,
            Message   => Encode
               (Item => "Aucune règle ne doit avoir été déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Est_Declenchee,
            Message   => Encode
               (Item => "La règle ne doit pas avoir été déclenchée")
         );
      Base.Ajouter (Nouvel_Item => F_V);
      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => Reussi,
            Message   => Encode
               (Item => "Au moins une règle doit avoir été déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Est_Declenchee,
            Message   => Encode
               (Item => "La règle ne doit pas avoir été déclenchée")
         );
   end Test_Iterer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Declenchee
      (T : in out Test_Fixt_T)
   is
      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);
      Nom_3 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_T      :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);

      F_V : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => Nom_2,
               Valeur => True
            );

      Reussi : Boolean;
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         C_Bis : constant Conclusion_R.Bool_False_P.Conclusion_T :=
            Conclusion_R.Bool_False_P.Creer (Nom => Nom_3);
         P_Bis : constant Premisse_R.Bool_True_P.Premisse_T      :=
            Premisse_R.Bool_True_P.Creer    (Nom => Nom_3);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C_Bis,
               Premisse   => P_Bis,
               Fabrique   => Fabrique
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => Encode
               (Item => "La règle doit avoir un successeur")
         );

      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => not Reussi,
            Message   => Encode
               (Item => "Aucune règle ne doit avoir été déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Est_Declenchee,
            Message   => Encode
               (Item => "La règle ne doit pas avoir été déclenchée")
         );
      Base.Ajouter (Nouvel_Item => F_V);
      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => Reussi,
            Message   => Encode
               (Item => "Au moins une règle doit avoir été déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Est_Declenchee,
            Message   => Encode
               (Item => "La règle doit avoir été déclenchée")
         );
   end Test_Est_Declenchee;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_Premisse
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      subtype NB_Item_T is Ada.Containers.Count_Type;

      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_T      :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 1,
            Message   => Encode
               (
                  Item => "Les prémisses doivent en contenir au " &
                     "moins une et pas " &
                     "[" & T.Regle.Premisses.Length'Image & "]"
               )
         );
      Boucle_Verifier_Ajout :
      for I in 2 .. 11 loop
         Bloc_Ajouter_Premisse :
         declare
            Nom_3 : constant Nom_T :=
               Facilites_P.Creer_Nom_Different (Nom => Nom_1);
            Q     : constant Premisse_R.Bool_False_P.Premisse_T :=
               Premisse_R.Bool_False_P.Creer   (Nom => Nom_3);
         begin
            T.Regle.Ajouter (Premisse => Q);
         end Bloc_Ajouter_Premisse;

         AUnit.Assertions.Assert
            (
               Condition => T.Regle.Premisses.Length = NB_Item_T (I),
               Message   => Encode
                  (
                     Item => "Les prémisses doivent en contenir au " &
                        "moins [" & I'Image & "] et pas " &
                        "[" & T.Regle.Premisses.Length'Image & "]"
                  )
            );
      end loop Boucle_Verifier_Ajout;
   end Test_Ajouter_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Verifier_Premisse
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      Fabrique : constant Declencheur_R.Fabrique_P.Fabrique_T :=
         Declencheur_R.Fabrique_P.Creer;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);
      Nom_3 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_2);

      C : constant Conclusion_R.Bool_False_P.Conclusion_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_T      :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
      Q : constant Premisse_R.Bool_False_P.Premisse_T     :=
         Premisse_R.Bool_False_P.Creer   (Nom => Nom_3);

      F_V : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => Nom_2,
               Valeur => True
            );
      F_F : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => Nom_3,
               Valeur => False
            );

      Premisse_Verifiee : Boolean;
   begin
      Base.Ajouter (Nouvel_Item => F_V);
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P,
            Fabrique   => Fabrique
         );
      Premisse_Verifiee := T.Regle.Verifier_Premisse (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => Premisse_Verifiee,
            Message   => Encode
               (
                  Item => "La prémisse [" & String (Nom_2) & "] " &
                     "doit être vérifiée"
               )
         );

      T.Regle.Ajouter (Premisse => Q);

      Base.Ajouter (Nouvel_Item => F_F);
      Premisse_Verifiee := T.Regle.Verifier_Premisse (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 2,
            Message   => Encode
               (
                  Item => "Les prémisses doivent en contenir au " &
                     "moins deux et pas " &
                     "[" & T.Regle.Premisses.Length'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Premisse_Verifiee,
            Message   => Encode
               (
                  Item => "La prémisse [" & String (Nom_3) & "] " &
                     "doit être vérifiée"
               )
         );
   end Test_Verifier_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   ID_Alea_P.Reset (Gen => Generateur_ID);

end Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P;
