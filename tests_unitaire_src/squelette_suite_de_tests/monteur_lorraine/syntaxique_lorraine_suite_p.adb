with AUnit.Test_Caller;

with Encode;

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
                  Name => Nom_Test & Encode (Item => "création"),
                  Test => Scenario_R.Test_Creer'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "lire faits booléen"),
                  Test => Scenario_R.Test_Lire_Faits_Bool'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lire faits booléen et symbolique"),
                  Test => Scenario_R.Test_Lire_Faits_Bool_Symb'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lire faits " & Encode
                     (Item => "booléen symbolique et entier"),
                  Test => Scenario_R.Test_Lire_Faits_Bool_Symb_Entier'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "utilisation d'un fait inconnu",
                  Test => Scenario_R.Test_Utiliser_Fait_Inconnu'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "appliquer 1 règle"),
                  Test => Scenario_R.Test_Appliquer_1_Regle'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Syntaxique_Lorraine_Suite_P;
