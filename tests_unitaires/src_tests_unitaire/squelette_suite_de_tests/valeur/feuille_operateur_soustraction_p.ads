with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios de l'opérateur de soustraction.
--  @description
--  La suite de scénarios de l'opérateur de soustraction.
--  @group Valeur
package Feuille_Operateur_Soustraction_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Feuille_Operateur_Soustraction_P;
