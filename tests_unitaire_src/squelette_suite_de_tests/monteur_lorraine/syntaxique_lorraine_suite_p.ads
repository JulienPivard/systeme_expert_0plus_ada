with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios du monteur avec grammaire Lorraine.
--  @description
--  La suite de scénarios du monteur avec grammaire Lorraine.
--  @group Monteur
package Syntaxique_Lorraine_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Syntaxique_Lorraine_Suite_P;
