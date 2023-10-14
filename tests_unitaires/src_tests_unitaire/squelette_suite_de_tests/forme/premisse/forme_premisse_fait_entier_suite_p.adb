with AUnit.Test_Caller;

with Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Test_P;

package body Forme_Premisse_Fait_Entier_Suite_P
   with Spark_Mode => Off
is

   package Premisse_R renames Sys_Exp_P.Forme_P.Premisse_P;
   package Scenario_R renames Premisse_R.Fait_Entier_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test premisse entier fait) ";
   begin
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "creation",
                  Test => Scenario_R.Test_Creer'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Forme_Premisse_Fait_Entier_Suite_P;
