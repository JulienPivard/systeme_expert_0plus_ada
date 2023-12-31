with AUnit.Test_Suites;

--  @summary
--  La suite de scénarios du moteur d'inférence.
--  @description
--  La suite de scénarios du moteur d'inférence.
--  @group Regle
package Moteur_Inference_Suite_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite;

end Moteur_Inference_Suite_P;
