with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des faits symbolique.
--  @description
--  La suite de scénarios des faits symbolique.
--  @group Fait
package Fait_Symbolique_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Fait_Symbolique_Suite_P;
