--  @summary
--  Une conclusion qui contient un nom de fait symbolique.
--  @description
--  Une conclusion qui contient un nom de fait symbolique.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Conclusion_T is new Conclusion_Abstraite_T with private;
   --  Une conclusion dont la valeur est le nom d'un fait symbolique.

   not overriding
   function Creer
      (
         Nom      : in     Nom_T;
         Nom_Fait : in     Nom_T
      )
      return Conclusion_T;
   --  Crée une conclusion symbolique dont la
   --  valeur est un nom de fait symbolique.
   --  @param Nom
   --  Le nom de la conclusion.
   --  @param Nom_Fait
   --  Le nom du fait symbolique.
   --  @return Une conclusion symbolique.

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
   function Lire_Nom_Fait
      (This : in     Conclusion_T)
      return Nom_T;
   --  Lit le nom du fait symbolique stocké dans la conclusion.
   --  @param This
   --  La conclusion.
   --  @return Le nom du fait symbolique.

private

   type Conclusion_T is new Conclusion_Abstraite_T with
      record
         Nom_Fait : Nom_P.Holder;
         --  Le nom fait symbolique.
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P;
