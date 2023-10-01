with Fait_Booleen_Suite_P;
with Fait_Symbolique_Suite_P;

---------------------------------------------------------------------------
function Suite_De_Tests_Faits
   return AUnit.Test_Suites.Access_Test_Suite
is
   Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
      AUnit.Test_Suites.New_Suite;
begin
   Ptr_Test_Suite.all.Add_Test
      (T => Fait_Booleen_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Fait_Symbolique_Suite_P.Fonc_Suite);

   return Ptr_Test_Suite;
end Suite_De_Tests_Faits;
---------------------------------------------------------------------------
