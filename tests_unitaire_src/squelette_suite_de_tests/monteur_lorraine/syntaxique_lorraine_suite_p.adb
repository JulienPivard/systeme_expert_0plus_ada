with AUnit.Test_Caller;

with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;
with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Syntaxique_P.Test_P;

package body Syntaxique_Lorraine_Suite_P
   with Spark_Mode => Off
is

   package Lorraine_R renames Sys_Exp_P.Monteur_P.Lorraine_P;
   package Scenario_R renames Lorraine_R.Faux_Syntaxique_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test monteur syntaxique lorraine) ";
   begin
      Lorraine_R.Faux_Fichier_P.Remplir (Contenu => "");

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
                  Name => Nom_Test & "lire 1 ligne",
                  Test => Scenario_R.Test_Lire_1_Ligne'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Syntaxique_Lorraine_Suite_P;
