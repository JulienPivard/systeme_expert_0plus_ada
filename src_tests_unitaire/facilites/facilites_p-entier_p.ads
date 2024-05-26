--  @summary
--  Des facilité pour créer des faits entier.
--  @description
--  Des facilité pour créer des faits entier.
--  @group Facilité
package Facilites_P.Entier_P is

   pragma Elaborate_Body;
   pragma Spark_Mode (Off);

   function Creer_Entier
      return Sys_Exp_P.Entier_T;
   --  Crée un entier avec une valeur aléatoires.
   --  @return La valeur entière.

   function Creer_Entier_Different
      (Valeur : in     Sys_Exp_P.Entier_T)
      return Sys_Exp_P.Entier_T;
   --  Crée un entier avec une valeur aléatoires.
   --  @param Valeur
   --  La valeur qui ne doit pas être générée.
   --  @return La valeur entière.

end Facilites_P.Entier_P;
