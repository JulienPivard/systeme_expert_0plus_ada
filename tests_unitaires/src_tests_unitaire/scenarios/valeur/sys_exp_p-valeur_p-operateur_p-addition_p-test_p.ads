with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests d'opérateur d'addition.
--  @description
--  Les scénarios de tests d'opérateur d'addition.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Plus : Operateur_Plus_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Interpreter_Fait
      (T : in out Test_Fixt_T);

   procedure Test_Interpreter_Constante
      (T : in out Test_Fixt_T);

   procedure Test_Interpreter_Mix
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Valeur_P.Operateur_P.Addition_P.Test_P;
