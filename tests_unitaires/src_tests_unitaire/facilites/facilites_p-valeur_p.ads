with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Valeur_P;

--  @summary
--  Des facilité pour créer des valeurs.
--  @description
--  Des facilité pour créer des valeurs.
--  @group Facilité
package Facilites_P.Valeur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Creer_Constante
      (Valeur :    out Sys_Exp_P.Entier_T)
      return Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T;

   function Creer_Fait
      (
         Base   : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T;

   function Creer_Fait_Ou_Constante
      (
         Base   : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

   function Creer_Valeur
      (
         Base   : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

end Facilites_P.Valeur_P;
