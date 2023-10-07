private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Un fait abstrait.
--  @description
--  Un fait abstrait pour représenter un fait concret qui sera
--  un booléen, un entier, une chaine de caractères.
--  @group Fait
package Sys_Exp_P.Fait_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Type_De_Fait_T is (Booleen_E, Entier_E, Symbole_E);
   --  Les différents type de fait possible.
   --  @Value Booleen_E
   --  C'est un fait booléen.
   --  @Value Entier_E
   --  C'est un fait entier.
   --  @Value Symbole_E
   --  C'est un fait symbolique.

   type Fait_Abstrait_T is abstract tagged private;
   --  Représentation abstraite d'un fait.

   function Lire_Nom
      (This : in     Fait_Abstrait_T)
      return Nom_T;
   --  Lit le nom du fait.
   --  @param This
   --  Le fait.
   --  @return Le nom.

   function Lire_Type
      (This : in     Fait_Abstrait_T)
      return Type_De_Fait_T
   is abstract;
   --  Lit le type du fait.
   --  @param This
   --  Le fait,
   --  @return Le type du fait.

   function "="
      (
         Gauche : in     Fait_Abstrait_T'Class;
         Droite : in     Fait_Abstrait_T'Class
      )
      return Boolean;

private

   procedure Modifier_Nom
      (
         This : in out Fait_Abstrait_T;
         Nom  : in     Nom_T
      );
   --  Modifie la valeur du nom stocké.
   --  @param This
   --  Le fait à manipuler.
   --  @param Nom
   --  Le nouveau nom à mémoriser.

   package Nom_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => Nom_T);

   type Fait_Abstrait_T is abstract tagged
      record
         Nom : Nom_P.Holder;
         --  Le nom du fait.
      end record;

end Sys_Exp_P.Fait_P;
