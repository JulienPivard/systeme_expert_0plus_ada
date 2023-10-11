with AUnit.Test_Caller;

with Sys_Exp_P.Valeur_P.Operateur_P.Division_P.Test_P;

package body Feuille_Operateur_Division_P
   with Spark_Mode => Off
is

   package Operateur_R renames Sys_Exp_P.Valeur_P.Operateur_P;
   package Scenario_R  renames Operateur_R.Division_P.Test_P;

   package Caller_P is new AUnit.Test_Caller
      (Test_Fixture => Scenario_R.Test_Fixt_T);

   ---------------------------------------------------------------------------
   function Fonc_Suite
      return AUnit.Test_Suites.Access_Test_Suite
   is
      Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
         AUnit.Test_Suites.New_Suite;

      Nom_Test : constant String := "(Test operateur diviser) ";
   begin
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "creation",
                  Test => Scenario_R.Test_Creer'Access
               )
         );
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "interpreter fait [" & I'Image & "]",
                     Test => Scenario_R.Test_Interpreter_Fait'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "interpreter constante " &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Interpreter_Constante'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "interpreter mixte " &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Interpreter_Mix'Access
                  )
            );
      end loop;
      for I in 1 .. 10 loop
         Ptr_Test_Suite.all.Add_Test
            (
               T => Caller_P.Create
                  (
                     Name => Nom_Test & "interpreter mixte etendu " &
                        "[" & I'Image & "]",
                     Test => Scenario_R.Test_Interpreter_Mix_Etendu'Access
                  )
            );
      end loop;
      Ptr_Test_Suite.all.Add_Test
         (
            T => Caller_P.Create
               (
                  Name => Nom_Test & "exception div par zero",
                  Test => Scenario_R.Test_Diviser_Par_Zero'Access
               )
         );

      return Ptr_Test_Suite;
   end Fonc_Suite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Feuille_Operateur_Division_P;
