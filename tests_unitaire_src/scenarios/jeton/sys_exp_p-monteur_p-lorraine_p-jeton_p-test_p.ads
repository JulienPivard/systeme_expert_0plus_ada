with AUnit;
with AUnit.Test_Fixtures;

--  @summary
--  Les scénarios de tests des jetons.
--  @description
--  Les scénarios de tests des jetons.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Test_Fixt_T is new AUnit.Test_Fixtures.Test_Fixture with
      record
         Jeton : Jeton_T;
      end record;

   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T);

   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Sorte
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Representation
      (T : in out Test_Fixt_T);

   procedure Test_Est_Parenthese_Ouvrante
      (T : in out Test_Fixt_T);

   procedure Test_Est_Parenthese_Fermante
      (T : in out Test_Fixt_T);

   procedure Test_Est_Operateur_Plus
      (T : in out Test_Fixt_T);

   procedure Test_Est_Operateur_Moins
      (T : in out Test_Fixt_T);

   procedure Test_Est_Operateur_Mul
      (T : in out Test_Fixt_T);

   procedure Test_Est_Operateur_Div
      (T : in out Test_Fixt_T);

   procedure Test_Est_Separateur
      (T : in out Test_Fixt_T);

   procedure Test_Est_Fin_Expression
      (T : in out Test_Fixt_T);

   procedure Test_Est_Fin_Fichier
      (T : in out Test_Fixt_T);

   procedure Test_Est_Identificateur
      (T : in out Test_Fixt_T);

   procedure Test_Est_Entier
      (T : in out Test_Fixt_T);

   procedure Test_Est_Si
      (T : in out Test_Fixt_T);

   procedure Test_Est_Non
      (T : in out Test_Fixt_T);

   procedure Test_Est_Et
      (T : in out Test_Fixt_T);

   procedure Test_Est_Alors
      (T : in out Test_Fixt_T);

   procedure Test_Est_Egal
      (T : in out Test_Fixt_T);

   procedure Test_Est_Superieur
      (T : in out Test_Fixt_T);

   procedure Test_Est_Inferieur
      (T : in out Test_Fixt_T);

   procedure Test_Est_Superieur_Egal
      (T : in out Test_Fixt_T);

   procedure Test_Est_Inferieur_Egal
      (T : in out Test_Fixt_T);

   procedure Test_Est_Different
      (T : in out Test_Fixt_T);

   procedure Test_Est_Fait_Booleen
      (T : in out Test_Fixt_T);

   procedure Test_Est_Fait_Symbolique
      (T : in out Test_Fixt_T);

   procedure Test_Est_Fait_Entier
      (T : in out Test_Fixt_T);

   procedure Test_Est_Inconnu
      (T : in out Test_Fixt_T);

private

   function Creer
      (
         Sorte          : in     Sorte_T;
         Representation : in     String
      )
      return Jeton_T;

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Test_P;
