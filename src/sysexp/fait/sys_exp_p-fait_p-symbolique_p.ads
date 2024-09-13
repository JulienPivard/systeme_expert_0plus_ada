with Symbole_Holder_P;

--  @summary
--  Représentation concrète d'un fait symbolique.
--  @description
--  Représentation concrète d'un fait symbolique.
--  Un fait symbolique contient le nom d'un autre
--  fait pour y faire référence.
--  @group Fait
package Sys_Exp_P.Fait_P.Symbolique_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Fait_Symbolique_T is new Fait_Abstrait_T with private;
   --  Représentation concrète d'un fait symbolique.

   not overriding
   function Creer
      (
         Nom    : in     Nom_T;
         Valeur : in     Nom_Symbole_T
      )
      return Fait_Symbolique_T;
   --  Crée un nouveau fait.
   --  @param Nom
   --  Le nom à lui associer.
   --  @param Valeur
   --  La valeur à lui assigner.
   --  @return Le fait construit.

   overriding
   function Lire_Type
      (This : in     Fait_Symbolique_T)
      return Type_De_Fait_T;
   --  Lit le type du fait.
   --  @param This
   --  Le fait,
   --  @return Le type du fait.

   not overriding
   function Lire_Valeur
      (This : in     Fait_Symbolique_T)
      return Nom_Symbole_T;
   --  Lit la valeur contenue dans le fait.
   --  @param This
   --  Le fait.
   --  @return La valeur contenue dans le fait.

private

   package Symbole_R renames Symbole_Holder_P;

   type Fait_Symbolique_T is new Fait_Abstrait_T with
      record
         Symbole : Symbole_Holder_P.Holder;
         --  Le nom symbolique du fait.
      end record;

end Sys_Exp_P.Fait_P.Symbolique_P;
