with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des règles sans prémisses.
--  @description
--  La suite de scénarios des règles sans prémisses.
--  @group Regle
package Regles_Sans_Premisses_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Regles_Sans_Premisses_Suite_P;
