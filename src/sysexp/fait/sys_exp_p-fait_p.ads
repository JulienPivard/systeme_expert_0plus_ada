with Nom_Holder_P;

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
   --  Test d'égalité entre deux faits. Deux faits sont les même
   --  si ils ont le même nom, quelque soit leur type.
   --  @param Gauche
   --  Le fait de gauche.
   --  @param Droite
   --  Le fait de droite.
   --  @return Les faits sont égaux.

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

   type Fait_Abstrait_T is abstract tagged
      record
         Nom : Nom_Holder_P.Holder;
         --  Le nom du fait.
      end record;

end Sys_Exp_P.Fait_P;
