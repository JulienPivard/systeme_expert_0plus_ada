with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios du visiteur de forme.
--  @description
--  La suite de scénarios du visiteur de forme.
--  @group Visiteur
package Visiteur_Forme_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Visiteur_Forme_Suite_P;
