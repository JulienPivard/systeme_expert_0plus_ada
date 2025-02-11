with Sys_Exp_P.Monteur_P.Directeur_P;
with Sys_Exp_P.Monteur_P.Lorraine_P;

with Sys_Exp_P.Moteur_Inference_P.Text_IO;
with Sys_Exp_P.Moteur_Inference_P;

with Sys_Exp_P.Regles_P;

with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P.Fabrique_P;
with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;

separate (Executeur_G)
procedure Executer
   (
      Nom_Fichier : in     String;
      Mode_Debug  : in     Boolean
   )
is
   package Monteur_R     renames Sys_Exp_P.Monteur_P.Lorraine_P;
   package Declencheur_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;
   --  @private Package interne.

   M : constant Monteur_R.Monteur_T := Monteur_R.Creer
         (
            Nom_Fichier => Nom_Fichier,
            Fabrique    =>
               (
                  if Mode_Debug then
                     Declencheur_R.Debug_P.Fabrique_P.Creer
                  else
                     Declencheur_R.Fabrique_P.Creer
               )
         );

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
