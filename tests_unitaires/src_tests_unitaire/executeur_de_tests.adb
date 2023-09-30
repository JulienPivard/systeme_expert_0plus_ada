with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Options;

with Pack_A_Tester_Suite_De_Tests_P;

procedure Executeur_De_Tests is

   --  Instanciation des procédures de tests.
   procedure Runner_Suite_Pack_A_Tester is new AUnit.Run.Test_Runner
      (Suite => Pack_A_Tester_Suite_De_Tests_P.Fonc_Suite);

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
   AUnit.Reporter.Text.Set_Use_ANSI_Colors (Engine => Reporter, Value => True);

   --  Lancement des suites de tests.
   Runner_Suite_Pack_A_Tester (Reporter => Reporter, Options => Options);
end Executeur_De_Tests;
