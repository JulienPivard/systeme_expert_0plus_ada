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
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lire valeur",
                  Test => Scenario_R.Test_Lire_Valeur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "egalite",
                  Test => Scenario_R.Test_Comparaison_Egale'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "different",
                  Test => Scenario_R.Test_Comparaison_Different'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "inferieur",
                  Test => Scenario_R.Test_Comparaison_Inf'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "inferieur egale",
                  Test => Scenario_R.Test_Comparaison_Inf_Egale'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "superieur",
                  Test => Scenario_R.Test_Comparaison_Sup'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "superieur egale",
                  Test => Scenario_R.Test_Comparaison_Sup_Egale'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Forme_Premisse_Fait_Entier_Suite_P;
