--  with GNAT.Source_Info;
with Sys_Exp_P.Fait_P.Symbolique_P;
with Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;
with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Entier_P.Text_IO;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   Fait_S : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
      Sys_Exp_P.Fait_P.Symbolique_P.Creer
      (
         Nom    => "je suis symbolique",
         Valeur => "je suis la"
      );
   Fait_B : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
      Sys_Exp_P.Fait_P.Booleen_P.Creer
      (
         Nom    => "se suis booléen",
         Valeur => False
      );
   Fait_E : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
      Sys_Exp_P.Fait_P.Entier_P.Creer
      (
         Nom    => "je suis entier",
         Valeur => 586
      );
begin
   Sys_Exp_P.Fait_P.Symbolique_P.Text_IO.Put_Line (Item => Fait_S);
   Sys_Exp_P.Fait_P.Booleen_P.Text_IO.Put_Line (Item => Fait_B);
   Sys_Exp_P.Fait_P.Entier_P.Text_IO.Put_Line (Item => Fait_E);
end Executer;
