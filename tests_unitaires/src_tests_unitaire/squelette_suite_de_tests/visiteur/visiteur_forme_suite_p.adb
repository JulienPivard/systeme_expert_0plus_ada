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

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Ajoute deux fois fait booleen",
                  Test => Scenario_R.Test_Rate_Ajouter_Un_Fait_Booleen'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Ajoute deux fois fait entier",
                  Test => Scenario_R.Test_Rate_Ajouter_Un_Fait_Entier'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Ajoute deux fois fait symbolique",
                  Test => Scenario_R.Test_Rate_Ajouter_Fait_Symbolique'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion expression " &
                     "entiere absente de la base",
                  Test => Scenario_R.Test_Rate_Concl_Expr_Entier_Inconnu'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion expression " &
                     "entiere qui n'est pas un fait entier",
                  Test => Scenario_R.Test_Rate_Concl_Expr_Non_Entier'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion expression " &
                     "entiere avec une division par zero",
                  Test => Scenario_R.Test_Rate_Concl_Expr_Div_Zero'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion fait entier " &
                     "absente de la base",
                  Test => Scenario_R.Test_Rate_Concl_Fait_Entier_Inconnu'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion fait entier " &
                     "qui n'est pas un fait entier",
                  Test => Scenario_R.Test_Rate_Concl_Fait_Non_Entier'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion fait " &
                     "symbolique absente de la base",
                  Test => Scenario_R.Test_Rate_Concl_Fait_Sym_Inconnu'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "Evalue une conclusion fait " &
                     "symbolique qui n'est pas un fait symbolique",
                  Test => Scenario_R.Test_Rate_Concl_Fait_Non_Symbolique'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Visiteur_Forme_Suite_P;
