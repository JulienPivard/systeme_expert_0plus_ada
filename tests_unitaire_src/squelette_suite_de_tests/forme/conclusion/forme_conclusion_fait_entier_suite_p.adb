with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P.Test_P;

package body Forme_Conclusion_Fait_Entier_Suite_P
   with Spark_Mode => Off
is

   package Conclusion_R renames Sys_Exp_P.Forme_P.Conclusion_P;
   package Scenario_R   renames Conclusion_R.Fait_Entier_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test conclusion entier fait) ";
   begin
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "création"),
                  Test => Scenario_R.Test_Creer'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lire nom fait",
                  Test => Scenario_R.Test_Lire_Nom_Fait'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Forme_Conclusion_Fait_Entier_Suite_P;
