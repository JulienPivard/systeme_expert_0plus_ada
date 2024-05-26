with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des faits booléen.
--  @description
--  La suite de scénarios des faits booléen.
--  @group Fait
package Fait_Booleen_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Fait_Booleen_Suite_P;
