with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Lexical_P.Test_P;

package body Lexical_Lorraine_Suite_P
   with Spark_Mode => Off
is

   package Lorraine_R renames Sys_Exp_P.Monteur_P.Lorraine_P;
   package Scenario_R renames Lorraine_R.Faux_Lexical_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test monteur lexical lorraine) ";
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
                  Name => Nom_Test & "lecture 1 ligne",
                  Test => Scenario_R.Test_Lire_1_Ligne'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton parenthèse ouvrante"),
                  Test => Scenario_R.Test_Lire_Jeton_Parenthese_Ouvrante'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton parenthèse fermante"),
                  Test => Scenario_R.Test_Lire_Jeton_Parenthese_Fermante'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton opérateur plus"),
                  Test => Scenario_R.Test_Lire_Jeton_Operateur_Plus'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton opérateur moins"),
                  Test => Scenario_R.Test_Lire_Jeton_Operateur_Moins'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton opérateur multiplier"),
                  Test => Scenario_R.Test_Lire_Jeton_Operateur_Mul'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton opérateur diviser"),
                  Test => Scenario_R.Test_Lire_Jeton_Operateur_Div'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton séparateur"),
                  Test => Scenario_R.Test_Lire_Jeton_Separateur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton fin expression",
                  Test => Scenario_R.Test_Lire_Jeton_Fin_Expression'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton fin fichier",
                  Test => Scenario_R.Test_Lire_Jeton_Fin_Fichier'Access
               )
         );

      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "lecture jeton identificateur " &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Lire_Jeton_Identificateur'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "lecture jeton entier " &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Lire_Jeton_Entier'Access
                  )
            );
      end loop;

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton si",
                  Test => Scenario_R.Test_Lire_Jeton_Si'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton non",
                  Test => Scenario_R.Test_Lire_Jeton_Non'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton et",
                  Test => Scenario_R.Test_Lire_Jeton_Et'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton alors",
                  Test => Scenario_R.Test_Lire_Jeton_Alors'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "lecture jeton égal"),
                  Test => Scenario_R.Test_Lire_Jeton_Egal'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton supérieur"),
                  Test => Scenario_R.Test_Lire_Jeton_Superieur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton inférieur"),
                  Test => Scenario_R.Test_Lire_Jeton_Inferieur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton supérieur égal"),
                  Test => Scenario_R.Test_Lire_Jeton_Superieur_Egal'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton inférieur égal"),
                  Test => Scenario_R.Test_Lire_Jeton_Inferieur_Egal'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "lecture jeton diffèrent"),
                  Test => Scenario_R.Test_Lire_Jeton_Different'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton faits_booleens",
                  Test => Scenario_R.Test_Lire_Jeton_Fait_Booleen'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton faits_symboliques",
                  Test => Scenario_R.Test_Lire_Jeton_Fait_Symbolique'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton faits_entiers",
                  Test => Scenario_R.Test_Lire_Jeton_Fait_Entier'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture jeton inconnu",
                  Test => Scenario_R.Test_Lire_Jeton_Inconnu'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "lecture de multiples jetons",
                  Test => Scenario_R.Test_Lire_Jetons'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Lexical_Lorraine_Suite_P;
