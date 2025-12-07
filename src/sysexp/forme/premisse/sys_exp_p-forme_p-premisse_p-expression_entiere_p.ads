with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Valeur_P;

with Valeur_Abstraite_Holder_P;

--  @summary
--  Une prémisse entière basé sur une expression.
--  @description
--  Une prémisse qui contient une expression entière dont il
--  faudra déterminer la valeur grâce à la base de faits.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Premisse_T is new Premisse_Abstraite_T with private;
   --  Une prémisse entière dont la valeur est définie par une expression.

   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Entier_A;
         Expression  : in     Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
      )
      return Premisse_T;
   --  Crée une prémisse entière dont la valeur est une expression.
   --  @param Nom
   --  Le nom de la prémisse.
   --  @param Comparateur
   --  L'opérateur de comparaison entre entiers.
   --  @param Expression
   --  L'expression associée.
   --  @return Une prémisse entière.

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

   not overriding
   function Lire_Valeur
      (
         This : in     Premisse_T;
         Base : in     Sys_Exp_P.Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T;
   --  Lit la valeur stockée dans la prémisse. C'est une expression
   --  qui est stockée, il faut donc l'interpréter grâce à la base
   --  de faits.
   --  @param This
   --  La prémisse.
   --  @param Base
   --  La base de faits.
   --  @return La valeur entière.

private

   package Valeur_R renames Valeur_Abstraite_Holder_P;

   type Premisse_T is new Premisse_Abstraite_T with
      record
         Comparateur : Comparateur_Entier_A;
         --  Opérateur de comparaison.
         Expression  : Valeur_Abstraite_Holder_P.Holder;
         --  L'expression entière.
      end record;

end Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;
