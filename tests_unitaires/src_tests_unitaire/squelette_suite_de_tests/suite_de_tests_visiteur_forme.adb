with Visiteur_Forme_Suite_P;

---------------------------------------------------------------------------
function Suite_De_Tests_Visiteur_Forme
   return AUnit.Test_Suites.Access_Test_Suite
is
   Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
      AUnit.Test_Suites.New_Suite;
begin
   Ptr_Test_Suite.all.Add_Test
      (T => Visiteur_Forme_Suite_P.Fonc_Suite);

   return Ptr_Test_Suite;
end Suite_De_Tests_Visiteur_Forme;
---------------------------------------------------------------------------
