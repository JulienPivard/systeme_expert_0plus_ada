with AUnit.Test_Suites;

--  @summary
--  Une petite explication
--  @description
--  Une description plus longue
--  @group Jeton
package Jeton_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Jeton_Suite_P;
