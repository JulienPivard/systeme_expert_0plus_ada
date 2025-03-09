with Ada.Characters.Latin_1;

with Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G is

   subtype Minuscules_T is Character range 'a' .. 'z';
   subtype Majuscules_T is Character range 'A' .. 'Z';

   subtype Chiffre_T is Character
      with Static_Predicate => Chiffre_T in
         '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9';
   subtype Lettre_T  is Character
      with Static_Predicate => Lettre_T  in Minuscules_T | Majuscules_T;

   ---------------------------------------------------------------------------
   function Creer
      (Nom_Fichier : in     Nom_Fichier_T)
      return Lexical_T
   is
   begin
      return Lexical : Lexical_T do
         Ouvrir_G
            (
               Contenu => Lexical.Fichier,
               Nom     => Nom_Fichier
            );
      end return;
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Fermer
      (This : in out Lexical_T)
   is
   begin
      Fermer_G (Contenu => This.Fichier);
   end Fermer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Suivant
      (This : in out Lexical_T)
      return Jeton_T
   is
   begin
      if not This.Avancer then
         return Jeton_P.Fabrique_P.Faire_Fin_Fichier;
      end if;

      This.Ancienne_Position := This.Position;

      Bloc_Jeton :
      declare
         Lettre : constant Character :=
            This.Ligne_En_Cours.Chaine (This.Position);
      begin
         This.Position := This.Position + 1;
         case Lettre is
            when '(' =>
               return Jeton_P.Fabrique_P.Faire_Parenthese_Ouvrante;

            when ')' =>
               return Jeton_P.Fabrique_P.Faire_Parenthese_Fermante;

            when '<' =>
               if This.Ligne_En_Cours.Chaine (This.Position) = '=' then
                  This.Position := This.Position + 1;
                  return Jeton_P.Fabrique_P.Faire_Inferieur_Egal;
               else
                  return Jeton_P.Fabrique_P.Faire_Inferieur;
               end if;

            when '>' =>
               if This.Ligne_En_Cours.Chaine (This.Position) = '=' then
                  This.Position := This.Position + 1;
                  return Jeton_P.Fabrique_P.Faire_Superieur_Egal;
               else
                  return Jeton_P.Fabrique_P.Faire_Superieur;
               end if;

            when '+' =>
               return Jeton_P.Fabrique_P.Faire_Operateur_Plus;

            when '-' =>
               return Jeton_P.Fabrique_P.Faire_Operateur_Moins;

            when '*' =>
               return Jeton_P.Fabrique_P.Faire_Operateur_Multiplier;

            when '/' =>
               if This.Ligne_En_Cours.Chaine (This.Position) = '=' then
                  This.Position := This.Position + 1;
                  return Jeton_P.Fabrique_P.Faire_Different;
               else
                  return Jeton_P.Fabrique_P.Faire_Operateur_Diviser;
               end if;

            when '=' =>
               return Jeton_P.Fabrique_P.Faire_Egal;

            when ';' =>
               return Jeton_P.Fabrique_P.Faire_Fin_Expression;

            when ',' =>
               return Jeton_P.Fabrique_P.Faire_Separateur;

            when Chiffre_T =>
               This.Position := This.Position - 1;
               return This.Extraire_Entier;

            when Lettre_T =>
               This.Position := This.Position - 1;
               return This.Extraire_Chaine;

            when others =>
               This.Position := This.Position - 1;
               return Jeton_P.Fabrique_P.Faire_Inconnu
                  (Representation => Lettre & "");
         end case;
      end Bloc_Jeton;
   end Suivant;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer
      (Contenu : in     String)
      return Ligne_T
   is
   begin
      return Ligne_T'
         (
            Taille => Contenu'Length,
            Chaine => Contenu
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Aller_Au_Prochain_Char_Non_Blanc
      (This : in out Lexical_T)
   is
      package ASCII_R renames Ada.Characters.Latin_1;

      subtype Espace_T is Character
         with Static_Predicate => Espace_T in ' ' | ASCII_R.HT | ASCII_R.VT;

      Chaine : constant String  := This.Ligne_En_Cours.Chaine;

      Est_Une_Espace : Boolean;
   begin
      Boucle_Sauter_Espaces :
      loop
         exit Boucle_Sauter_Espaces when This.Position > Chaine'Last;
         Est_Une_Espace := Chaine (This.Position) in Espace_T;
         exit Boucle_Sauter_Espaces when not Est_Une_Espace;

         This.Position := This.Position + 1;
      end loop Boucle_Sauter_Espaces;
   end Aller_Au_Prochain_Char_Non_Blanc;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Avancer
      (This : in out Lexical_T)
      return Boolean
   is
      Fin_Fichier : Boolean := False;
      Fin_Ligne   : Boolean := False;
   begin
      Boucle_Lire_Ligne :
      loop
         This.Aller_Au_Prochain_Char_Non_Blanc;

         --  Si on atteint un caractère non blanc avant la fin
         --  de la ligne, on quitte.
         Fin_Ligne := This.Position <= This.Ligne_En_Cours.Chaine'Last;
         exit Boucle_Lire_Ligne when Fin_Ligne;

         --  On quitte si on a atteint la fin du fichier.
         Fin_Fichier := Fin_Est_Atteinte_G (Contenu => This.Fichier);
         exit Boucle_Lire_Ligne when Fin_Fichier;

         --  Si on est pas a la fin du fichier on prend la ligne suivante.
         This.Num_Ligne      := Lire_Numero_Ligne_G (Contenu => This.Fichier);
         This.Ligne_En_Cours := Creer
            (Contenu => Lire_Ligne_G (Contenu => This.Fichier));
         This.Position       := This.Ligne_En_Cours.Chaine'First;
      end loop Boucle_Lire_Ligne;

      --  Si le caractère sous la tète de lecture est
      --  non blanc alors Fin_Ligne = VRAIS
      --  Si la fin de fichier est atteinte alors Fin_Ligne = FAUX
      return Fin_Ligne;
   end Avancer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Extraire_Entier
      (This : in out Lexical_T)
      return Jeton_T
   is
      subtype Nombre_T is Character
         with Static_Predicate => Nombre_T in Chiffre_T | '_';

      Chaine : constant String     := This.Ligne_En_Cours.Chaine;
      Debut  : constant Position_T := This.Position;

      Est_Un_Chiffre : Boolean;
   begin
      Boucle_Sauter_Chiffre :
      loop
         This.Position := This.Position + 1;

         exit Boucle_Sauter_Chiffre when This.Position > Chaine'Last;
         Est_Un_Chiffre := Chaine (This.Position) in Nombre_T;
         exit Boucle_Sauter_Chiffre when not Est_Un_Chiffre;
      end loop Boucle_Sauter_Chiffre;

      return Jeton_P.Fabrique_P.Faire_Entier
         (Representation => Chaine (Debut .. This.Position - 1));
      --  Il fait revenir de 1 en arrière, car la position est
      --  sur un caractère invalide.
   end Extraire_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Extraire_Chaine
      (This : in out Lexical_T)
      return Jeton_T
   is
      subtype Chaine_T is Character
         with Static_Predicate => Chaine_T in Lettre_T | Chiffre_T | '_';

      Debut : constant Position_T := This.Position;

      Est_Une_Chaine : Boolean;
   begin
      Bloc_Trouver_Fin_Chaine :
      declare
         Chaine : constant String  := This.Ligne_En_Cours.Chaine;
      begin
         B_Trouver_Fin_Chaine :
         loop
            exit B_Trouver_Fin_Chaine when This.Position > Chaine'Last;
            Est_Une_Chaine := Chaine (This.Position) in Chaine_T;
            exit B_Trouver_Fin_Chaine when not Est_Une_Chaine;

            This.Position := This.Position + 1;
         end loop B_Trouver_Fin_Chaine;
      end Bloc_Trouver_Fin_Chaine;

      Bloc_Analyser_Chaine :
      declare
         Fin            : constant Position_T := This.Position - 1;
         --  Il fait revenir de 1 en arrière, car la position est
         --  sur un caractère invalide.
         Chaine_Trouvee : constant String     :=
            This.Ligne_En_Cours.Chaine (Debut .. Fin);
      begin
         return
            (
               if    Chaine_Trouvee = "si" then
                  Jeton_P.Fabrique_P.Faire_Si

               elsif Chaine_Trouvee = "et" then
                  Jeton_P.Fabrique_P.Faire_Et

               elsif Chaine_Trouvee = "non" then
                  Jeton_P.Fabrique_P.Faire_Non

               elsif Chaine_Trouvee = "alors" then
                  Jeton_P.Fabrique_P.Faire_Alors

               elsif Chaine_Trouvee = "faits_booleens" then
                  Jeton_P.Fabrique_P.Faire_Fait_Booleen

               elsif Chaine_Trouvee = "faits_symboliques" then
                  Jeton_P.Fabrique_P.Faire_Fait_Symbolique

               elsif Chaine_Trouvee = "faits_entiers" then
                  Jeton_P.Fabrique_P.Faire_Fait_Entier

               else
                  Jeton_P.Fabrique_P.Faire_Identificateur
                     (Representation => Chaine_Trouvee)
            );
      end Bloc_Analyser_Chaine;
   end Extraire_Chaine;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G;
