--  @summary
--  Des facilité pour créer des faits entier.
--  @description
--  Des facilité pour créer des faits entier.
--  @group Facilité
package Facilites_P.Entier_P is

   pragma Elaborate_Body;
   pragma Spark_Mode (Off);

   subtype Positif_T is Sys_Exp_P.Entier_T range 0 .. Sys_Exp_P.Entier_T'Last;

   function Creer_Entier_Positif
      return Positif_T;
   --  Crée un entier positif avec une valeur aléatoire.
   --  @return Un entier positif.

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
