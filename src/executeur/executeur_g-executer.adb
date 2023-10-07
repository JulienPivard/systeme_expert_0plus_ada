--  with GNAT.Source_Info;
with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Base_Faits_P;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   F : Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T;

   B : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   V : Sys_Exp_P.Entier_T;
begin
   F := Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => 7);
   V := F.Interpreter (Base => B);
   Ada.Text_IO.Put_Line (Item => "La valeur est [" & V'Image & "]");
end Executer;
