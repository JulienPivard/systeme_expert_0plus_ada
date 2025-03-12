with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Test_P;

package body Jeton_Suite_P
   with Spark_Mode => Off
is

   package Scenario_R renames Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test jeton) ";
   begin
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "lire sorte [" & I'Image & "]",
                     Test => Scenario_R.Test_Lire_Sorte'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & Encode
                        (Item => "lire représentation ") &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Lire_Representation'Access
                  )
            );
      end loop;
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "est parenthèse ouvrante"),
                  Test => Scenario_R.Test_Est_Parenthese_Ouvrante'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "est parenthèse fermante"),
                  Test => Scenario_R.Test_Est_Parenthese_Fermante'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est opérateur plus"),
                  Test => Scenario_R.Test_Est_Operateur_Plus'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est opérateur moins"),
                  Test => Scenario_R.Test_Est_Operateur_Moins'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "est opérateur multiplier"),
                  Test => Scenario_R.Test_Est_Operateur_Mul'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode
                     (Item => "est opérateur diviser"),
                  Test => Scenario_R.Test_Est_Operateur_Div'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est séparateur"),
                  Test => Scenario_R.Test_Est_Separateur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est fin expression",
                  Test => Scenario_R.Test_Est_Fin_Expression'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est fin fichier",
                  Test => Scenario_R.Test_Est_Fin_Fichier'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est identificateur",
                  Test => Scenario_R.Test_Est_Identificateur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est entier",
                  Test => Scenario_R.Test_Est_Entier'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est si",
                  Test => Scenario_R.Test_Est_Si'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est non",
                  Test => Scenario_R.Test_Est_Non'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est et",
                  Test => Scenario_R.Test_Est_Et'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est alors",
                  Test => Scenario_R.Test_Est_Alors'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est égale"),
                  Test => Scenario_R.Test_Est_Egal'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est supérieur"),
                  Test => Scenario_R.Test_Est_Superieur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est inférieur"),
                  Test => Scenario_R.Test_Est_Inferieur'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est supérieur égale"),
                  Test => Scenario_R.Test_Est_Superieur_Egal'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est inférieur égale"),
                  Test => Scenario_R.Test_Est_Inferieur_Egal'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & Encode (Item => "est diffèrent"),
                  Test => Scenario_R.Test_Est_Different'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est fait booleen",
                  Test => Scenario_R.Test_Est_Fait_Booleen'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est fait symbolique",
                  Test => Scenario_R.Test_Est_Fait_Symbolique'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est fait entier",
                  Test => Scenario_R.Test_Est_Fait_Entier'Access
               )
         );

      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "est inconnu",
                  Test => Scenario_R.Test_Est_Inconnu'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Jeton_Suite_P;
