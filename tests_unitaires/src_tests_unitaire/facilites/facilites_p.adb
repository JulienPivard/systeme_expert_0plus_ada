with Ada.Numerics.Discrete_Random;

package body Facilites_P
   with Spark_Mode => Off
is

   use type Sys_Exp_P.Taille_Nom_T;

   subtype Lettre_T is Character range 'a' .. 'z';

   subtype Taille_Min_Nom_T is Sys_Exp_P.Taille_Nom_T range
      Sys_Exp_P.Taille_Nom_T'First + 3 .. Sys_Exp_P.Taille_Nom_T'Last;

   package Lettre_Alea_P     is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Lettre_T);
   package Taille_Nom_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Taille_Min_Nom_T);

   Generateur_Lettre : Lettre_Alea_P.Generator;
   Generateur_Taille : Taille_Nom_Alea_P.Generator;

   ---------------------------------------------------------------------------
   function Creer_Nom
      return Nom_T
   is
      Taille : constant Sys_Exp_P.Taille_Nom_T :=
         Taille_Nom_Alea_P.Random (Gen => Generateur_Taille);

      Debut : constant Sys_Exp_P.Taille_Nom_T := Sys_Exp_P.Taille_Nom_T'First;
      Fin   : constant Sys_Exp_P.Taille_Nom_T := Debut + Taille - 1;

      subtype Taille_T is Sys_Exp_P.Taille_Nom_T range Debut .. Fin;

      Nom : Nom_T (Taille_T);
   begin
      for I in Taille_T loop
         Nom (I) := Lettre_Alea_P.Random (Gen => Generateur_Lettre);
      end loop;

      return Nom;
   end Creer_Nom;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Nom_Different
      (Nom : in     Nom_T)
      return Nom_T
   is
      use type Sys_Exp_P.Nom_T;
   begin
      Boucle_Trouver_Nom :
      loop
         Bloc_Trouver_Nom :
         declare
            Resultat : constant Nom_T := Creer_Nom;
         begin
            if Resultat /= Nom then
               return Resultat;
            end if;
         end Bloc_Trouver_Nom;
      end loop Boucle_Trouver_Nom;
   end Creer_Nom_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Symbole
      return Nom_Symbole_T
   is
      Nom : constant Nom_T := Creer_Nom;
   begin
      return Nom_Symbole_T (Nom);
   end Creer_Symbole;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Symbole_Different
      (Nom : in     Nom_Symbole_T)
      return Nom_Symbole_T
   is
      N        : constant Nom_T := Nom_T (Nom);
      Resultat : constant Nom_T := Creer_Nom_Different (Nom => N);
   begin
      return Nom_Symbole_T (Resultat);
   end Creer_Symbole_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Lettre_Alea_P.Reset     (Gen => Generateur_Lettre);
   Taille_Nom_Alea_P.Reset (Gen => Generateur_Taille);

end Facilites_P;
