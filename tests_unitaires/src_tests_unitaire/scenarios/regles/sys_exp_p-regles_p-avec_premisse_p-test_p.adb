with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Sys_Exp_P.Fait_P.Booleen_P;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Base_Faits_P.Extension_P;

with Facilites_P;

package body Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P
   with Spark_Mode => Off
is

   Base : aliased Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   package ID_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => ID_Regle_T);

   Generateur_ID : ID_Alea_P.Generator;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      Sys_Exp_P.Base_Faits_P.Extension_P.R_A_Z (Base => Base);
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

      ID  : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);
      Nom : constant Nom_T      := Facilites_P.Creer_Nom;

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom);
      P : constant Premisse_R.Bool_False_P.Premisse_False_T     :=
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
            Message   => "Aucune regle ne doit avoir été déclenchée"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => "La regle ne doit avoir aucun successeur"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Is_Empty,
            Message   => "Les premisses doivent être vide"
         );
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.ID_Regle = ID,
            Message   => "L'ID doit etre [" & ID'Image & "] et pas " &
               "[" & T.Regle.ID_Regle'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Conclusion.Is_Empty,
            Message   => "La conclusion ne doit pas être vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Regle_Declenchee,
            Message   => "Aucune regle ne doit avoir été déclenchée"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => "La regle ne doit avoir aucun successeur"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 1,
            Message   => "Les premisses doivent en contenir au " &
               "moins une et pas " &
               "[" & T.Regle.Premisses.Length'Image & "] "
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Conclusion.Element.Lire_Nom = Nom,
            Message   => "Le nom de la conclusion doit etre " &
               "[" & String (Nom) & "] et pas " &
               "[" & String (T.Regle.Conclusion.Element.Lire_Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_Successeur
      (T : in out Test_Fixt_T)
   is
      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Successeur.Is_Empty,
            Message   => "La regle ne doit avoir aucun successeur"
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C,
               Premisse   => P
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Successeur.Is_Empty,
            Message   => "La regle doit avoir un successeur"
         );
   end Test_Ajouter_Successeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Possede_Successeur
      (T : in out Test_Fixt_T)
   is
      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Possede_Successeur,
            Message   => "La regle ne doit avoir aucun successeur"
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C,
               Premisse   => P
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => "La regle doit avoir un successeur"
         );
   end Test_Possede_Successeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Iterer
      (T : in out Test_Fixt_T)
   is
      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);
      Nom_3 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
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
            Premisse   => P
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         C_Bis : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
            Conclusion_R.Bool_False_P.Creer (Nom => Nom_3);
         P_Bis : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
            Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C_Bis,
               Premisse   => P_Bis
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => "La regle doit avoir un successeur"
         );

      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => not Reussi,
            Message   => "Aucune regle ne doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Est_Declenchee,
            Message   => "La regle ne doit pas avoir ete declenchee"
         );
      Base.Ajouter (Nouvel_Item => F_V);
      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => Reussi,
            Message   => "Au moins une regle doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Est_Declenchee,
            Message   => "La regle ne doit pas avoir ete declenchee"
         );
   end Test_Iterer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Declenchee
      (T : in out Test_Fixt_T)
   is
      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);
      Nom_3 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
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
            Premisse   => P
         );

      Bloc_Autre_Regle :
      declare
         ID_Bis : constant ID_Regle_T :=
            ID_Alea_P.Random (Gen => Generateur_ID);

         C_Bis : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
            Conclusion_R.Bool_False_P.Creer (Nom => Nom_3);
         P_Bis : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
            Premisse_R.Bool_True_P.Creer    (Nom => Nom_3);

         R : constant Regle_T := Creer
            (
               ID_Regle   => ID_Bis,
               Conclusion => C_Bis,
               Premisse   => P_Bis
            );
      begin
         T.Regle.Ajouter (Successeur => R);
      end Bloc_Autre_Regle;

      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Possede_Successeur,
            Message   => "La regle doit avoir un successeur"
         );

      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => not Reussi,
            Message   => "Aucune regle ne doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Regle.Est_Declenchee,
            Message   => "La regle ne doit pas avoir ete declenchee"
         );
      Base.Ajouter (Nouvel_Item => F_V);
      Reussi := T.Regle.Iterer (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => Reussi,
            Message   => "Au moins une regle doit avoir ete declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Est_Declenchee,
            Message   => "La regle doit avoir ete declenchee"
         );
   end Test_Est_Declenchee;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_Premisse
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      subtype NB_Item_T is Ada.Containers.Count_Type;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
   begin
      T.Regle := Creer
         (
            ID_Regle   => ID,
            Conclusion => C,
            Premisse   => P
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 1,
            Message   => "Les premisses doivent en contenir au " &
               "moins une et pas " &
               "[" & T.Regle.Premisses.Length'Image & "] "
         );
      Boucle_Verifier_Ajout :
      for I in 2 .. 11 loop
         Bloc_Ajouter_Premisse :
         declare
            Nom_3 : constant Nom_T :=
               Facilites_P.Creer_Nom_Different (Nom => Nom_1);
            Q     : constant Premisse_R.Bool_False_P.Premisse_False_T :=
               Premisse_R.Bool_False_P.Creer   (Nom => Nom_3);
         begin
            T.Regle.Ajouter (Premisse => Q);
         end Bloc_Ajouter_Premisse;

         AUnit.Assertions.Assert
            (
               Condition => T.Regle.Premisses.Length = NB_Item_T (I),
               Message   => "Les premisses doivent en contenir au " &
                  "moins [" & I'Image & "] et pas " &
                  "[" & T.Regle.Premisses.Length'Image & "] "
            );
      end loop Boucle_Verifier_Ajout;
   end Test_Ajouter_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Verifier_Premisse
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      ID : constant ID_Regle_T := ID_Alea_P.Random (Gen => Generateur_ID);

      Nom_1 : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_2 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_1);
      Nom_3 : constant Nom_T := Facilites_P.Creer_Nom_Different (Nom => Nom_2);

      C : constant Conclusion_R.Bool_False_P.Conclusion_False_T :=
         Conclusion_R.Bool_False_P.Creer (Nom => Nom_1);
      P : constant Premisse_R.Bool_True_P.Premisse_True_T       :=
         Premisse_R.Bool_True_P.Creer    (Nom => Nom_2);
      Q : constant Premisse_R.Bool_False_P.Premisse_False_T     :=
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
            Premisse   => P
         );
      Premisse_Verifiee := T.Regle.Verifier_Premisse (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => Premisse_Verifiee,
            Message   => "La premisse [" & String (Nom_2) & "] " &
               "doit etre verifiee"
         );

      T.Regle.Ajouter (Premisse => Q);

      Base.Ajouter (Nouvel_Item => F_F);
      Premisse_Verifiee := T.Regle.Verifier_Premisse (Base => Base'Access);
      AUnit.Assertions.Assert
         (
            Condition => T.Regle.Premisses.Length = 2,
            Message   => "Les premisses doivent en contenir au " &
               "moins deux et pas " &
               "[" & T.Regle.Premisses.Length'Image & "] "
         );
      AUnit.Assertions.Assert
         (
            Condition => Premisse_Verifiee,
            Message   => "La premisse [" & String (Nom_3) & "] " &
               "doit etre verifiee"
         );
   end Test_Verifier_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   ID_Alea_P.Reset (Gen => Generateur_ID);

end Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P;
