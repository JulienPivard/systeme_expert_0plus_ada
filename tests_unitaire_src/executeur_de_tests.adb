with Ada.Characters.Latin_1;
with Ada.Command_Line;
with Ada.Exceptions;
with Ada.Text_IO;

with GNAT.Source_Info;

with AUnit.Options;
with AUnit.Reporter.Text;
with AUnit.Reporter.XML;
with AUnit.Run;

with Suite_De_Tests_Base;
with Suite_De_Tests_Faits;
with Suite_De_Tests_Forme_Conclusion;
with Suite_De_Tests_Forme_Premisse;
with Suite_De_Tests_Operateur;
with Suite_De_Tests_Regles;
with Suite_De_Tests_Valeur;
with Suite_De_Tests_Visiteur_Forme;
with Suite_De_Tests_Moteur_Inference;

with Suite_De_Tests_Jeton;

procedure Executeur_De_Tests is
   type Mode_T is (Txt_E, XML_E);

   ---------------------------------------------------------------------------
   function Creer_Reporter
      return AUnit.Reporter.Reporter'Class;

   function Creer_Reporter
      return AUnit.Reporter.Reporter'Class
   is
      NB_Args : constant Integer := Ada.Command_Line.Argument_Count;

      Mode : constant Mode_T :=
         (
            if NB_Args = 0 then
               Txt_E
            elsif Ada.Command_Line.Argument (1) = "xml" then
               XML_E
            elsif Ada.Command_Line.Argument (1) = "txt" then
               Txt_E
            else
               Txt_E
         );

      Reporter_Txt : AUnit.Reporter.Text.Text_Reporter;
      Reporter_XML : AUnit.Reporter.XML.XML_Reporter;
   begin
      case Mode is
         when Txt_E =>
            AUnit.Reporter.Text.Set_Use_ANSI_Colors
               (
                  Engine => Reporter_Txt,
                  Value  => True
               );
         when XML_E =>
            null;
      end case;

      return
         (
            case Mode is
               when Txt_E =>
                  Reporter_Txt,
               when XML_E =>
                  Reporter_XML
         );
   end Creer_Reporter;
   ---------------------------------------------------------------------------

   --  Instanciation des procédures de tests.
   procedure Runner_Suite_Base      is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Base);
   procedure Runner_Suite_Faits     is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Faits);
   procedure Runner_Suite_Operateur is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Operateur);
   procedure Runner_Suite_Valeur    is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Valeur);
   procedure Runner_Suite_Regles    is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Regles);
   procedure Runner_Suite_Moteur    is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Moteur_Inference);

   procedure Runner_Suite_Forme_Conclusion is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Forme_Conclusion);
   procedure Runner_Suite_Forme_Premisse   is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Forme_Premisse);
   procedure Runner_Suite_Visiteur_Forme   is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Visiteur_Forme);

   procedure Runner_Suite_Jeton is new AUnit.Run.Test_Runner
      (Suite => Suite_De_Tests_Jeton);

   --  Options d'affichage du reporter
   Options  : constant AUnit.Options.AUnit_Options :=
      AUnit.Options.AUnit_Options'
         (
            Global_Timer     => True,
            Test_Case_Timer  => True,
            Report_Successes => True,
            Filter           => null
         );
   Reporter : constant AUnit.Reporter.Reporter'Class := Creer_Reporter;
begin
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
   Runner_Suite_Visiteur_Forme
      (
         Reporter => Reporter,
         Options  => Options
      );
   Runner_Suite_Regles
      (
         Reporter => Reporter,
         Options  => Options
      );
   Runner_Suite_Moteur
      (
         Reporter => Reporter,
         Options  => Options
      );

   Runner_Suite_Jeton
      (
         Reporter => Reporter,
         Options  => Options
      );
exception
   when E : others =>
      Ada.Text_IO.Put_Line
         (
            Item => Ada.Exceptions.Exception_Information (X => E) &
                  Ada.Characters.Latin_1.LF & GNAT.Source_Info.Source_Location
         );
end Executeur_De_Tests;
