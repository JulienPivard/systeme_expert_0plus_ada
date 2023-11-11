--  @summary
--  Les instances utiles de comparateurs.
--  @description
--  Les instances utiles de comparateurs.
--  @group Comparateurs
package Sys_Exp_P.Comparateurs_P.Instance_P
   with
      Pure           => True,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   function Egale is new Tester_G
      (
         Valeur_G_T    => Nom_Symbole_T,
         Comparateur_G => Sys_Exp_P."="
      );
   --  Test si deux noms sont les même.

   function Different is new Tester_G
      (
         Valeur_G_T    => Nom_Symbole_T,
         Comparateur_G => Sys_Exp_P."/="
      );
   --  Test si deux noms sont les différents.

   function Egale is new Tester_G
      (
         Valeur_G_T    => Entier_T,
         Comparateur_G => Sys_Exp_P."="
      );
   --  Test si deux entier sont égaux.

   function Different is new Tester_G
      (
         Valeur_G_T    => Entier_T,
         Comparateur_G => Sys_Exp_P."/="
      );
   --  Test si deux entier sont différents.

   function Superieur is new Tester_G
      (
         Valeur_G_T    => Entier_T,
         Comparateur_G => Sys_Exp_P.">"
      );
   --  Test si un entier est supérieur à l'autre.

   function Inferieur is new Tester_G
      (
         Valeur_G_T    => Entier_T,
         Comparateur_G => Sys_Exp_P."<"
      );
   --  Test si un entier est inférieur à l'autre.

   function Superieur_Egale is new Tester_G
      (
         Valeur_G_T    => Entier_T,
         Comparateur_G => Sys_Exp_P.">="
      );
   --  Test si un entier est supérieur égale à l'autre.

   function Inferieur_Egale is new Tester_G
      (
         Valeur_G_T    => Entier_T,
         Comparateur_G => Sys_Exp_P."<="
      );
   --  Test si un entier est inférieur égale à l'autre.

end Sys_Exp_P.Comparateurs_P.Instance_P;
