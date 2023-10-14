with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios des prémisses d'expression entières.
--  @description
--  La suite de scénarios des prémisses d'expression entières.
--  @group Fait
package Forme_Premisse_Expression_Entiere_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Forme_Premisse_Expression_Entiere_Suite_P;
