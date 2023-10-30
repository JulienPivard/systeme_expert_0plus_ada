--  @summary
--  Une prémisse entière basé sur la valeur d'un fait.
--  @description
--  Une prémisse qui contient un nom de fait entier.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Premisse_Fait_T is new Premisse_Abstraite_T with private;
   --  Une prémisse dont la valeur est définie par un fait entier.

   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Entier_T;
         Nom_Fait    : in     Nom_T
      )
      return Premisse_Fait_T;
   --  Crée une prémisse entière dont la valeur est un nom de fait entier.
   --  @param Nom
   --  Le nom de la prémisse.
   --  @param Comparateur
   --  L'opérateur de comparaison entre entiers.
   --  @param Nom_Fait
   --  Le nom du fait entier.
   --  @return Une prémisse entière fait.

   overriding
   procedure Accepte
      (
         This     : in     Premisse_Fait_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La prémisse.
   --  @param Visiteur
   --  Le visiteur de forme.

   function Comparer
      (
         This   : in     Premisse_Fait_T;
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean;
   --  Compare deux valeurs entière avec l'opérateur stocké.
   --  @param This
   --  La prémisse.
   --  @param Gauche
   --  Le partie gauche de l'expression.
   --  @param Droite
   --  Le partie droite de l'expression.
   --  @return Le résultat de la comparaison.

   function Lire_Nom_Fait
      (This : in     Premisse_Fait_T)
      return Nom_T;
   --  Lit le nom du fait stocké dans la prémisse.
   --  @param This
   --  La prémisse.
   --  @return Le nom du fait.

private

   type Premisse_Fait_T is new Premisse_Abstraite_T with
      record
         Comparateur : Comparateur_Entier_T;
         --  Opérateur de comparaison.
         Nom_Fait    : Nom_P.Holder;
         --  Le nom du fait entier.
      end record;

end Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;
