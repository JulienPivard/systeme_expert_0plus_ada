--  @summary
--  Une fabrique abstraite de visiteur.
--  @description
--  Une fabrique abstraite de visiteur.
--  @group Visiteur Fabrique
package Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Fabrique_Interface_T is interface;
   --  Un fabrique de visiteur.

   function Fabriquer_Visiteur
      (
         This : in     Fabrique_Interface_T;
         Base : in     not null Accesseur_Base_A
      )
      return Visiteur_Forme_Abstrait_T'Class
   is abstract;
   --  Fabrique un visiteur.
   --  @param This
   --  La fabrique de visiteur de formes.
   --  @param Base
   --  La base de faits que le visiteur utilisera.
   --  @return Le visiteur construit.

private

end Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;
