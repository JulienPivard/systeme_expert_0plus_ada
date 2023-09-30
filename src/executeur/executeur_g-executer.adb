--  with GNAT.Source_Info;
with Sys_Exp_P.Fait_P.Symbolique_P;
with Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   Fait : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
      Sys_Exp_P.Fait_P.Symbolique_P.Creer
      (
         Nom    => "coucou",
         Valeur => "je suis la"
      );
begin
   Sys_Exp_P.Fait_P.Symbolique_P.Text_IO.Put_Line (Item => Fait);
end Executer;
