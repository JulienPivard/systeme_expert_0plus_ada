with Sys_Exp_P.Fait_P.Entier_P;

generic
   Min : Sys_Exp_P.Entier_T;
   Max : Sys_Exp_P.Entier_T;

--  @summary
--  Des facilité pour créer des faits entier.
--  @description
--  Des facilité pour créer des faits entier.
--  @group Facilité
package Facilites_P.Fait_Entier_G is

   pragma Elaborate_Body;
   pragma Spark_Mode (Off);

   function Creer_Fait_Entier
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
   --  Crée un fait de type entier avec une valeur aléatoires.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Entier_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
   --  Crée un fait de type entier avec une valeur aléatoires.
   --  @param Fait
   --  Le fait de référence.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

end Facilites_P.Fait_Entier_G;
