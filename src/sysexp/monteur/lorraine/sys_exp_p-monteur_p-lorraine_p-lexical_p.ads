with Ada.Text_IO;

with Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P;

private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Un analyseur lexical de la grammaire Lorraine.
--  @description
--  Un analyseur lexical de la grammaire Lorraine.
--  L'analyseur lexical ne s'occupe pas du sens de ce qu'il lit
--  mais uniquement de reconnaitre les mots présents.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   subtype Jeton_T is Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Jeton_T;

   type Lexical_T is tagged limited private;
   --  Analyseur lexical.

   function Creer
      (Nom_Fichier : in     String)
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
      return Integer;
   --  Lit la position dans la ligne en cours.
   --  @param This
   --  L'analyseur lexical.
   --  @return La position dans la ligne.

   function Lire_Ancienne_Position
      (This : in     Lexical_T)
      return Integer;
   --  Lit l'ancienne position dans la ligne en cours.
   --  @param This
   --  L'analyseur lexical.
   --  @return l'ancienne position dans la ligne.

   function Lire_Numero_Ligne
      (This : in     Lexical_T)
      return Ada.Text_IO.Positive_Count;
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

   package Ligne_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => String);

   type Lexical_T is tagged limited
      record
         Fichier           : Ada.Text_IO.File_Type;
         --  Le fichier à analyser.
         Position          : Integer := Integer'Last;
         --  La position actuelle du jeton.
         Ancienne_Position : Integer := Integer'Last;
         --  Position du jeton précédent dans le fichier
         --  (pour l'affichage des erreurs).
         Num_Ligne         : Ada.Text_IO.Positive_Count := 1;
         --  Le numéro de la ligne en cours.
         Ligne_En_Cours    : Ligne_P.Holder :=
            Ligne_P.To_Holder (New_Item => "");
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
   is (This.Ligne_En_Cours.Element);
   --------------------------------------

   --------------------------------------
   function Lire_Position
      (This : in     Lexical_T)
      return Integer
   is (This.Position);
   --------------------------------------

   --------------------------------------
   function Lire_Ancienne_Position
      (This : in     Lexical_T)
      return Integer
   is (This.Ancienne_Position);
   --------------------------------------

   --------------------------------------
   function Lire_Numero_Ligne
      (This : in     Lexical_T)
      return Ada.Text_IO.Positive_Count
   is (This.Num_Ligne);
   --------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_P;
