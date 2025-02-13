with AUnit;
with AUnit.Test_Fixtures;

with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;

generic

--  @summary
--  Les scénarios de tests.
--  @description
--  Les scénarios de tests.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G.Test_G
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         C : Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P.Contenu_T;
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

   procedure Test_Lire_Jetons
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G.Test_G;
