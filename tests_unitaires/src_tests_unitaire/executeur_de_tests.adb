with Ada.Exceptions;
with Ada.Text_IO;

with AUnit.Options;
with AUnit.Reporter.Text;
with AUnit.Run;

with Suite_De_Tests_Base;
with Suite_De_Tests_Faits;
with Suite_De_Tests_Forme_Conclusion;
with Suite_De_Tests_Forme_Premisse;
with Suite_De_Tests_Operateur;
with Suite_De_Tests_Valeur;

procedure Executeur_De_Tests is
   --  Instanciation des procédures de tests.
   procedure Runner_Suite_Base      is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Base);
   procedure Runner_Suite_Faits     is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Faits);
   procedure Runner_Suite_Operateur is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Operateur);
   procedure Runner_Suite_Valeur    is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Valeur);

   procedure Runner_Suite_Forme_Conclusion is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Forme_Conclusion);
   procedure Runner_Suite_Forme_Premisse   is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Forme_Premisse);

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
   Runner_Suite_Base
      (
         Reporter => Reporter,
         Options  => Options
      );
   Runner_Suite_Faits
      (
         Reporter => Reporter,
         Options  => Options
      );
   Runner_Suite_Operateur
      (
         Reporter => Reporter,
         Options  => Options
      );
   Runner_Suite_Valeur
      (
         Reporter => Reporter,
         Options  => Options
      );

   Runner_Suite_Forme_Conclusion
      (
         Reporter => Reporter,
         Options  => Options
      );
   Runner_Suite_Forme_Premisse
      (
         Reporter => Reporter,
         Options  => Options
      );
exception
   when E : others =>
      Ada.Text_IO.Put_Line (Item => Ada.Exceptions.Exception_Name (X => E));
end Executeur_De_Tests;
