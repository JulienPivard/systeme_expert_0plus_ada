with Ada.Numerics.Discrete_Random;

with Facilites_P.Fait_Entier_G;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Addition_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Division_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P;

package body Facilites_P.Valeur_P
   with Spark_Mode => Off
is

   package Addition_P renames Sys_Exp_P.Valeur_P.Operateur_P.Addition_P;
   package Division_P renames Sys_Exp_P.Valeur_P.Operateur_P.Division_P;
   package Multipli_P renames Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P;
   package Soustrac_P renames Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P;

   type Profondeur_T is range 1 .. 10;

   use type Sys_Exp_P.Entier_T;

   subtype Entier_Limite_T is Sys_Exp_P.Entier_T range -100 .. 100;

   package Fait_Entier_Alea_P is new Facilites_P.Fait_Entier_G
      (
         Min => Entier_Limite_T'First,
         Max => Entier_Limite_T'Last
      );

   function Creer_Valeur
      (
         Profondeur : in     Profondeur_T;
         Base       : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur     :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class;

   function Creer_Valeur_Plus
      (
         Profondeur : in     Profondeur_T;
         Base       : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur     :    out Sys_Exp_P.Entier_T
      )
      return Addition_P.Operateur_Plus_T;
   function Creer_Valeur_Div
      (
         Profondeur : in     Profondeur_T;
         Base       : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur     :    out Sys_Exp_P.Entier_T
      )
      return Division_P.Operateur_Div_T;
   function Creer_Valeur_Mult
      (
         Profondeur : in     Profondeur_T;
         Base       : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur     :    out Sys_Exp_P.Entier_T
      )
      return Multipli_P.Operateur_Mult_T;
   function Creer_Valeur_Moins
      (
         Profondeur : in     Profondeur_T;
         Base       : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur     :    out Sys_Exp_P.Entier_T
      )
      return Soustrac_P.Operateur_Moins_T;

   type Const_Ou_Fait_T is (Constante_E, Fait_E);

   type Sorte_Valeur_T is (Const_Fait_E, Plus_E, Div_E, Mult_E, Moins_E);

   package Entier_Alea_P        is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_Limite_T);
   package Const_Ou_Fait_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Const_Ou_Fait_T);
   package Sorte_Valeur_Alea_P  is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sorte_Valeur_T);

   Generateur_Entier        : Entier_Alea_P.Generator;
   Generateur_Const_Ou_Fait : Const_Ou_Fait_Alea_P.Generator;
   Generateur_Sorte_Valeur  : Sorte_Valeur_Alea_P.Generator;

   ---------------------------------------------------------------------------
   function Creer_Constante
      (
         Zero_Exclus : in     Boolean := False;
         Valeur      :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Constante_P.Feuille_Constante_T
   is
   begin
      Boucle_Generer_Valeur :
      loop
      Valeur := Entier_Alea_P.Random (Gen => Generateur_Entier);
         exit Boucle_Generer_Valeur when not Zero_Exclus;
         exit Boucle_Generer_Valeur when Valeur /= 0;
      end loop Boucle_Generer_Valeur;

      return Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => Valeur);
   end Creer_Constante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait
      (
         Zero_Exclus : in     Boolean := False;
         Base        : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur      :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Fait_P.Feuille_Fait_T
   is
      Nom : constant Nom_T := Facilites_P.Creer_Nom (Base => Base);

      Fait : Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
   begin
      Boucle_Generer_Valeur :
      loop
         Fait := Fait_Entier_Alea_P.Creer_Fait_Entier (Nom => Nom);
         exit Boucle_Generer_Valeur when not Zero_Exclus;
         exit Boucle_Generer_Valeur when Fait.Lire_Valeur /= 0;
      end loop Boucle_Generer_Valeur;

      Base.Ajouter (Nouvel_Item => Fait);
      Valeur := Fait.Lire_Valeur;

      return Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom);
   end Creer_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait_Ou_Constante
      (
         Zero_Exclus : in     Boolean := False;
         Base        : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur      :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
   is
      Val_1 : Sys_Exp_P.Entier_T;
      Val_2 : Sys_Exp_P.Entier_T;

      Choix : constant Const_Ou_Fait_T :=
         Const_Ou_Fait_Alea_P.Random (Gen => Generateur_Const_Ou_Fait);

      V : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         (
            case Choix is
               when Constante_E =>
                  Creer_Constante
                     (
                        Zero_Exclus => Zero_Exclus,
                        Valeur      => Val_1
                     ),
               when Fait_E      =>
                  Creer_Fait
                     (
                        Zero_Exclus => Zero_Exclus,
                        Base        => Base,
                        Valeur      => Val_2
                     )
         );
   begin
      case Choix is
         when Constante_E =>
            Valeur := Val_1;
         when Fait_E      =>
            Valeur := Val_2;
      end case;

      return V;
   end Creer_Fait_Ou_Constante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Valeur
      (
         Base   : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
   is
   begin
      return Creer_Valeur
         (
            Profondeur => Profondeur_T'First,
            Base       => Base,
            Valeur     => Valeur
         );
   end Creer_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Valeur
      (
         Profondeur : in     Profondeur_T;
         Base       : in out Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
         Valeur     :    out Sys_Exp_P.Entier_T
      )
      return Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
   is
      Sorte : constant Sorte_Valeur_T :=
         Sorte_Valeur_Alea_P.Random (Gen => Generateur_Sorte_Valeur);

      V : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         (
            if Profondeur = Profondeur_T'Last then
               Creer_Fait_Ou_Constante
                  (
                     Base   => Base,
                     Valeur => Valeur
                  )
            else
               (
                  case Sorte is
                     when Const_Fait_E =>
                        Creer_Fait_Ou_Constante
                           (
                              Base   => Base,
                              Valeur => Valeur
                           ),
                     when Plus_E       =>
                        Creer_Valeur
                           (
                              Profondeur => Profondeur + 1,
                              Base       => Base,
                              Valeur     => Valeur
                           )
               )
         );
   begin
      return V;
   end Creer_Valeur;
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset        (Gen => Generateur_Entier);
   Const_Ou_Fait_Alea_P.Reset (Gen => Generateur_Const_Ou_Fait);
   Sorte_Valeur_Alea_P.Reset  (Gen => Generateur_Sorte_Valeur);

end Facilites_P.Valeur_P;
