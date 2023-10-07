with Sys_Exp_P;

--  @summary
--  Des facilité de créations de valeurs.
--  @description
--  Des fonctions pour faciliter la création de valeurs
--  aléatoires pour les tests unitaires.
--  @group Facilité
package Facilites_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   subtype Nom_T is Sys_Exp_P.Nom_T;

   function Creer_Nom
      return Nom_T;

   function Creer_Nom_Different
      (Nom : in     Nom_T)
      return Nom_T;

end Facilites_P;
