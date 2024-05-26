with Ada.Numerics.Discrete_Random;

package body Facilites_P.Entier_P is

   pragma Spark_Mode (Off);

   package Entier_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sys_Exp_P.Entier_T);

   Generateur_Entier : Entier_Alea_P.Generator;

   ---------------------------------------------------------------------------
   function Creer_Entier
      return Sys_Exp_P.Entier_T
   is
   begin
      return Entier_Alea_P.Random (Gen => Generateur_Entier);
   end Creer_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Entier_Different
      (Valeur : in     Sys_Exp_P.Entier_T)
      return Sys_Exp_P.Entier_T
   is
      use type Sys_Exp_P.Entier_T;

      Resultat : Sys_Exp_P.Entier_T;
   begin
      Bloc_Faire_Valeur_Entier :
      declare
      begin
         B_Entier_Different :
         loop
            Resultat := Entier_Alea_P.Random (Gen => Generateur_Entier);
            exit B_Entier_Different when Resultat /= Valeur;
         end loop B_Entier_Different;
      end Bloc_Faire_Valeur_Entier;

      return Resultat;
   end Creer_Entier_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Facilites_P.Entier_P;
