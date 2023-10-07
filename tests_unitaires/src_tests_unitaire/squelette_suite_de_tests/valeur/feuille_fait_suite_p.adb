with AUnit.Test_Caller;

with Sys_Exp_P.Valeur_P.Fait_P.Test_P;

package body Feuille_Fait_Suite_P
   with Spark_Mode => Off
is

   package Scenario_R renames Sys_Exp_P.Valeur_P.Fait_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test feuille fait) ";
   begin
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "creation [" & I'Image & "]",
                     Test => Scenario_R.Test_Creer'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "interpreter [" & I'Image & "]",
                     Test => Scenario_R.Test_Interpreter'Access
                  )
            );
      end loop;
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "exception fait inconnu",
                  Test => Scenario_R.Test_Interpreter_Inconnu'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Feuille_Fait_Suite_P;
