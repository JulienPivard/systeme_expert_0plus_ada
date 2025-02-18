--  @summary
--  Les fonctions de comparaisons disponibles.
--  @description
--  Les fonctions de comparaisons disponibles.
--  @group Comparateurs
package Sys_Exp_P.Comparateurs_P
   with
      Pure           => True,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   generic
      type Valeur_G_T (<>) is limited private;
      --  Le type de valeur à comparer.

      with function Comparateur_G
         (Gauche, Droite : in     Valeur_G_T)
         return Boolean;
      --  Compare deux valeurs entières.
      --  @param Gauche
      --  Entier à gauche de l'expression.
      --  @param Droite
      --  Entier à droite de l'expression.
      --  @return Le résultat de la comparaison.

   function Tester_G
      (Gauche, Droite : in     Valeur_G_T)
      return Boolean;
   --  Comparaison générique entre deux entiers.
   --  @param Gauche
   --  Entier à gauche de l'expression.
   --  @param Droite
   --  Entier à droite de l'expression.
   --  @return Le résultat de la comparaison.

end Sys_Exp_P.Comparateurs_P;
