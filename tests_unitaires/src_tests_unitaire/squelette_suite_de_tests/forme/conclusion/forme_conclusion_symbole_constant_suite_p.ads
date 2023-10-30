with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des conclusions de symboles constant.
--  @description
--  La suite de scénarios des conclusions de symboles constant.
--  @group Fait
package Forme_Conclusion_Symbole_Constant_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Forme_Conclusion_Symbole_Constant_Suite_P;
