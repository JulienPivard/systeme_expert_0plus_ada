with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios de l'opérateur de division.
--  @description
--  La suite de scénarios de l'opérateur de division.
--  @group Valeur
package Feuille_Operateur_Division_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Feuille_Operateur_Division_P;
