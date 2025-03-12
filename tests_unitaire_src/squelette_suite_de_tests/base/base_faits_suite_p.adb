with AUnit.Test_Caller;

with Encode;

with Sys_Exp_P.Base_Faits_P.Test_P;

package body Base_Faits_Suite_P
   with Spark_Mode => Off
is

   package Scenario_R renames Sys_Exp_P.Base_Faits_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test base de faits) ";
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
                  Name => Nom_Test & "ne contient pas le fait recherche",
                  Test => Scenario_R.Test_Contient_Base_Vide'Access
               )
         );
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "ne doit pas contenir le fait " &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Trouver_Inconnu'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & Encode
                        (Item => "ajouter deux fois le même fait ") &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Ajouter_Deux_Fois_Le_Meme'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & Encode
                        (
                           Item => "ajouter deux fois le même fait " &
                              "avec une valeur différente "
                        ) &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Ajouter_Deux_Fois'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & Encode
                        (
                           Item => "ajouter deux fois le même fait " &
                              "avec un type diffèrent "
                        ) &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Ajouter_2_F_Type_Differents'Access
                  )
            );
      end loop;
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "ne trouve pas le fait recherche",
                  Test => Scenario_R.Test_Trouver_Base_Vide'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "ajouter booleen 1",
                  Test => Scenario_R.Test_Ajouter_B_1'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "ajouter entier 1",
                  Test => Scenario_R.Test_Ajouter_E_1'Access
               )
         );
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "ajouter symbolique 1",
                  Test => Scenario_R.Test_Ajouter_S_1'Access
               )
         );
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "ajouter multiples [" & I'Image & "]",
                     Test => Scenario_R.Test_Ajouter_Multiples'Access
                  )
            );
      end loop;

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Base_Faits_Suite_P;
