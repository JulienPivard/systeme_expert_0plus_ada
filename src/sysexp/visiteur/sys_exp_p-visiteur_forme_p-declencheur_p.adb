with Ada.Exceptions;
with Ada.Strings.Fixed;

with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Symbolique_P;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P;

with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P;

with Sys_Exp_P.Valeur_P;

package body Sys_Exp_P.Visiteur_Forme_P.Declencheur_P
   with Spark_Mode => Off
is

   package Booleen_R renames Sys_Exp_P.Fait_P.Booleen_P;
   package Entier_R  renames Sys_Exp_P.Fait_P.Entier_P;
   package Valeur_R  renames Sys_Exp_P.Valeur_P;

   package Base_Faits_R renames Sys_Exp_P.Base_Faits_P;
   package Symbolique_R renames Sys_Exp_P.Fait_P.Symbolique_P;

   ---------------------------------------------------------------------------
   function Creer
      (Base : in     Accesseur_Base_T)
      return Visiteur_T
   is
   begin
      return Visiteur_T'
         (
            Base                        => Base,
            Premisse_A_Ete_Verifiee     => False,
            Conclusion_A_Ete_Declenchee => False,
            Code_Erreur                 => Tout_Va_Bien_E,
            Message_D_Erreur            => Message_Vide
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                       La visite des conclusions                       --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Forme_P.Conclusion_P.Bool_False_P.Conclusion_False_T
      )
   is
      Fait : constant Booleen_R.Fait_Booleen_T := Booleen_R.Creer
         (
            Nom    => Forme.Lire_Nom,
            Valeur => False
         );
   begin
      This.Ajouter_Un_Fait (Fait => Fait);
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Forme_P.Conclusion_P.Bool_True_P.Conclusion_True_T
      )
   is
      Fait : constant Booleen_R.Fait_Booleen_T := Booleen_R.Creer
         (
            Nom    => Forme.Lire_Nom,
            Valeur => True
         );
   begin
      This.Ajouter_Un_Fait (Fait => Fait);
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Expression_T
      )
   is
   begin
      Bloc_Lire_Valeur :
      declare
         Valeur : constant Sys_Exp_P.Entier_T     :=
            Forme.Lire_Valeur (Base => This.Base.all);
         Fait   : constant Entier_R.Fait_Entier_T := Entier_R.Creer
            (
               Nom    => Forme.Lire_Nom,
               Valeur => Valeur
            );
      begin
         This.Ajouter_Un_Fait (Fait => Fait);
      end Bloc_Lire_Valeur;
   exception
      when E : Base_Faits_R.E_Fait_Inconnu | Valeur_R.E_Fait_Inconnu =>
         This.Code_Erreur := Fait_Expression_Inconnu_E;
         Ada.Strings.Fixed.Move
            (
               Source => Ada.Exceptions.Exception_Message (X => E),
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
      when E : Valeur_R.E_Fait_Non_Entier =>
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => Ada.Exceptions.Exception_Message (X => E),
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
      when E : Valeur_R.E_Division_Par_Zero =>
         This.Code_Erreur := Div_Par_Zero_E;
         Ada.Strings.Fixed.Move
            (
               Source => Ada.Exceptions.Exception_Message (X => E),
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Fait_Entier_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom_Fait) then
         Bloc_Construire_Conclusion :
         declare
            --  Le fait trouvé dans la base.
            Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom_Fait);
            --  On le convertit en fait entier.
            Fait_Entier : Entier_R.Fait_Entier_T renames
               Entier_R.Fait_Entier_T (Fait);
            --  On crée un nouveau fait avec le nom de la conclusion
            --  et la valeur du fait entier.
            Nouveau_Fait : constant Entier_R.Fait_Entier_T := Entier_R.Creer
               (
                  Nom    => Forme.Lire_Nom,
                  Valeur => Fait_Entier.Lire_Valeur
               );
         begin
            --  La conclusion est déclenchée, on l'ajoute.
            This.Ajouter_Un_Fait (Fait => Nouveau_Fait);
         end Bloc_Construire_Conclusion;
      else
         This.Code_Erreur := Fait_Entier_Inconnu_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "est inconnu",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait entier a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait entier",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Symbolique_Constante_T
      )
   is
      Fait : constant Symbolique_R.Fait_Symbolique_T := Symbolique_R.Creer
         (
            Nom    => Forme.Lire_Nom,
            Valeur => Forme.Lire_Nom_Symbole
         );
   begin
      This.Ajouter_Un_Fait (Fait => Fait);
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Symbolique_Fait_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom_Fait) then
         Bloc_Construire_Conclusion :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom_Fait);
            --  On le convertit en fait symbolique.
            Fait_Symbole : Symbolique_R.Fait_Symbolique_T renames
               Symbolique_R.Fait_Symbolique_T (Fait_Trouve);
            --  On crée un nouveau fait avec le nom de la conclusion
            --  et la valeur du fait symbolique.
            Nouveau_Fait : constant Symbolique_R.Fait_Symbolique_T :=
               Symbolique_R.Creer
                  (
                     Nom    => Forme.Lire_Nom,
                     Valeur => Fait_Symbole.Lire_Valeur
                  );
         begin
            --  La conclusion est déclenchée, on l'ajoute.
            This.Ajouter_Un_Fait (Fait => Nouveau_Fait);
         end Bloc_Construire_Conclusion;
      else
         This.Code_Erreur := Fait_Symbolique_Inconnu_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "est inconnu",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait symbolique a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait symbolique",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                        La visite des prémisses                        --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_False_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom) then
         Bloc_Construire_Premisse :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom);
            --  On le convertit en fait booléen.
            Fait_Bool   : Booleen_R.Fait_Booleen_T renames
               Booleen_R.Fait_Booleen_T (Fait_Trouve);
         begin
            This.Premisse_A_Ete_Verifiee := not Fait_Bool.Lire_Valeur;
         end Bloc_Construire_Premisse;
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait booléen a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait booléen",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_True_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom) then
         Bloc_Construire_Premisse :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom);
            --  On le convertit en fait booléen.
            Fait_Bool   : Booleen_R.Fait_Booleen_T renames
               Booleen_R.Fait_Booleen_T (Fait_Trouve);
         begin
            This.Premisse_A_Ete_Verifiee := Fait_Bool.Lire_Valeur;
         end Bloc_Construire_Premisse;
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait booléen a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait booléen",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Expression_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom) then
         Bloc_Construire_Premisse :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom);
            --  On le convertit en fait entier.
            Fait_Entier : Entier_R.Fait_Entier_T renames
               Entier_R.Fait_Entier_T (Fait_Trouve);
         begin
            This.Premisse_A_Ete_Verifiee := Forme.Comparer
               (
                  Gauche => Fait_Entier.Lire_Valeur,
                  Droite => Forme.Lire_Valeur (Base => This.Base.all)
               );
         end Bloc_Construire_Premisse;
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait booléen a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait entier",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Fait_Entier_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom)
         and then
         This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom_Fait)
      then
         Bloc_Construire_Premisse :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom);
            --  Le fait trouvé dans la base.
            Autre_Fait  : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom_Fait);

            --  On le convertit en fait entier.
            Fait_Entier       : Entier_R.Fait_Entier_T renames
               Entier_R.Fait_Entier_T (Fait_Trouve);
            Autre_Fait_Entier : Entier_R.Fait_Entier_T renames
               Entier_R.Fait_Entier_T (Autre_Fait);
         begin
            This.Premisse_A_Ete_Verifiee := Forme.Comparer
               (
                  Gauche => Fait_Entier.Lire_Valeur,
                  Droite => Autre_Fait_Entier.Lire_Valeur
               );
         end Bloc_Construire_Premisse;
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait booléen a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait entier",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Symbolique_Constante_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom) then
         Bloc_Construire_Premisse :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve  : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom);
            --  On le convertit en fait entier.
            Fait_Symbole : Symbolique_R.Fait_Symbolique_T renames
               Symbolique_R.Fait_Symbolique_T (Fait_Trouve);
         begin
            This.Premisse_A_Ete_Verifiee := Forme.Comparer
               (
                  Gauche => Fait_Symbole.Lire_Valeur,
                  Droite => Forme.Lire_Nom_Symbole
               );
         end Bloc_Construire_Premisse;
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait booléen a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait symbolique",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Symbolique_Fait_T
      )
   is
   begin
      --  Le fait appartient à la base.
      if This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom)
         and then
         This.Base.all.Contient (Nom_Fait => Forme.Lire_Nom_Fait)
      then
         Bloc_Construire_Premisse :
         declare
            --  Le fait trouvé dans la base.
            Fait_Trouve  : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom);
            --  Le fait trouvé dans la base.
            Autre_Fait   : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               This.Base.all.Trouver (Nom_Fait => Forme.Lire_Nom_Fait);

            --  On le convertit en fait entier.
            Fait_Symbole       : Symbolique_R.Fait_Symbolique_T renames
               Symbolique_R.Fait_Symbolique_T (Fait_Trouve);
            --  On le convertit en fait entier.
            Autre_Fait_Symbole : Symbolique_R.Fait_Symbolique_T renames
               Symbolique_R.Fait_Symbolique_T (Autre_Fait);
         begin
            This.Premisse_A_Ete_Verifiee := Forme.Comparer
               (
                  Gauche => Fait_Symbole.Lire_Valeur,
                  Droite => Autre_Fait_Symbole.Lire_Valeur
               );
         end Bloc_Construire_Premisse;
      end if;
   exception
      when Constraint_Error =>
         --  La conversion en fait booléen a échouée.
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => "Le fait [" & String (Forme.Lire_Nom) & "] " &
                  "n'est pas un fait symbolique",
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;
