with AUnit;
with AUnit.Test_Fixtures;

generic

--  @summary
--  Les scénarios de tests.
--  @description
--  Les scénarios de tests.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G is

   pragma Spark_Mode (Off);
   pragma Elaborate_Body;

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

   procedure Test_Lire_1_Ligne
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G;
