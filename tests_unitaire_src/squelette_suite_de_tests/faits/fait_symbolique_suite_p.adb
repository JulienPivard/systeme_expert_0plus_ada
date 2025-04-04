with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Fait_P.Symbolique_P.Test_P;

package body Fait_Symbolique_Suite_P
   with Spark_Mode => Off
is

   package Scenario_R renames Sys_Exp_P.Fait_P.Symbolique_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test fait symbolique) ";
   begin
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "création"),
                  Test => Scenario_R.Test_Creer'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Fait_Symbolique_Suite_P;
