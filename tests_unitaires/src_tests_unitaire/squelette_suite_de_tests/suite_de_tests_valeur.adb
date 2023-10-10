with Feuille_Constante_Suite_P;
with Feuille_Fait_Suite_P;
with Feuille_Operateur_Addition_P;

---------------------------------------------------------------------------
function Suite_De_Tests_Valeur
   return AUnit.Test_Suites.Access_Test_Suite
is
   Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
      AUnit.Test_Suites.New_Suite;
begin
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Constante_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Fait_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Operateur_Addition_P.Fonc_Suite);

   return Ptr_Test_Suite;
end Suite_De_Tests_Valeur;
---------------------------------------------------------------------------
