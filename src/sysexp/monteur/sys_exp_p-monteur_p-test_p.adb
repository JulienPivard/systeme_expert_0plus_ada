with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Addition_P;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;

with Sys_Exp_P.Regles_P.Avec_Premisse_P;
with Sys_Exp_P.Regles_P.Sans_Premisse_P;

package body Sys_Exp_P.Monteur_P.Test_P
   with Spark_Mode => Off
is

   package Conclusion_R renames Sys_Exp_P.Forme_P.Conclusion_P;
   package Premisse_R   renames Sys_Exp_P.Forme_P.Premisse_P;
   package Valeur_R     renames Sys_Exp_P.Valeur_P;

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Jeu_De_Regles
      (This : in out Monteur_T)
   is
      Nom    : constant Sys_Exp_P.Nom_T    := "coucou";
      Valeur : constant Sys_Exp_P.Entier_T := 666;

      C : constant Valeur_R.Constante_P.Valeur_Constante_T :=
         Valeur_R.Constante_P.Creer (Valeur => 7);
      F : constant Valeur_R.Fait_P.Valeur_Fait_T :=
         Valeur_R.Fait_P.Creer      (Nom => Nom);

      Plus : constant Valeur_R.Operateur_P.Addition_P.Operateur_Plus_T :=
         Valeur_R.Operateur_P.Addition_P.Creer
            (
               Valeur_Gauche => F,
               Valeur_Droite => C
            );

      E : constant Valeur_R.Constante_P.Valeur_Constante_T :=
         Valeur_R.Constante_P.Creer (Valeur => Valeur);

      A : constant Conclusion_R.Expression_Entiere_P.Conclusion_Expression_T :=
         Conclusion_R.Expression_Entiere_P.Creer
            (
               Nom        => Nom,
               Expression => E
            );
      D : constant Conclusion_R.Bool_True_P.Conclusion_True_T :=
         Conclusion_R.Bool_True_P.Creer (Nom => "zioejcn");
      P : constant Premisse_R.Bool_True_P.Premisse_True_T :=
         Premisse_R.Bool_True_P.Creer   (Nom => "zioejcn");
      X : constant Conclusion_R.Expression_Entiere_P.Conclusion_Expression_T :=
         Conclusion_R.Expression_Entiere_P.Creer
            (
               Nom        => "toto",
               Expression => Plus
            );
      G : constant Conclusion_R.Bool_True_P.Conclusion_True_T :=
         Conclusion_R.Bool_True_P.Creer (Nom => "izeib");

      Regle_C : Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => 1,
               Conclusion => D
            );
      Regle_D : Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => 2,
               Conclusion => G
            );
      Regle_A : Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Avec_Premisse_P.Creer
            (
               ID_Regle   => 3,
               Conclusion => X,
               Premisse   => P
            );
      Regle_Q : constant Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => 4,
               Conclusion => A
            );
   begin
      Regle_A.Ajouter (Successeur => Regle_Q);
      Regle_D.Ajouter (Successeur => Regle_A);
      Regle_C.Ajouter (Successeur => Regle_D);

      This.Base_De_Regles :=
         Base_De_Regles_Holder_P.To_Holder (New_Item => Regle_C);
   end Construire_Jeu_De_Regles;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Lire_Resultat
      (This : in     Monteur_T)
      return Base_De_Regles_T
   is
   begin
      return This.Base_De_Regles.Element;
   end Lire_Resultat;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Test_P;
