with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P.Test_P;

package body Forme_Premisse_Symbole_Fait_Suite_P
   with Spark_Mode => Off
is

   package Premisse_R renames Sys_Exp_P.Forme_P.Premisse_P;
   package Scenario_R renames Premisse_R.Symbole_Fait_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test prémisse fait symbole) ";
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
                  Name => Encode (Item => Nom_Test & "lire nom symbole"),
                  Test => Scenario_R.Test_Lire_Nom_Fait'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "égalité"),
                  Test => Scenario_R.Test_Comparaison_Egale'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Encode (Item => Nom_Test & "diffèrent"),
                  Test => Scenario_R.Test_Comparaison_Different'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Forme_Premisse_Symbole_Fait_Suite_P;
