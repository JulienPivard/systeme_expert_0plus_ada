with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests du visiteur de forme.
--  @description
--  Les scénarios de tests du visiteur de forme.
--  @group Visiteur
package Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Visiteur : Visiteur_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Creer
      (T : in out Test_Fixt_T);

   procedure Test_Conclusion_Bool_False
      (T : in out Test_Fixt_T);

   procedure Test_Conclusion_Bool_True
      (T : in out Test_Fixt_T);

   procedure Test_Conclusion_Expression
      (T : in out Test_Fixt_T);

   procedure Test_Conclusion_Fait_Entier
      (T : in out Test_Fixt_T);

   procedure Test_Conclusion_Symbolique_Const
      (T : in out Test_Fixt_T);

   procedure Test_Conclusion_Symbolique_Fait
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Bool_False_Rate
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Bool_True_Rate
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Expression_Rate
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Fait_Entier_Rate
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Symbolique_Const_Rate
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Symbolique_Fait_Rate
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Bool_False
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Bool_True
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Expression
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Fait_Entier
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Symbolique_Const
      (T : in out Test_Fixt_T);

   procedure Test_Premisse_Symbolique_Fait
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P;
