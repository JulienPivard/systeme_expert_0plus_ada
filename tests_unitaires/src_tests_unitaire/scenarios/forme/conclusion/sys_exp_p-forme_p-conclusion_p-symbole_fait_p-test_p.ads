with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests des conclusions de faits de symboles.
--  @description
--  Les scénarios de tests des conclusions de faits de symboles.
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Conclusion : Conclusion_Symbolique_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Nom_Fait
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P.Test_P;