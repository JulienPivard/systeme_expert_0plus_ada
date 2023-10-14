with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests des prémisses de valeurs symbolique.
--  @description
--  Les scénarios de tests des prémisses de valeurs symbolique.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Premisse : Premisse_Symbolique_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Nom_Symbole
      (T : in out Test_Fixt_T);

   procedure Test_Comparaison_Egale
      (T : in out Test_Fixt_T);

   procedure Test_Comparaison_Different
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P.Test_P;
