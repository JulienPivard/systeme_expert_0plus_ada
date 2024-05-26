with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des feuilles fait.
--  @description
--  La suite de scénarios des feuilles qui font référence à un fait.
--  @group Valeur
package Feuille_Fait_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Feuille_Fait_Suite_P;
