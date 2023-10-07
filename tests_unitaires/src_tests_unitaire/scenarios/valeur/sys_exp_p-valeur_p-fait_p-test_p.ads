with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests de feuille fait.
--  @description
--  Les scénarios de tests de feuille qui fait référence à un fait.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Fait_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Feuille : Feuille_Fait_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Interpreter
      (T : in out Test_Fixt_T);

   procedure Test_Interpreter_Inconnu
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Valeur_P.Fait_P.Test_P;
