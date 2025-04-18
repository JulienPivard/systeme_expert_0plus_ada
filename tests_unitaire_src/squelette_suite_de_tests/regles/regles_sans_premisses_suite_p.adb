with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Regles_P.Sans_Premisse_P.Test_P;

package body Regles_Sans_Premisses_Suite_P
   with Spark_Mode => Off
is

   package Scenario_R renames Sys_Exp_P.Regles_P.Sans_Premisse_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test règles conclusion) ";
   begin
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "création"),
                  Test => Scenario_R.Test_Creer'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "ajouter successeur"),
                  Test => Scenario_R.Test_Ajouter_Successeur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "possède successeur"),
                  Test => Scenario_R.Test_Possede_Successeur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "itérer"),
                  Test => Scenario_R.Test_Iterer'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "est déclenche"),
                  Test => Scenario_R.Test_Est_Declenchee'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Regles_Sans_Premisses_Suite_P;
