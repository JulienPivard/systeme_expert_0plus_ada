with Ada.Exceptions;
with Ada.Text_IO;

with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Suite_De_Tests_Faits;
with Suite_De_Tests_Base;

procedure Executeur_De_Tests is
   --  Instanciation des procédures de tests.
   procedure Runner_Suite_Faits is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Faits);
   procedure Runner_Suite_Base is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Base);

   --  Options d'affichage du reporter
   Options : constant AUnit.Options.AUnit_Options :=
      AUnit.Options.AUnit_Options'
         (
            Global_Timer     => True,
            Test_Case_Timer  => True,
            Report_Successes => True,
            Filter           => null
         );
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   AUnit.Reporter.Text.Set_Use_ANSI_Colors
      (
         Engine => Reporter,
         Value  => True
      );

   --  Lancement des suites de tests.
   Runner_Suite_Faits
      (
         Reporter => Reporter,
         Options  => Options
      );

   --  Lancement des suites de tests.
   Runner_Suite_Base
      (
         Reporter => Reporter,
         Options  => Options
      );
exception
   when E : others =>
      Ada.Text_IO.Put_Line (Item => Ada.Exceptions.Exception_Name (X => E));
end Executeur_De_Tests;
