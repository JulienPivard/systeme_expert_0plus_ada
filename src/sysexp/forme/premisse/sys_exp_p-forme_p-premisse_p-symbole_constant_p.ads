--  @summary
--  Une prémisse qui contient une valeur symbolique.
--  @description
--  Une prémisse qui contient une valeur symbolique.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Premisse_T is new Premisse_Abstraite_T with private;
   --  Une prémisse dont la valeur est un nom de symbole.

   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Nom_Symbole_T;
         Nom_Symbole : in     Nom_Symbole_T
      )
      return Premisse_T;
   --  Crée une prémisse symbolique dont la valeur est un nom de symbole.
   --  @param Nom
   --  Le nom de la prémisse.
   --  @param Comparateur
   --  L'opérateur de comparaison entre nom symboliques.
   --  @param Nom_Symbole
   --  Le nom du symbole.
   --  @return Une prémisse symbolique.

   overriding
   procedure Accepte
      (
         This     : in     Premisse_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La prémisse.
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
   function Lire_Nom_Symbole
      (This : in     Premisse_T)
      return Nom_Symbole_T;
   --  Lit le nom du symbole stocké dans la prémisse.
   --  @param This
   --  La prémisse.
   --  @return Le nom du symbole.

private

   package Nom_Symbole_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => Nom_Symbole_T);

   type Premisse_T is new Premisse_Abstraite_T with
      record
         Comparateur : Comparateur_Nom_Symbole_T;
         --  Opérateur de comparaison.
         Nom_Symbole : Nom_Symbole_P.Holder;
         --  Le nom du symbole.
      end record;

end Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P;
