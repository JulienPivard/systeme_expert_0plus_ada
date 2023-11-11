with Sys_Exp_P.Moteur_Inference_P;
with Sys_Exp_P.Moteur_Inference_P.Text_IO;

with Sys_Exp_P.Regles_P;

with Sys_Exp_P.Monteur_P.Directeur_P;

with Sys_Exp_P.Monteur_P.Lorraine_P;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   Nom : constant String := "./lorraine.txt";
   M : constant Sys_Exp_P.Monteur_P.Lorraine_P.Monteur_T :=
      Sys_Exp_P.Monteur_P.Lorraine_P.Creer (Nom_Fichier => Nom);

   D : Sys_Exp_P.Monteur_P.Directeur_P.Directeur_T :=
      Sys_Exp_P.Monteur_P.Directeur_P.Creer (Monteur => M);
begin
   D.Construire_Jeu_De_Regles;

   Bloc_Iterer_Moteur :
   declare
      R : constant Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class := D.Livrer;

      Moteur : Sys_Exp_P.Moteur_Inference_P.Moteur_Inference_T :=
         Sys_Exp_P.Moteur_Inference_P.Creer (Base_De_Regles => R);
   begin
      Moteur.Analyser_Base_Regles;

      Sys_Exp_P.Moteur_Inference_P.Text_IO.Put_Line (Item => Moteur);
   end Bloc_Iterer_Moteur;
end Executer;
