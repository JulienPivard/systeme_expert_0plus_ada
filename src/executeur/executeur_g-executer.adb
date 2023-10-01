--  with GNAT.Source_Info;
with Sys_Exp_P.Fait_P.Symbolique_P;
with Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;
with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Booleen_P.Text_IO;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   Fait_S : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
      Sys_Exp_P.Fait_P.Symbolique_P.Creer
      (
         Nom    => "coucou",
         Valeur => "je suis la"
      );
   Fait_B : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
      Sys_Exp_P.Fait_P.Booleen_P.Creer
      (
         Nom    => "coucou",
         Valeur => False
      );
begin
   Sys_Exp_P.Fait_P.Symbolique_P.Text_IO.Put_Line (Item => Fait_S);
   Sys_Exp_P.Fait_P.Booleen_P.Text_IO.Put_Line (Item => Fait_B);
end Executer;
