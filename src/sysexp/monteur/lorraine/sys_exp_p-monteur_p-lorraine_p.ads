with Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;

private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Pour le format des fichiers on utilise la grammaire Lorraine.
--  @description
--  Pour le format des fichiers on utilise la grammaire Lorraine.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Monteur_T is new Monteur_Abstrait_T with private;

   package Fabrique_R renames Visiteur_Forme_P.Fabrique_Interface_P;
   --  @private Package interne.

   not overriding
   function Creer
      (
         Nom_Fichier : in     Nom_Fichier_T;
         Fabrique    : in     Fabrique_R.Fabrique_Interface_T'Class
      )
      return Monteur_T;
   --  Crée un monteur de regles.
   --  @param Nom_Fichier
   --  Le nom du fichier à parser.
   --  @param Fabrique
   --  La fabrique de visiteurs.
   --  @return Le monteur de règles.

   overriding
   procedure Construire_Jeu_De_Regles
      (This : in out Monteur_T);
   --  Construit le jeu de règles.
   --  @param This
   --  Le monteur de jeu de règles.

   overriding
   function Lire_Resultat
      (This : in     Monteur_T)
      return Base_De_Regles_T;
   --  Permet de récupérer le résultat de la construction.
   --  @param This
   --  Le monteur de jeu de règles.
   --  @return Le jeu de règles construit.

private

   type Nom_Fichier_Memorise_T (Taille : NB_Caractres_T := 0) is
      record
         Nom : Nom_Fichier_T (1 .. Taille);
      end record;

   package Base_De_Regles_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Base_De_Regles_T,
         "="          => Sys_Exp_P.Regles_P."="
      );
   --  @private Package interne.

   package Fabrique_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Fabrique_R.Fabrique_Interface_T'Class,
         "="          => Fabrique_R."="
      );
   --  @private Package interne.

   subtype Fabrique_Interface_T is Fabrique_Holder_P.Holder;

   type Monteur_T is new Monteur_Abstrait_T with
      record
         Base_De_Regles : Base_De_Regles_P.Holder;
         --  La base de règles à construire.
         Fabrique       : Fabrique_Interface_T;
         --  La fabrique de visiteur de formes à utiliser dans la
         --  construction de la base de règles.
         Nom_Fichier    : Nom_Fichier_Memorise_T;
         --  Le nom du fichier à parser.
      end record;

end Sys_Exp_P.Monteur_P.Lorraine_P;
