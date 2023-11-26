--  @summary
--  Une conclusion qui contient une valeur symbolique.
--  @description
--  Une conclusion qui contient une valeur symbolique.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Conclusion_T is new Conclusion_Abstraite_T with private;
   --  Une conclusion dont la valeur est un nom de symbole.

   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Nom_Symbole : in     Nom_Symbole_T
      )
      return Conclusion_T;
   --  Crée une conclusion symbolique dont la valeur est un nom de symbole.
   --  @param Nom
   --  Le nom de la conclusion.
   --  @param Nom_Symbole
   --  Le nom du symbole.
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
   function Lire_Nom_Symbole
      (This : in     Conclusion_T)
      return Nom_Symbole_T;
   --  Lit le nom du symbole stocké dans la conclusion.
   --  @param This
   --  La conclusion.
   --  @return Le nom du symbole.

private

   package Nom_Symbole_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => Nom_Symbole_T);

   type Conclusion_T is new Conclusion_Abstraite_T with
      record
         Nom_Symbole : Nom_Symbole_P.Holder;
         --  Le nom du symbole.
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P;
