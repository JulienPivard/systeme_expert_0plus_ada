--  @summary
--  Une conclusion booléenne vraie.
--  @description
--  Une conclusion booléenne vraie.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Conclusion_True_T is new Conclusion_Abstraite_T with private;
   --  Une conclusion booléenne dont la valeur est vraie.

   not overriding
   function Creer
      (Nom : in     Nom_T)
      return Conclusion_True_T;
   --  Crée une conclusion booléenne dont la valeur est vraie.
   --  @param Nom
   --  Le nom de la conclusion.
   --  @return Une conclusion vraie.

   overriding
   procedure Accepte
      (
         This     : in     Conclusion_True_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La conclusion.
   --  @param Visiteur
   --  Le visiteur de forme.

private

   type Conclusion_True_T is new Conclusion_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
