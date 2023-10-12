with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios de l'opérateur de multiplication.
--  @description
--  La suite de scénarios de l'opérateur de multiplication.
--  @group Valeur
package Feuille_Operateur_Multiplication_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Feuille_Operateur_Multiplication_P;
