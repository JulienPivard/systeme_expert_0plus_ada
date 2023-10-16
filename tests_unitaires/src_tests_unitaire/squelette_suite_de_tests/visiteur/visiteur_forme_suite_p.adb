with AUnit.Test_Caller;

with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P;

package body Visiteur_Forme_Suite_P
   with Spark_Mode => Off
is

   package Scenario_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test visiteur forme) ";
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
                  Name => Nom_Test & "conclusion booleene fausse",
                  Test => Scenario_R.Test_Conclusion_Bool_False'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "conclusion booleene vrais",
                  Test => Scenario_R.Test_Conclusion_Bool_True'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "conclusion expression entiere",
                  Test => Scenario_R.Test_Conclusion_Expression'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "conclusion fait entier",
                  Test => Scenario_R.Test_Conclusion_Fait_Entier'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "conclusion symbolique constant",
                  Test => Scenario_R.Test_Conclusion_Symbolique_Const'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "conclusion symbolique fait",
                  Test => Scenario_R.Test_Conclusion_Symbolique_Fait'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse booleene fausse rate",
                  Test => Scenario_R.Test_Premisse_Bool_False_Rate'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse booleene vrais rate",
                  Test => Scenario_R.Test_Premisse_Bool_True_Rate'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse expression entiere rate",
                  Test => Scenario_R.Test_Premisse_Expression_Rate'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse fait entier rate",
                  Test => Scenario_R.Test_Premisse_Fait_Entier_Rate'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse symbolique constant rate",
                  Test => Scenario_R.Test_Premisse_Symbolique_Const_Rate'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse symbolique fait rate",
                  Test => Scenario_R.Test_Premisse_Symbolique_Fait_Rate'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse booleene fausse",
                  Test => Scenario_R.Test_Premisse_Bool_False'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse booleene vrais",
                  Test => Scenario_R.Test_Premisse_Bool_True'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse expression entiere",
                  Test => Scenario_R.Test_Premisse_Expression'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse fait entier",
                  Test => Scenario_R.Test_Premisse_Fait_Entier'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse symbolique constant",
                  Test => Scenario_R.Test_Premisse_Symbolique_Const'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "premisse symbolique fait",
                  Test => Scenario_R.Test_Premisse_Symbolique_Fait'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Visiteur_Forme_Suite_P;
