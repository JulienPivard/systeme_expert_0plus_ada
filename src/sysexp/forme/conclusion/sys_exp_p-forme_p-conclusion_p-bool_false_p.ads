--  @summary
--  Une conclusion booléenne fausse.
--  @description
--  Une conclusion booléenne fausse.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Conclusion_T is new Conclusion_Abstraite_T with private;
   --  Une conclusion booléenne dont la valeur est fausse.

   not overriding
   function Creer
      (Nom : in     Nom_T)
      return Conclusion_T;
   --  Crée une conclusion booléenne dont la valeur est fausse.
   --  @param Nom
   --  Le nom de la conclusion.
   --  @return Une conclusion fausse.

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

private

   type Conclusion_T is new Conclusion_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
