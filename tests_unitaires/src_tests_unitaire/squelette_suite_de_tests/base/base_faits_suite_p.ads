with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios de la base de faits.
--  @description
--  La suite de scénarios de la base de faits.
--  @group Base
package Base_Faits_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Base_Faits_Suite_P;
