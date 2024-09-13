with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Valeur_P;
with Valeur_Abstraite_Holder_P;

--  @summary
--  Une conclusion entière basé sur une expression.
--  @description
--  Une conclusion qui contient une expression entière dont il
--  faudra déterminer la valeur grâce à la base de faits.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Conclusion_T is new Conclusion_Abstraite_T with private;
   --  Une conclusion entière dont la valeur est définie par une expression.

   not overriding
   function Creer
      (
         Nom        : in     Nom_T;
         Expression : in     Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
      )
      return Conclusion_T;
   --  Crée une conclusion entière dont la valeur est une expression.
   --  @param Nom
   --  Le nom de la conclusion.
   --  @param Expression
   --  L'expression associée.
   --  @return Une conclusion entière.

   overriding
   procedure Accepte
      (
         This     : in     Conclusion_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La conclusion.
   --  @param Visiteur
   --  Le visiteur de forme.

   not overriding
   function Lire_Valeur
      (
         This : in     Conclusion_T;
         Base : in     Sys_Exp_P.Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T;
   --  Lit la valeur stockée dans la conclusion. C'est une expression
   --  qui est stockée, il faut donc l'interpréter grâce à la base
   --  de faits.
   --  @param This
   --  La conclusion.
   --  @param Base
   --  La base de faits.
   --  @return La valeur entière.

private

   package Valeur_Abstraite_R renames Valeur_Abstraite_Holder_P;

   type Conclusion_T is new Conclusion_Abstraite_T with
      record
         Expression : Valeur_Abstraite_Holder_P.Holder;
         --  L'expression entière.
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
