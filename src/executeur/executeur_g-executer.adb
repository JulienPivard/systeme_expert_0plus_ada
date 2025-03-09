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
      Nom_Fichier : in     Sys_Exp_P.Nom_Fichier_T;
      Mode_Debug  : in     Boolean
   )
is
   package Monteur_R     renames Sys_Exp_P.Monteur_P;
   package Declencheur_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;
   --  @private Package interne.

   M : constant Monteur_R.Lorraine_P.Monteur_T := Monteur_R.Lorraine_P.Creer
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
      Resultat : constant Monteur_R.Resultat_Parseur_T := D.Livrer;
   begin
      if Resultat.Reussie then
         Bloc_Iterer_Sur_Les_Regles :
         declare
      R : constant Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
               Monteur_R.Lire_Base_De_Regles (Resultat_Parseur => Resultat);

      Moteur : Sys_Exp_P.Moteur_Inference_P.Moteur_Inference_T :=
         Sys_Exp_P.Moteur_Inference_P.Creer (Base_De_Regles => R);
   begin
      Moteur.Analyser_Base_Regles;

      Sys_Exp_P.Moteur_Inference_P.Text_IO.Put_Line (Item => Moteur);
         end Bloc_Iterer_Sur_Les_Regles;

      else
         Bloc_Afficher_Erreur :
         declare
            Message_Erreur : constant String := Monteur_R.Lire_Message_Erreur
               (Resultat_Parseur => Resultat);
         begin
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => "Erreur durant la lecture du fichier"
               );
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => Message_Erreur
               );
         end Bloc_Afficher_Erreur;
      end if;
   end Bloc_Iterer_Moteur;
end Executer;
