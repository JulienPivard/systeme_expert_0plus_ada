with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests des règles sans prémisses.
--  @description
--  Les scénarios de tests des règles sans prémisses.
--  @group Regle
package Sys_Exp_P.Moteur_Inference_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         null;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Analyser_Base_Regles
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Moteur_Inference_P.Test_P;
