--  @summary
--  Représentation concrète d'un fait booléen.
--  @description
--  Représentation concrète d'un fait booléen.
--  @group Fait
package Sys_Exp_P.Fait_P.Booleen_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Fait_Booleen_T is new Fait_Abstrait_T with private;
   --  Représentation concrète d'un fait booléen.

   not overriding
   function Creer
      (
         Nom    : in     Nom_T;
         Valeur : in     Boolean
      )
      return Fait_Booleen_T;
   --  Crée un nouveau fait.
   --  @param Nom
   --  Le nom à lui associer.
   --  @param Valeur
   --  La valeur à lui assigner.
   --  @return Le fait construit.

   overriding
   function Lire_Type
      (This : in     Fait_Booleen_T)
      return Type_De_Fait_T;
   --  Lit le type du fait.
   --  @param This
   --  Le fait,
   --  @return Le type du fait.

   not overriding
   function Lire_Valeur
      (This : in     Fait_Booleen_T)
      return Boolean;
   --  Lit la valeur contenue dans le fait.
   --  @param This
   --  Le fait.
   --  @return La valeur contenue dans le fait.

private

   type Fait_Booleen_T is new Fait_Abstrait_T with
      record
         Valeur : Boolean;
      end record;

end Sys_Exp_P.Fait_P.Booleen_P;
