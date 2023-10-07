with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests de la base de faits.
--  @description
--  Les scénarios de tests de la base de faits.
--  @group Base
package Sys_Exp_P.Base_Faits_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Base : Base_De_Faits_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Contient_Base_Vide
      (T : in out Test_Fixt_T);

   procedure Test_Trouver_Base_Vide
      (T : in out Test_Fixt_T);

   procedure Test_Trouver_Inconnu
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_Deux_Fois_Le_Meme
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_Deux_Fois
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_2_F_Type_Differents
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_B_1
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_E_1
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_S_1
      (T : in out Test_Fixt_T);

   procedure Test_Ajouter_Multiples
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Base_Faits_P.Test_P;
