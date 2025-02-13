with AUnit.Test_Caller;

with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Lexical_P.Test_P;

package body Lexical_Lorraine_Suite_P
   with Spark_Mode => Off
is

   package Lorraine_R renames Sys_Exp_P.Monteur_P.Lorraine_P;
   package Scenario_R renames Lorraine_R.Faux_Lexical_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test monteur lexical lorraine) ";
   begin
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "creation",
                  Test => Scenario_R.Test_Creer'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture 1 ligne",
                  Test => Scenario_R.Test_Lire_1_Ligne'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture des jetons",
                  Test => Scenario_R.Test_Lire_Jetons'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Lexical_Lorraine_Suite_P;
