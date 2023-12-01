with Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;

--  @summary
--  Une fabrique de visiteur de forme.
--  @description
--  Une fabrique de visiteur de forme.
--  @group Fabrique Visiteur
package Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P.Fabrique_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   package Parent_R renames Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;

   type Fabrique_T is new Parent_R.Fabrique_Interface_T with private;
   --  Une fabrique concrète de visiteur de forme.
   --  Construira des visiteurs qui utilisent une base de formes.

   not overriding
   function Creer
      return Fabrique_T;
   --  Construit une fabrique de visiteurs.
   --  @return La fabrique de visiteur.

   overriding
   function Fabriquer_Visiteur
      (
         This : in     Fabrique_T;
         Base : in     not null Accesseur_Base_T
      )
      return Visiteur_Forme_Abstrait_T'Class;
   --  Fabrique un visiteur de forme concret.
   --  @param This
   --  La fabrique de visiteur.
   --  @param Base
   --  La base de fait à utiliser.
   --  @return Le visiteur construit.

private

   type Fabrique_T is new Parent_R.Fabrique_Interface_T with
      record
         null;
      end record;

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P.Fabrique_P;
