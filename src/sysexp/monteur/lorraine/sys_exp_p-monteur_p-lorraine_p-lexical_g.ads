with Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P;

generic

   type Numero_Ligne_G_T is (<>);
   --  Un numéro de ligne.

   type Contenu_G_T is limited private;
   --  Le contenu à parser.

   with procedure Ouvrir_G
      (
         Contenu : in out Contenu_G_T;
         Nom     : in     Nom_Fichier_T
      );
   --  Initialise le contenu à lire. Pour l'application
   --  on veux passer par un fichier, mais il peux être
   --  utile de pouvoir passer par un tout autre contenant.
   --  @param Contenu
   --  Le contenu à parser.
   --  @param Nom
   --  Le nom associé au contenu.

   with function Lire_Ligne_G
      (Contenu : in out Contenu_G_T)
      return String;
   --  Lit la prochaine ligne à lire dans le contenu.
   --  @param Contenu
   --  Le contenu à parser.
   --  @return La prochaine ligne.

   with function Lire_Numero_Ligne_G
      (Contenu : in     Contenu_G_T)
      return Numero_Ligne_G_T;
   --  Lit le numéro de la ligne en cours.
   --  @param Contenu
   --  Le contenu à parser.
   --  @return Le numéro de la ligne en cours.

   with function Fin_Est_Atteinte_G
      (Contenu : in     Contenu_G_T)
      return Boolean;
   --  Indique si on a atteint la fin du contenu.
   --  @param Contenu
   --  Le contenu à parser.
   --  @return La fin du contenu a été atteinte.

--  @summary
--  Un analyseur lexical de la grammaire Lorraine.
--  @description
--  Un analyseur lexical de la grammaire Lorraine.
--  L'analyseur lexical ne s'occupe pas du sens de ce qu'il lit
--  mais uniquement de reconnaitre les mots présents.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G is

   pragma Elaborate_Body;

   subtype Position_T is Integer;
   --  La position dans le texte.

   subtype Jeton_T is Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Jeton_T;
   --  Les jetons généré pendant le parcours du fichier.

   type Lexical_T is tagged limited private;
   --  Analyseur lexical.

   function Creer
      (Nom_Fichier : in     Nom_Fichier_T)
      return Lexical_T;
   --  Crée un parseur lexical.
   --  @param Nom_Fichier
   --  Le nom du fichier à parser.
   --  @return Le parseur lexical.

   function Lire_Ligne
      (This : in     Lexical_T)
      return String;
   --  Lit le contenu de la ligne en cours.
   --  @param This
   --  L'analyseur lexical.
   --  @return La ligne en cours.

   function Lire_Position
      (This : in     Lexical_T)
      return Position_T;
   --  Lit la position dans la ligne en cours.
   --  @param This
   --  L'analyseur lexical.
   --  @return La position dans la ligne.

   function Lire_Ancienne_Position
      (This : in     Lexical_T)
      return Position_T;
   --  Lit l'ancienne position dans la ligne en cours.
   --  @param This
   --  L'analyseur lexical.
   --  @return l'ancienne position dans la ligne.

   function Lire_Numero_Ligne
      (This : in     Lexical_T)
      return Numero_Ligne_G_T;
   --  Lit le numéro de la ligne en cours.
   --  @param This
   --  L'analyseur lexical.
   --  @return Le numéro de la ligne en cours.

   function Suivant
      (This : in out Lexical_T)
      return Jeton_T;
   --  Lit le jeton suivant.
   --  @param This
   --  L'analyseur lexical.
   --  @return Le jeton suivant.

private

   subtype NB_Char_T is Integer range 0 .. 255;
   --  Intervalle de nombre de caractères autorisé.

   type Ligne_T (Taille : NB_Char_T := 0) is
      record
         Chaine : String (1 .. Taille);
         --  Les caractères de la ligne.
      end record;
   --  La ligne.

   Ligne_Vide : constant Ligne_T := Ligne_T'
      (
         Taille => 0,
         Chaine => (others => ' ')
      );

   function Creer
      (Contenu : in     String)
      return Ligne_T;

   type Lexical_T is tagged limited
      record
         Fichier           : Contenu_G_T;
         --  Le fichier à analyser.
         Position          : Position_T := Position_T'Last;
         --  La position actuelle du jeton.
         Ancienne_Position : Position_T := Position_T'Last;
         --  Position du jeton précédent dans le fichier
         --  (pour l'affichage des erreurs).
         Num_Ligne         : Numero_Ligne_G_T := Numero_Ligne_G_T'First;
         --  Le numéro de la ligne en cours.
         Ligne_En_Cours    : Ligne_T := Ligne_Vide;
         --  La ligne en cours d'analyse.
      end record;

   procedure Aller_Au_Prochain_Char_Non_Blanc
      (This : in out Lexical_T);
   --  Décale la tète de lecture au prochain caractère non blanc.
   --  @param This
   --  L'analyseur lexical.

   function Avancer
      (This : in out Lexical_T)
      return Boolean;
   --  Permet d'avancer dans le fichier jusqu'au prochain
   --  caractère qui n'est pas un espace.
   --  @param This
   --  L'analyseur lexical.
   --  @return On n'as pas atteint la fin du fichier.

   function Extraire_Entier
      (This : in out Lexical_T)
      return Jeton_T;
   --  Permet d'extraire un entier dans le fichier.
   --  @param This
   --  L'analyseur lexical.
   --  @return un jeton associe a un entier.

   function Extraire_Chaine
      (This : in out Lexical_T)
      return Jeton_T;
   --  Permet d'extraire une chaine de caractère dans le fichier.
   --  @param This
   --  L'analyseur lexical.
   --  @return un jeton associé à un identificateur ou un si, alors, non, et.

   --------------------------------------
   function Lire_Ligne
      (This : in     Lexical_T)
      return String
   is (This.Ligne_En_Cours.Chaine);
   --------------------------------------

   --------------------------------------
   function Lire_Position
      (This : in     Lexical_T)
      return Position_T
   is (This.Position);
   --------------------------------------

   --------------------------------------
   function Lire_Ancienne_Position
      (This : in     Lexical_T)
      return Position_T
   is (This.Ancienne_Position);
   --------------------------------------

   --------------------------------------
   function Lire_Numero_Ligne
      (This : in     Lexical_T)
      return Numero_Ligne_G_T
   is (This.Num_Ligne);
   --------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G;
