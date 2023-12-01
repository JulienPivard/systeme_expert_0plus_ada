with Ada.Containers.Indefinite_Holders;

with Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;

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

   not overriding
   function Creer
      (
         Nom_Fichier : in     String;
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

   package Nom_Fichier_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => String);

   subtype Nom_Fichier_T is Nom_Fichier_P.Holder;

   package Base_De_Regles_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Base_De_Regles_T,
         "="          => Sys_Exp_P.Regles_P."="
      );

   package Fabrique_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Fabrique_R.Fabrique_Interface_T'Class,
         "="          => Fabrique_R."="
      );

   type Monteur_T is new Monteur_Abstrait_T with
      record
         Nom_Fichier    : Nom_Fichier_T;
         --  Le nom du fichier à parser.
         Base_De_Regles : Base_De_Regles_P.Holder;
         --  La base de règles à construire.
         Fabrique       : Fabrique_Holder_P.Holder;
         --  La fabrique de visiteur de formes à utiliser dans la
         --  construction de la base de règles.
      end record;

end Sys_Exp_P.Monteur_P.Lorraine_P;
