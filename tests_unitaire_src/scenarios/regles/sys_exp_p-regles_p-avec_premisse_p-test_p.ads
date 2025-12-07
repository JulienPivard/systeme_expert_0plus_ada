with AUnit;
with AUnit.Test_Fixtures;

with Sys_Exp_P.Base_Faits_P;

--  @summary
--  Les scénarios de tests des règles avec prémisses.
--  @description
--  Les scénarios de tests des règles avec prémisses.
--  @group Regle
package Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Base  : Base_Faits_P.Base_De_Faits_T;
         Regle : Regle_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Possede_Successeur
      (T : in out Test_Fixt_T);

   procedure Test_Iterer
      (T : in out Test_Fixt_T);

   procedure Test_Est_Declenchee
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_Premisse
      (T : in out Test_Fixt_T);

   procedure Test_Verifier_Premisse
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Regles_P.Avec_Premisse_P.Test_P;
