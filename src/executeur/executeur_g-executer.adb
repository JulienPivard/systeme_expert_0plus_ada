--  with GNAT.Source_Info;
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

with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;
with Sys_Exp_P.Visiteur_Forme_P.Text_IO;

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
   C : Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T;
   F : Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T;

   B : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   V : Sys_Exp_P.Entier_T;

   Div   : Sys_Exp_P.Valeur_P.Operateur_P.Division_P.Operateur_Div_T;
   Moins : Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P.Operateur_Moins_T;
   Mult  : Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P.Operateur_Mult_T;
   Plus  : Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Operateur_Plus_T;

   Visiteur : Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Visiteur_T;
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
      C : Conclusion_R.Bool_True_P.Conclusion_True_T :=
         Conclusion_R.Bool_True_P.Creer (Nom => "zioejcn");
      P : Premisse_R.Bool_True_P.Premisse_True_T :=
         Premisse_R.Bool_True_P.Creer (Nom => "zioejcn");
      X : Conclusion_R.Expression_Entiere_P.Conclusion_Expression_T :=
         Conclusion_R.Expression_Entiere_P.Creer
            (
               Nom        => "zioejcn",
               Expression => Plus
            );
   begin
      Sys_Exp_P.Visiteur_Forme_P.Text_IO.Put_Line (Item => Visiteur);
      Ada.Text_IO.New_Line (Spacing => 2);

      C.Accepte (Visiteur => Visiteur);
      Sys_Exp_P.Visiteur_Forme_P.Text_IO.Put_Line (Item => Visiteur);
      Ada.Text_IO.New_Line (Spacing => 2);

      P.Accepte (Visiteur => Visiteur);
      Sys_Exp_P.Visiteur_Forme_P.Text_IO.Put_Line (Item => Visiteur);
      Ada.Text_IO.New_Line (Spacing => 2);

      X.Accepte (Visiteur => Visiteur);
      Sys_Exp_P.Visiteur_Forme_P.Text_IO.Put_Line (Item => Visiteur);
      Ada.Text_IO.New_Line (Spacing => 2);
   end Bloc_Visiter;
end Executer;
