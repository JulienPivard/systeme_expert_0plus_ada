--  with GNAT.Source_Info;
with Sys_Exp_P.Base_Faits_P.Text_IO;

with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Division_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Addition_P;
with Sys_Exp_P.Valeur_P.Text_IO;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;

with Sys_Exp_P.Regles_P.Avec_Premisse_P;
with Sys_Exp_P.Regles_P.Sans_Premisse_P;
with Sys_Exp_P.Regles_P.Text_IO;

with Sys_Exp_P.Moteur_Inference_P;
with Sys_Exp_P.Moteur_Inference_P.Text_IO;

with Sys_Exp_P.Monteur_P.Directeur_P;
with Sys_Exp_P.Monteur_P.Test_P;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   package Conclusion_R renames Sys_Exp_P.Forme_P.Conclusion_P;
   package Premisse_R   renames Sys_Exp_P.Forme_P.Premisse_P;

   Nom    : constant Sys_Exp_P.Nom_T    := "coucou";
   Valeur : constant Sys_Exp_P.Entier_T := 666;

   Fait : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
      Sys_Exp_P.Fait_P.Entier_P.Creer
         (
            Nom    => Nom,
            Valeur => Valeur
         );
   C : Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T;
   F : Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T;

   B : aliased Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   V : Sys_Exp_P.Entier_T;

   Div   : Sys_Exp_P.Valeur_P.Operateur_P.Division_P.Operateur_Div_T;
   Moins : Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P.Operateur_Moins_T;
   Mult  : Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P.Operateur_Mult_T;
   Plus  : Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Operateur_Plus_T;
begin
   B.Ajouter (Nouvel_Item => Fait);

   C := Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => 7);
   Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => C);
   V := C.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");

   F := Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom);
   Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => F);
   V := F.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");
   Ada.Text_IO.New_Line (Spacing => 1);

   Div := Sys_Exp_P.Valeur_P.Operateur_P.Division_P.Creer
      (
         Valeur_Gauche => F,
         Valeur_Droite => C
      );
   Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => Div);
   V := Div.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");

   Moins := Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P.Creer
      (
         Valeur_Gauche => F,
         Valeur_Droite => C
      );
   Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => Moins);
   V := Moins.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");

   Mult := Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P.Creer
      (
         Valeur_Gauche => F,
         Valeur_Droite => C
      );
   Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => Mult);
   V := Mult.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");

   Plus := Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Creer
      (
         Valeur_Gauche => F,
         Valeur_Droite => C
      );
   Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => Plus);
   V := Plus.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");
   Ada.Text_IO.New_Line (Spacing => 2);

   Bloc_Visiter :
   declare
      C : constant Conclusion_R.Bool_True_P.Conclusion_True_T :=
         Conclusion_R.Bool_True_P.Creer (Nom => "zioejcn");
      P : constant Premisse_R.Bool_True_P.Premisse_True_T :=
         Premisse_R.Bool_True_P.Creer (Nom => "zioejcn");
      X : constant Conclusion_R.Expression_Entiere_P.Conclusion_Expression_T :=
         Conclusion_R.Expression_Entiere_P.Creer
            (
               Nom        => "toto",
               Expression => Plus
            );
      D : constant Conclusion_R.Bool_True_P.Conclusion_True_T :=
         Conclusion_R.Bool_True_P.Creer (Nom => "izeib");

      Regle_C : Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => 1,
               Conclusion => C
            );
      Regle_D : Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
            (
               ID_Regle   => 2,
               Conclusion => D
            );
      Regle_P : constant Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
         Sys_Exp_P.Regles_P.Avec_Premisse_P.Creer
            (
               ID_Regle   => 3,
               Conclusion => X,
               Premisse   => P
            );
      Bool : Boolean;
   begin
      Regle_D.Ajouter (Successeur => Regle_P);
      Regle_C.Ajouter (Successeur => Regle_D);

      Sys_Exp_P.Regles_P.Text_IO.Put_Line (Item => Regle_C);
      Bool := Regle_C.Iterer (Base => B'Unrestricted_Access);
      Sys_Exp_P.Base_Faits_P.Text_IO.Put_Line (Item => B);
      Ada.Text_IO.Put_Line (Item => "OK [" & Bool'Image & "]");
      Sys_Exp_P.Regles_P.Text_IO.Put_Line (Item => Regle_C);
      Ada.Text_IO.New_Line (Spacing => 2);
   end Bloc_Visiter;

   Bloc_Iterer_Moteur :
   declare
      M : Sys_Exp_P.Monteur_P.Test_P.Monteur_T;

      D : Sys_Exp_P.Monteur_P.Directeur_P.Directeur_T :=
         Sys_Exp_P.Monteur_P.Directeur_P.Creer (Monteur => M);
   begin
      D.Construire_Jeu_De_Regles;

      Bloc_Moteur :
      declare
         R : constant Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class := D.Livrer;

         Moteur : Sys_Exp_P.Moteur_Inference_P.Moteur_Inference_T :=
            Sys_Exp_P.Moteur_Inference_P.Creer (Base_De_Regles => R);
      begin
         Moteur.Analyser_Base_Regles;

         Sys_Exp_P.Moteur_Inference_P.Text_IO.Put_Line (Item => Moteur);
      end Bloc_Moteur;
   end Bloc_Iterer_Moteur;
end Executer;
