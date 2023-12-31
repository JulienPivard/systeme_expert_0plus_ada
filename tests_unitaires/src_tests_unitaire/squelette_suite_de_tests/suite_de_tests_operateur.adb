with Feuille_Operateur_Addition_P;
with Feuille_Operateur_Division_P;
with Feuille_Operateur_Multiplication_P;
with Feuille_Operateur_Soustraction_P;

---------------------------------------------------------------------------
function Suite_De_Tests_Operateur
   return AUnit.Test_Suites.Access_Test_Suite
is
   Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
      AUnit.Test_Suites.New_Suite;
begin
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Operateur_Addition_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Operateur_Division_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Operateur_Multiplication_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Feuille_Operateur_Soustraction_P.Fonc_Suite);

   return Ptr_Test_Suite;
end Suite_De_Tests_Operateur;
---------------------------------------------------------------------------
