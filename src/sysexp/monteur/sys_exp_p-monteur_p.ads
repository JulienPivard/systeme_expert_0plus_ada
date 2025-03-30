with Sys_Exp_P.Regles_P;

private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Constructeur de la base de règles.
--  @description
--  Création de base de règles à partir d'une source
--  quelconque.
--  @group Monteur
package Sys_Exp_P.Monteur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   subtype Base_De_Regles_T is Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class;

   type Resultat_Parseur_T (Reussie : Boolean := False) is private;
   --  Le résultat du parseur du fichier lorraine.
   --  @value Reussie
   --  La réussite du parseur.

   function Lire_Base_De_Regles
      (Resultat_Parseur : in     Resultat_Parseur_T)
      return Base_De_Regles_T;
   --  Lit la base de regles contenue dans le résultat si le parseur a réussi.
   --  @param Resultat_Parseur
   --  Le résultat du parseur.
   --  @return La base de règles construite par le parseur.

   function Lire_Message_Erreur
      (Resultat_Parseur : in     Resultat_Parseur_T)
      return String;
   --  Lit le message d'erreur si le parseur n'as pas
   --  réussi à parser le fichier.
   --  @param Resultat_Parseur
   --  Le résultat du parseur.
   --  @return Le message d'erreur émis par le parseur.

   type Monteur_Abstrait_T is interface;
   --  Le constructeur de règles.

   procedure Construire_Jeu_De_Regles
      (This : in out Monteur_Abstrait_T)
   is abstract;
   --  Construit le jeu de règles.
   --  @param This
   --  Le monteur de jeu de règles.

   function Lire_Resultat
      (This : in     Monteur_Abstrait_T)
      return Resultat_Parseur_T
   is abstract;
   --  Permet de récupérer le résultat de la construction.
   --  @param This
   --  Le monteur de jeu de règles.
   --  @return Le jeu de règles construit.

private

   package Base_De_Regles_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Base_De_Regles_T,
         "="          => Sys_Exp_P.Regles_P."="
      );
   --  @private Package interne.

   subtype Taille_Msg_Erreur_T is Integer range 0 .. 255;

   type Rapport_D_Erreur_T (Taille : Taille_Msg_Erreur_T := 0) is
      record
         Message : String (1 .. Taille);
      end record;

   function Creer
      (Message : in     String)
      return Rapport_D_Erreur_T;
   --  Crée un rapport d'erreur.
   --  @param E
   --  L'exception relevée.
   --  @return Le rapport d'erreur.

   Message_Il_Faut_Parser : constant String := "Pas de parseur utilise";

   type Resultat_Parseur_T (Reussie : Boolean := False) is
      record
         case Reussie is
            when True =>
               Base_De_Regles : Base_De_Regles_P.Holder :=
                  Base_De_Regles_P.Empty_Holder;
               --  La base de règles construite et valide.
            when False =>
               Rapport_D_Erreur : Rapport_D_Erreur_T := Rapport_D_Erreur_T'
                  (
                     Taille  => Message_Il_Faut_Parser'Length,
                     Message => Message_Il_Faut_Parser
                  );
               --  Le rapport d'erreur de construction de la base de règles.
         end case;
      end record;

   pragma Unreferenced (Message_Il_Faut_Parser);
   --  Utilisé uniquement pour initialiser le message par défaut.

   ----------------------------------------
   function Lire_Base_De_Regles
      (Resultat_Parseur : in     Resultat_Parseur_T)
      return Base_De_Regles_T
   is (Resultat_Parseur.Base_De_Regles.Element);
   ----------------------------------------

   ----------------------------------------
   function Lire_Message_Erreur
      (Resultat_Parseur : in     Resultat_Parseur_T)
      return String
   is (Resultat_Parseur.Rapport_D_Erreur.Message);
   ----------------------------------------

end Sys_Exp_P.Monteur_P;
