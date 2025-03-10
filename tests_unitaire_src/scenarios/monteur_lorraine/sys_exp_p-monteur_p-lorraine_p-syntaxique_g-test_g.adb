with Ada.Characters.Latin_1;

with AUnit.Assertions;

with Sys_Exp_P.Base_Faits_P.Extension_P;
with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;
with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G is

   pragma Spark_Mode (Off);

   Fin_Ligne : constant Character := Ada.Characters.Latin_1.LF;

   package Fab_R renames Visiteur_Forme_P.Declencheur_P.Fabrique_P;

   Base : aliased Base_Faits_P.Base_De_Faits_T;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      null;
   end Tear_Down;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;

      Syntaxique : Syntaxique_T := Creer
         (
            Nom_Fichier => "inutile",
            Fabrique    => F
         );

      Resultat : constant Resultat_Parseur_T := Syntaxique.Parser;
      pragma Unreferenced (Syntaxique);
      --  Le parseur syntaxique n'est plus utile.
   begin
      AUnit.Assertions.Assert
         (
            Condition => Resultat.Reussie,
            Message   => "Creation du parseur lexical"
         );
      Bloc_Tester_Regles :
      declare
         Regles : constant Base_De_Regles_T := Lire_Base_De_Regles
            (Resultat_Parseur => Resultat);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Regles.Possede_Successeur,
               Message   => "Creation base de regles"
            );
      end Bloc_Tester_Regles;
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Faits_Bool
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;
   begin
      Base_Faits_P.Extension_P.R_A_Z (Base => Base);
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "riche, grand, lourd, malhonnete, " &
               "parents_riches, pauvre, travailleur;" &
               Fin_Ligne
         );

      Bloc_Parser :
      declare
         Syntaxique : Syntaxique_T := Creer
            (
               Nom_Fichier => "inutile",
               Fabrique    => F
            );

         Resultat : constant Resultat_Parseur_T := Syntaxique.Parser;
         pragma Unreferenced (Syntaxique);
         --  Le parseur syntaxique n'est plus utile.
      begin
         AUnit.Assertions.Assert
            (
               Condition => not Resultat.Reussie,
               Message   => "Creation du parseur lexical"
            );
      end Bloc_Parser;
   end Test_Lire_Faits_Bool;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Faits_Bool_Symb
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;
   begin
      Base_Faits_P.Extension_P.R_A_Z (Base => Base);
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "riche, grand, lourd, malhonnete, " &
               "parents_riches, pauvre, travailleur;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_symboliques = profession;" &
               Fin_Ligne
         );

      Bloc_Parser :
      declare
         Syntaxique : Syntaxique_T := Creer
            (
               Nom_Fichier => "inutile",
               Fabrique    => F
            );

         Resultat : constant Resultat_Parseur_T := Syntaxique.Parser;
         pragma Unreferenced (Syntaxique);
         --  Le parseur syntaxique n'est plus utile.
      begin
         AUnit.Assertions.Assert
            (
               Condition => not Resultat.Reussie,
               Message   => "Creation du parseur lexical"
            );
      end Bloc_Parser;
   end Test_Lire_Faits_Bool_Symb;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Faits_Bool_Symb_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;
   begin
      Base_Faits_P.Extension_P.R_A_Z (Base => Base);
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "    riche, grand, lourd, malhonnete, " &
               "parents_riches, pauvre, travailleur;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_symboliques = profession;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_entiers = fortune, fortune_parents, poids, " &
               Fin_Ligne &
               "    taille, travail_par_jour, combien, palier_richesse;" &
               Fin_Ligne
         );

      Bloc_Parser :
      declare
         Syntaxique : Syntaxique_T := Creer
            (
               Nom_Fichier => "inutile",
               Fabrique    => F
            );

         Resultat : constant Resultat_Parseur_T := Syntaxique.Parser;
         pragma Unreferenced (Syntaxique);
         --  Le parseur syntaxique n'est plus utile.
      begin
         AUnit.Assertions.Assert
            (
               Condition => not Resultat.Reussie,
               Message   => "Creation du parseur lexical"
            );
      end Bloc_Parser;
   end Test_Lire_Faits_Bool_Symb_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Utiliser_Fait_Inconnu
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;
   begin
      Base_Faits_P.Extension_P.R_A_Z (Base => Base);
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "    riche, grand, lourd, malhonnete," &
               "parents_riches, pauvre, travailleur;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_symboliques = profession;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_entiers = fortune, fortune_parents, poids, " &
               Fin_Ligne &
               "    taille, travail_par_jour, combien, palier_richesse;" &
               Fin_Ligne &
               Fin_Ligne &
               "chercheur;" &
               Fin_Ligne
         );

      Bloc_Parser :
      declare
         Syntaxique : Syntaxique_T := Creer
            (
               Nom_Fichier => "inutile",
               Fabrique    => F
            );

         Resultat : constant Resultat_Parseur_T := Syntaxique.Parser;
         pragma Unreferenced (Syntaxique);
         --  Le parseur syntaxique n'est plus utile.

         Attendu : constant String :=
            "inutile:8:1 Erreur [le fait [chercheur] n'a pas été déclaré]";
      begin
         AUnit.Assertions.Assert
            (
               Condition => not Resultat.Reussie,
               Message   => "Creation du parseur lexical"
            );
         Bloc_Tests_Msg_Erreur :
         declare
            Msg_Lu : constant String := Lire_Message_Erreur
               (Resultat_Parseur => Resultat);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Msg_Lu = Attendu,
                  Message   => "Le message de retour " &
                     "[" & Msg_Lu & "] attendu [" & Attendu & "]"
               );
         end Bloc_Tests_Msg_Erreur;
      end Bloc_Parser;
   end Test_Utiliser_Fait_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Appliquer_1_Regle
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      F : constant Fab_R.Fabrique_T := Fab_R.Creer;
   begin
      Base_Faits_P.Extension_P.R_A_Z (Base => Base);
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "    riche, grand, lourd, malhonnete, chercheur," &
               "parents_riches, pauvre, travailleur;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_symboliques = profession;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_entiers = fortune, fortune_parents, poids, " &
               Fin_Ligne &
               "    taille, travail_par_jour, combien, palier_richesse;" &
               Fin_Ligne &
               Fin_Ligne &
               "chercheur;" &
               Fin_Ligne
         );

      Bloc_Parser :
      declare
         Syntaxique : Syntaxique_T := Creer
            (
               Nom_Fichier => "inutile",
               Fabrique    => F
            );

         Resultat : constant Resultat_Parseur_T := Syntaxique.Parser;
         pragma Unreferenced (Syntaxique);
         --  Le parseur syntaxique n'est plus utile.
      begin
         AUnit.Assertions.Assert
            (
               Condition => Resultat.Reussie,
               Message   => "Creation du parseur lexical"
            );

         Bloc_Extraire_Regles :
         declare
            Regles : Base_De_Regles_T := Lire_Base_De_Regles
               (Resultat_Parseur => Resultat);

            Continuer : Boolean;
         begin
            B_Tester :
            loop
               Continuer := Regles.Iterer (Base => Base'Access);
               exit B_Tester when not Continuer;
            end loop B_Tester;
            pragma Unreferenced (Regles);
            --  Une fois parcourue elles ne servent plus.

            AUnit.Assertions.Assert
               (
                  Condition => not Continuer,
                  Message   => "Parcours des regles generee"
               );
            Bloc_Verifier_NB :
            declare
               NB : constant Integer :=
                  Base_Faits_P.Extension_P.NB_Elements (B => Base);
            begin
               AUnit.Assertions.Assert
                  (
                     Condition => NB = 1,
                     Message   => "Taille de la base [" & NB'Image & "]"
                  );
            end Bloc_Verifier_NB;
         end Bloc_Extraire_Regles;
      end Bloc_Parser;
   end Test_Appliquer_1_Regle;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G;
