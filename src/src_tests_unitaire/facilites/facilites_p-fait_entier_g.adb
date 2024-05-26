with Ada.Numerics.Discrete_Random;

package body Facilites_P.Fait_Entier_G is

   pragma Spark_Mode (Off);

   subtype Entier_Limite_T is Sys_Exp_P.Entier_T range Min .. Max;

   package Entier_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_Limite_T);

   Generateur_Entier : Entier_Alea_P.Generator;

   ---------------------------------------------------------------------------
   function Creer_Fait_Entier
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T
   is
   begin
      return Sys_Exp_P.Fait_P.Entier_P.Creer
         (
            Nom    => Nom,
            Valeur => Entier_Alea_P.Random (Gen => Generateur_Entier)
         );
   end Creer_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait_Entier_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T
   is
      use type Sys_Exp_P.Entier_T;

      Valeur : Sys_Exp_P.Entier_T;
   begin
      Bloc_Faire_Valeur_Entier :
      declare
      begin
         B_Entier_Different :
         loop
            Valeur := Entier_Alea_P.Random (Gen => Generateur_Entier);
            exit B_Entier_Different when Fait.Lire_Valeur /= Valeur;
         end loop B_Entier_Different;
      end Bloc_Faire_Valeur_Entier;

      return Sys_Exp_P.Fait_P.Entier_P.Creer
         (
            Nom    => Nom,
            Valeur => Valeur
         );
   end Creer_Fait_Entier_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);

end Facilites_P.Fait_Entier_G;
