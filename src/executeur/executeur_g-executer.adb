--  with GNAT.Source_Info;
with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
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
begin
   B.Ajouter (Nouvel_Item => Fait);

   C := Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => 7);
   V := C.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");

   F := Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom);
   V := F.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");
end Executer;
