with AUnit.Assertions;

with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Symbolique_P;

with Ada.Numerics.Discrete_Random;

package body Sys_Exp_P.Base_Faits_P.Test_P
   with Spark_Mode => Off
is

   subtype Fait_Booleen_T is Fait_P.Booleen_P.Fait_Booleen_T;
   subtype Fait_Entier_T  is Fait_P.Entier_P.Fait_Entier_T;
   subtype Fait_Symbole_T is Fait_P.Symbolique_P.Fait_Symbolique_T;
   subtype Nom_Symbole_T  is Fait_P.Symbolique_P.Nom_Symbole_T;

   use type Fait_P.Taille_Nom_T;

   subtype Taille_Min_Nom_T is Fait_P.Taille_Nom_T range
      Fait_P.Taille_Nom_T'First + 3 .. Fait_P.Taille_Nom_T'Last;

   subtype Lettre_T is Character range 'a' .. 'z';

   package Entier_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Entier_T);
   package Lettre_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Lettre_T);

   package Taille_Nom_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Taille_Min_Nom_T);
   package Sorte_Fait_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Fait_P.Type_De_Fait_T);

   Generateur_Entier : Entier_Alea_P.Generator;
   Generateur_Lettre : Lettre_Alea_P.Generator;
   Generateur_Taille : Taille_Nom_Alea_P.Generator;

   Generateur_Sorte_Fait : Sorte_Fait_Alea_P.Generator;

   function Creer_Nom
      return Nom_T;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
   begin
      T.Base.Map_Faits.Clear;
   end Set_Up;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
   begin
      null;
   end Tear_Down;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Trouver;
   --  Doit déclencher une exception sur un fait introuvable.

   --------------------
   procedure Trouver is
      Base : Base_De_Faits_T;
   begin
      Bloc_Trouver :
      declare
         Nom  : constant Nom_T := Creer_Nom;
         Fait : constant Fait_P.Fait_Abstrait_T'Class :=
            Base.Trouver (Nom_Fait => Nom);
      begin
         pragma Unreferenced (Fait);
         null;
      end Bloc_Trouver;
   end Trouver;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Is_Empty,
            Message   => "La base de faits doit etre vide a la creation"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Contient_Base_Vide
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Creer_Nom;
   begin
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Is_Empty,
            Message   => "La base de faits doit etre vide a la creation"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Base.Contient (Nom_Fait => Nom),
            Message   => "La base de faits doit etre vide"
         );
   end Test_Contient_Base_Vide;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Trouver_Base_Vide
      (T : in out Test_Fixt_T)
   is
      Nom : constant Nom_T := Creer_Nom;
   begin
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Is_Empty,
            Message   => "La base de faits doit etre vide a la creation"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Base.Contient (Nom_Fait => Nom),
            Message   => "La base de faits doit etre vide"
         );
      AUnit.Assertions.Assert_Exception
         (
            Proc    => Trouver'Access,
            Message => "La base de faits doit etre vide"
         );
   end Test_Trouver_Base_Vide;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_B_1
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      use type Fait_P.Nom_T;
      use type Fait_P.Type_De_Fait_T;

      Nom    : constant Nom_T   := Creer_Nom;
      Valeur : constant Boolean := True;

      Fait : constant Fait_Booleen_T := Fait_P.Booleen_P.Creer
         (
            Nom    => Nom,
            Valeur => Valeur
         );
   begin
      T.Base.Ajouter (Nouvel_Item => Fait);
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Length = 1,
            Message   => "La base de fait doit contenir 1 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Contient (Nom_Fait => Nom),
            Message   => "La base de fait doit contenir 1 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );
      Bloc_Verification_Contenu :
      declare
         F : constant Fait_P.Fait_Abstrait_T'Class :=
            T.Base.Trouver (Nom_Fait => Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => F.Lire_Nom = Fait.Lire_Nom,
               Message   => "La base de fait doit contenir " &
                  "[" & String (Nom) & "] mais on trouve " &
                  "[" & String (F.Lire_Nom) & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => F.Lire_Type = Fait.Lire_Type,
               Message   => "Le fait extrait doit être de type " &
                  "[" & Fait.Lire_Type'Image & "] mais on trouve " &
                  "[" & F.Lire_Type'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Fait_Booleen_T (F).Lire_Valeur = Fait.Lire_Valeur,
               Message   => "Le fait extrait doit avoir la valeur " &
                  "[" & Fait.Lire_Valeur'Image & "] mais on trouve " &
                  "[" & Fait_Booleen_T (F).Lire_Valeur'Image & "]"
            );
      end Bloc_Verification_Contenu;
   end Test_Ajouter_B_1;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_E_1
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      use type Fait_P.Nom_T;
      use type Fait_P.Type_De_Fait_T;

      Nom    : constant Nom_T    := Creer_Nom;
      Valeur : constant Entier_T :=
         Entier_Alea_P.Random (Gen => Generateur_Entier);

      Fait : constant Fait_Entier_T := Fait_P.Entier_P.Creer
         (
            Nom    => Nom,
            Valeur => Valeur
         );
   begin
      T.Base.Ajouter (Nouvel_Item => Fait);
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Length = 1,
            Message   => "La base de fait doit contenir 1 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Contient (Nom_Fait => Nom),
            Message   => "La base de fait doit contenir 1 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );
      Bloc_Verification_Contenu :
      declare
         F : constant Fait_P.Fait_Abstrait_T'Class :=
            T.Base.Trouver (Nom_Fait => Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => F.Lire_Nom = Fait.Lire_Nom,
               Message   => "La base de fait doit contenir " &
                  "[" & String (Nom) & "] mais on trouve " &
                  "[" & String (F.Lire_Nom) & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => F.Lire_Type = Fait.Lire_Type,
               Message   => "Le fait extrait doit être de type " &
                  "[" & Fait.Lire_Type'Image & "] mais on trouve " &
                  "[" & F.Lire_Type'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Fait_Entier_T (F).Lire_Valeur = Fait.Lire_Valeur,
               Message   => "Le fait extrait doit avoir la valeur " &
                  "[" & Fait.Lire_Valeur'Image & "] mais on trouve " &
                  "[" & Fait_Entier_T (F).Lire_Valeur'Image & "]"
            );
      end Bloc_Verification_Contenu;
   end Test_Ajouter_E_1;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_S_1
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      use type Fait_P.Nom_T;
      use type Fait_P.Type_De_Fait_T;
      use type Nom_Symbole_T;

      Nom    : constant Nom_T         := Creer_Nom;
      Valeur : constant Nom_Symbole_T := "nom symbole";

      Fait : constant Fait_Symbole_T := Fait_P.Symbolique_P.Creer
         (
            Nom    => Nom,
            Valeur => Valeur
         );
   begin
      T.Base.Ajouter (Nouvel_Item => Fait);
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Length = 1,
            Message   => "La base de fait doit contenir 1 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Base.Contient (Nom_Fait => Nom),
            Message   => "La base de fait doit contenir 1 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );
      Bloc_Verification_Contenu :
      declare
         F : constant Fait_P.Fait_Abstrait_T'Class :=
            T.Base.Trouver (Nom_Fait => Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => F.Lire_Nom = Fait.Lire_Nom,
               Message   => "La base de fait doit contenir " &
                  "[" & String (Nom) & "] mais on trouve " &
                  "[" & String (F.Lire_Nom) & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => F.Lire_Type = Fait.Lire_Type,
               Message   => "Le fait extrait doit être de type " &
                  "[" & Fait.Lire_Type'Image & "] mais on trouve " &
                  "[" & F.Lire_Type'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Fait_Symbole_T (F).Lire_Valeur = Fait.Lire_Valeur,
               Message   => "Le fait extrait doit avoir la valeur " &
                  "[" & String (Fait.Lire_Valeur) & "] mais on trouve " &
                  "[" & String (Fait_Symbole_T (F).Lire_Valeur) & "]"
            );
      end Bloc_Verification_Contenu;
   end Test_Ajouter_S_1;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Ajouter_Multiples
      (T : in out Test_Fixt_T)
   is
      use type Ada.Containers.Count_Type;

      use type Fait_P.Nom_T;
      use type Fait_P.Type_De_Fait_T;

      type Memoire_T is
         record
            Sorte : Fait_P.Type_De_Fait_T;
            Nom   : Nom_T (Fait_P.Taille_Nom_T);
            --  case Sorte is
            --     when Fait_P.Booleen_E =>
            --        Bool : Boolean;
            --     when Fait_P.Entier_E =>
            --        Entier : Fait_P.Entier_P.Entier_T;
            --     when Fait_P.Symbolique_P =>
            --        Symbol : Fait_P.Symbolique_P.Nom_Symbole_T;
            --  end case;
         end record;

      type ID_Fait_T is range 1 .. 10;

      type Faits_Genere_T is array (ID_Fait_T) of Memoire_T;

      F : Faits_Genere_T;
   begin
      Boucle_Remplissage_Base :
      for M : Memoire_T of F loop
         Bloc_Nom :
         declare
            N : constant Nom_T := Creer_Nom;
         begin
            M.Nom (N'Range) := N;
            M.Sorte := Sorte_Fait_Alea_P.Random (Gen => Generateur_Sorte_Fait);
         end Bloc_Nom;

         Bloc_Creer_Fait :
         declare
            Fait : constant Fait_P.Fait_Abstrait_T'Class :=
               (
                  case M.Sorte is
                     when Fait_P.Booleen_E =>
                        Fait_P.Booleen_P.Creer
                           (
                              Nom    => M.Nom,
                              Valeur => True
                           ),
                     when Fait_P.Entier_E =>
                        Fait_P.Entier_P.Creer
                           (
                              Nom    => M.Nom,
                              Valeur => 666
                           ),
                     when Fait_P.Symbole_E =>
                        Fait_P.Symbolique_P.Creer
                           (
                              Nom    => M.Nom,
                              Valeur => "un symbole"
                           )
               );
         begin
            T.Base.Ajouter (Nouvel_Item => Fait);
         end Bloc_Creer_Fait;
      end loop Boucle_Remplissage_Base;

      AUnit.Assertions.Assert
         (
            Condition => T.Base.Map_Faits.Length = 10,
            Message   => "La base de fait doit contenir 10 et pas " &
               "[" & T.Base.Map_Faits.Length'Image & "]"
         );

      Boucle_Verification_Contenu :
      for M : Memoire_T of F loop
         AUnit.Assertions.Assert
            (
               Condition => T.Base.Contient (Nom_Fait => M.Nom),
               Message   => "La base de fait doit contenir 1 et pas " &
                  "[" & T.Base.Map_Faits.Length'Image & "]"
            );
         Bloc_Verification_Contenu :
         declare
            Fait : constant Fait_P.Fait_Abstrait_T'Class :=
               T.Base.Trouver (Nom_Fait => M.Nom);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => M.Nom = Fait.Lire_Nom,
                  Message   => "La base de fait doit contenir " &
                     "[" & String (M.Nom) & "] mais on trouve " &
                     "[" & String (Fait.Lire_Nom) & "]"
               );
            AUnit.Assertions.Assert
               (
                  Condition => M.Sorte = Fait.Lire_Type,
                  Message   => "Le fait extrait doit être de type " &
                     "[" & M.Sorte'Image & "] mais on trouve " &
                     "[" & Fait.Lire_Type'Image & "]"
               );
         end Bloc_Verification_Contenu;
      end loop Boucle_Verification_Contenu;
   end Test_Ajouter_Multiples;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer_Nom
      return Nom_T
   is
      Taille : constant Fait_P.Taille_Nom_T :=
         Taille_Nom_Alea_P.Random (Gen => Generateur_Taille);

      Debut : constant Fait_P.Taille_Nom_T := Fait_P.Taille_Nom_T'First;
      Fin   : constant Fait_P.Taille_Nom_T := Debut + Taille - 1;

      subtype Taille_T is Fait_P.Taille_Nom_T range Debut .. Fin;

      Nom : Nom_T (Taille_T);
   begin
      for I in Taille_T loop
         Nom (I) := Lettre_Alea_P.Random (Gen => Generateur_Lettre);
      end loop;

      return Nom;
   end Creer_Nom;
   ---------------------------------------------------------------------------

begin

   Entier_Alea_P.Reset (Gen => Generateur_Entier);
   Lettre_Alea_P.Reset (Gen => Generateur_Lettre);
   Taille_Nom_Alea_P.Reset (Gen => Generateur_Taille);
   Sorte_Fait_Alea_P.Reset (Gen => Generateur_Sorte_Fait);

end Sys_Exp_P.Base_Faits_P.Test_P;
