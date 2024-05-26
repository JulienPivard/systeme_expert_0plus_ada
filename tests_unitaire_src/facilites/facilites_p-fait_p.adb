with Ada.Numerics.Discrete_Random;

package body Facilites_P.Fait_P
   with Spark_Mode => Off
is

   subtype Fait_Booleen_T is Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T;
   subtype Fait_Entier_T  is Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
   subtype Fait_Symbole_T is Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T;

   package Booleen_Alea_P    is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Boolean);
   package Entier_Alea_P     is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sys_Exp_P.Entier_T);
   package Sorte_Fait_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sys_Exp_P.Type_De_Fait_T);

   Generateur_Booleen    : Booleen_Alea_P.Generator;
   Generateur_Entier     : Entier_Alea_P.Generator;
   Generateur_Sorte_Fait : Sorte_Fait_Alea_P.Generator;

   ---------------------------------------------------------------------------
   function Creer_Fait
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class
   is
      Sorte : constant Sys_Exp_P.Type_De_Fait_T :=
         Sorte_Fait_Alea_P.Random (Gen => Generateur_Sorte_Fait);
   begin
      return Creer_Fait
         (
            Nom   => Nom,
            Sorte => Sorte
         );
   end Creer_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait
      (
         Nom   : in     Sys_Exp_P.Nom_T;
         Sorte : in     Sys_Exp_P.Type_De_Fait_T
      )
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class
   is
   begin
      return
         (
            case Sorte is
               when Sys_Exp_P.Booleen_E    =>
                  Creer_Fait_Booleen    (Nom => Nom),
               when Sys_Exp_P.Entier_E     =>
                  Creer_Fait_Entier     (Nom => Nom),
               when Sys_Exp_P.Symbolique_E =>
                  Creer_Fait_Symbolique (Nom => Nom)
         );
   end Creer_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait_Booleen
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T
   is
   begin
      return Sys_Exp_P.Fait_P.Booleen_P.Creer
         (
            Nom    => Nom,
            Valeur => Booleen_Alea_P.Random (Gen => Generateur_Booleen)
         );
   end Creer_Fait_Booleen;
   ---------------------------------------------------------------------------

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
   function Creer_Fait_Symbolique
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T
   is
   begin
      return Sys_Exp_P.Fait_P.Symbolique_P.Creer
         (
            Nom    => Nom,
            Valeur => Creer_Symbole
         );
   end Creer_Fait_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class
   is
      use type Sys_Exp_P.Type_De_Fait_T;

      Sorte : Sys_Exp_P.Type_De_Fait_T;
   begin
      B_Sorte_Differente :
      loop
         Sorte := Sorte_Fait_Alea_P.Random (Gen => Generateur_Sorte_Fait);
         exit B_Sorte_Differente when Sorte /= Fait.Lire_Type;
      end loop B_Sorte_Differente;

      return Creer_Fait_Different
         (
            Fait  => Fait,
            Nom   => Nom,
            Sorte => Sorte
         );
   end Creer_Fait_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait_Different
      (
         Fait  : in     Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
         Nom   : in     Sys_Exp_P.Nom_T;
         Sorte : in     Sys_Exp_P.Type_De_Fait_T
      )
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class
   is
      use type Sys_Exp_P.Type_De_Fait_T;
   begin
      return
         (
            if Fait.Lire_Type = Sorte then
               (
                  case Sorte is
                     when Sys_Exp_P.Booleen_E =>
                        Creer_Fait_Booleen_Different
                           (
                              Fait => Fait_Booleen_T (Fait),
                              Nom  => Nom
                           ),
                     when Sys_Exp_P.Entier_E =>
                        Creer_Fait_Entier_Different
                           (
                              Fait => Fait_Entier_T (Fait),
                              Nom  => Nom
                           ),
                     when Sys_Exp_P.Symbolique_E =>
                        Creer_Fait_Symbolique_Different
                           (
                              Fait => Fait_Symbole_T (Fait),
                              Nom  => Nom
                           )
               )
            else
               Creer_Fait
                  (
                     Nom   => Nom,
                     Sorte => Sorte
                  )
         );
   end Creer_Fait_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Fait_Booleen_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T
   is
   begin
      return Sys_Exp_P.Fait_P.Booleen_P.Creer
         (
            Nom    => Nom,
            Valeur => not Fait.Lire_Valeur
         );
   end Creer_Fait_Booleen_Different;
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
   function Creer_Fait_Symbolique_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T
   is
   begin
      return Sys_Exp_P.Fait_P.Symbolique_P.Creer
         (
            Nom    => Nom,
            Valeur => Creer_Symbole_Different (Nom => Fait.Lire_Valeur)
         );
   end Creer_Fait_Symbolique_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

begin

   Booleen_Alea_P.Reset    (Gen => Generateur_Booleen);
   Entier_Alea_P.Reset     (Gen => Generateur_Entier);
   Sorte_Fait_Alea_P.Reset (Gen => Generateur_Sorte_Fait);

end Facilites_P.Fait_P;
