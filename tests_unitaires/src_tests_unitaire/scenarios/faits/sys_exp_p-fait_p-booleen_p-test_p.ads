with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests des faits booléens.
--  @description
--  Les scénarios de tests des faits booléens.
--  @group Fait
package Sys_Exp_P.Fait_P.Booleen_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Fait : Fait_Booleen_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer_Vrais
      (T : in out Test_Fixt_T);

   procedure Test_Creer_Faux
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Fait_P.Booleen_P.Test_P;
