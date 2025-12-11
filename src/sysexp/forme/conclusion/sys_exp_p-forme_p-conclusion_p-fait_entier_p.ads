--  @summary
--  Une conclusion entière basé sur la valeur d'un fait.
--  @description
--  Une conclusion qui contient un nom de fait entier.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Conclusion_T is new Conclusion_Abstraite_T with private;
   --  Une conclusion dont la valeur est définie par un fait entier.

   not overriding
   function Creer
      (
         Nom      : in     Nom_T;
         Nom_Fait : in     Nom_T
      )
      return Conclusion_T;
   --  Crée une conclusion entière dont la valeur est un nom de fait entier.
   --  @param Nom
   --  Le nom de la conclusion.
   --  @param Nom_Fait
   --  Le nom du fait entier.
   --  @return Une conclusion entière fait.

   overriding
   procedure Accepte
      (
         This     : in     Conclusion_T;
         Base     : in out Base_Faits_P.Base_De_Faits_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La conclusion.
   --  @param Base
   --  La base de faits où on va ajouter les conclusions déclenchées.
   --  @param Visiteur
   --  Le visiteur de forme.

   not overriding
   function Lire_Nom_Fait
      (This : in     Conclusion_T)
      return Nom_T;
   --  Lit le nom du fait stocké dans la conclusion.
   --  @param This
   --  La conclusion.
   --  @return Le nom du fait.

   overriding
   function Image
      (This : in     Conclusion_T)
      return String;
   --  La conclusion convertie en chaine de caractères.
   --  @param This
   --  La conclusion.
   --  @return L'image de la conclusion.

private

   type Conclusion_T is new Conclusion_Abstraite_T with
      record
         Nom_Fait : Nom_Holder_P.Holder;
         --  Le nom du fait entier.
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P;
