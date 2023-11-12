--  @summary
--  Représentation concrète d'un fait entier.
--  @description
--  Représentation concrète d'un fait entier.
--  @group Fait
package Sys_Exp_P.Fait_P.Entier_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Fait_Entier_T is new Fait_Abstrait_T with private;
   --  Représentation concrète d'un fait entier.

   not overriding
   function Creer
      (
         Nom    : in     Nom_T;
         Valeur : in     Entier_T
      )
      return Fait_Entier_T;
   --  Crée un nouveau fait.
   --  @param Nom
   --  Le nom à lui associer.
   --  @param Valeur
   --  La valeur à lui assigner.
   --  @return Le fait construit.

   overriding
   function Lire_Type
      (This : in     Fait_Entier_T)
      return Type_De_Fait_T;
   --  Lit le type du fait.
   --  @param This
   --  Le fait,
   --  @return Le type du fait.

   not overriding
   function Lire_Valeur
      (This : in     Fait_Entier_T)
      return Entier_T;
   --  Lit la valeur contenue dans le fait.
   --  @param This
   --  Le fait.
   --  @return La valeur contenue dans le fait.

private

   type Fait_Entier_T is new Fait_Abstrait_T with
      record
         Valeur : Entier_T;
      end record;

end Sys_Exp_P.Fait_P.Entier_P;
