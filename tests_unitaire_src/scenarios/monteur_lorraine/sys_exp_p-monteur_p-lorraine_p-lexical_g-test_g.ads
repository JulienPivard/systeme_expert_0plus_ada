with AUnit;
with AUnit.Test_Fixtures;

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

   procedure Test_Lire_Jetons
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Parenthese_Ouvrante
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Parenthese_Fermante
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Operateur_Plus
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Operateur_Moins
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Operateur_Mul
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Operateur_Div
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Separateur
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Fin_Expression
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Fin_Fichier
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Identificateur
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Entier
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Si
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Non
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Et
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Alors
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Egal
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Superieur
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Inferieur
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Superieur_Egal
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Inferieur_Egal
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Different
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Fait_Booleen
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Fait_Symbolique
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Fait_Entier
      (T : in out Test_Fixt_T);

   procedure Test_Lire_Jeton_Inconnu
      (T : in out Test_Fixt_T);

end Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G.Test_G;
