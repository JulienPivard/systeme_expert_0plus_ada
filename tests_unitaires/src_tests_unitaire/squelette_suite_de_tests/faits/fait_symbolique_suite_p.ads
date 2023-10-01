with AUnit.Test_Suites;

--  @summary
--  Une petite explication
--  @description
--  Une description plus longue
--  @group Un nom de groupe
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
