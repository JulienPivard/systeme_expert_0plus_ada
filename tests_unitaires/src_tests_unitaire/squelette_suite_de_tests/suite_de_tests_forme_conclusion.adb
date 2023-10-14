with Forme_Conclusion_Bool_False_Suite_P;
with Forme_Conclusion_Bool_True_Suite_P;
with Forme_Conclusion_Expression_Entiere_Suite_P;
with Forme_Conclusion_Fait_Entier_Suite_P;
with Forme_Conclusion_Symbole_Constant_Suite_P;
with Forme_Conclusion_Symbole_Fait_Suite_P;

---------------------------------------------------------------------------
function Suite_De_Tests_Forme_Conclusion
   return AUnit.Test_Suites.Access_Test_Suite
is
   Ptr_Test_Suite : constant AUnit.Test_Suites.Access_Test_Suite :=
      AUnit.Test_Suites.New_Suite;
begin
   Ptr_Test_Suite.all.Add_Test
      (T => Forme_Conclusion_Bool_False_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Forme_Conclusion_Bool_True_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Forme_Conclusion_Expression_Entiere_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Forme_Conclusion_Fait_Entier_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Forme_Conclusion_Symbole_Constant_Suite_P.Fonc_Suite);
   Ptr_Test_Suite.all.Add_Test
      (T => Forme_Conclusion_Symbole_Fait_Suite_P.Fonc_Suite);

   return Ptr_Test_Suite;
end Suite_De_Tests_Forme_Conclusion;
---------------------------------------------------------------------------
