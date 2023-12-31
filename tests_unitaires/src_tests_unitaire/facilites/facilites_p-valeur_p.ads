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
      (
         Zero_Exclus : in     Boolean := False;
         Valeur      :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Constante_P.Valeur_Constante_T;

   function Creer_Fait
      (
         Zero_Exclus : in     Boolean := False;
         Base        : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur      :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T;

   function Creer_Fait_Ou_Constante
      (
         Zero_Exclus : in     Boolean := False;
         Base        : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur      :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

   function Creer_Valeur
      (
         Base   : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

end Facilites_P.Valeur_P;
