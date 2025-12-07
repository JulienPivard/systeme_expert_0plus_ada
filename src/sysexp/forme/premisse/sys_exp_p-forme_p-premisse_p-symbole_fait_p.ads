--  @summary
--  Une prémisse qui contient un nom de fait symbolique.
--  @description
--  Une prémisse qui contient un nom de fait symbolique.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Premisse_T is new Premisse_Abstraite_T with private;
   --  Une prémisse dont la valeur est le nom d'un fait symbolique.

   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Nom_Symbole_A;
         Nom_Fait    : in     Nom_T
      )
      return Premisse_T;
   --  Crée une prémisse symbolique dont la
   --  valeur est un nom de fait symbolique.
   --  @param Nom
   --  Le nom de la prémisse.
   --  @param Comparateur
   --  L'opérateur de comparaison entre nom symboliques.
   --  @param Nom_Fait
   --  Le nom du fait symbolique.
   --  @return Une prémisse symbolique.

   overriding
   procedure Accepte
      (
         This     : in     Premisse_T;
         Base     : in out Base_Faits_P.Base_De_Faits_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La prémisse.
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Visiteur
   --  Le visiteur de forme.

   not overriding
   function Comparer
      (
         This   : in     Premisse_T;
         Gauche : in     Nom_Symbole_T;
         Droite : in     Nom_Symbole_T
      )
      return Boolean;
   --  Compare deux nom symbolique avec l'opérateur stocké.
   --  @param This
   --  La prémisse.
   --  @param Gauche
   --  Le partie gauche de l'expression.
   --  @param Droite
   --  Le partie droite de l'expression.
   --  @return Le résultat de la comparaison.

   not overriding
   function Lire_Nom_Fait
      (This : in     Premisse_T)
      return Nom_T;
   --  Lit le nom du fait symbolique stocké dans la prémisse.
   --  @param This
   --  La prémisse.
   --  @return Le nom du fait symbolique.

private

   type Premisse_T is new Premisse_Abstraite_T with
      record
         Comparateur : Comparateur_Nom_Symbole_A;
         --  Opérateur de comparaison.
         Nom_Fait    : Nom_Holder_P.Holder;
         --  Le nom fait symbolique.
      end record;

end Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P;
