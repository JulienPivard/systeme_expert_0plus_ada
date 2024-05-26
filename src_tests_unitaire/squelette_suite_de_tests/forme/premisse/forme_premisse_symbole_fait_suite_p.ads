with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des prémisses de faits de symboles.
--  @description
--  La suite de scénarios des prémisses de faits de symboles.
--  @group Fait
package Forme_Premisse_Symbole_Fait_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Forme_Premisse_Symbole_Fait_Suite_P;
