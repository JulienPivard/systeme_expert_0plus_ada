package body Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Lire_Sorte
      (This : in     Jeton_T)
      return Sorte_T
   is
   begin
      return This.Sorte;
   end Lire_Sorte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Representation
      (This : in     Jeton_T)
      return String
   is
      L : constant Integer := This.Representation.Element'Length;
      D : constant Integer := This.Representation.Element'First;

      --  Fin de la chaine.
      F_C : constant Integer :=
         (if L > Taille_Max_Nom then Taille_Max_Nom else L);
      --  Fin de la représentation.
      F_R : constant Integer :=
         D + (if L > Taille_Max_Nom then Taille_Max_Nom else L) - 1;

      --  On copie le contenu dans une autre chaine dont les
      --  intervalles sont compatible avec la taille max des noms.
      C : constant String (1 .. F_C) :=
         This.Representation.Element (D .. F_R);
   begin
      return C;
   end Lire_Representation;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Representation
      (This : in     Jeton_T)
      return Nom_T
   is
   begin
      return Nom_T (String'(This.Lire_Representation));
   end Lire_Representation;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Representation
      (This : in     Jeton_T)
      return Nom_Symbole_T
   is
   begin
      return Nom_Symbole_T (String'(This.Lire_Representation));
   end Lire_Representation;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Parenthese_Ouvrante
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Parenthese_Ouvrante_E;
   end Est_Parenthese_Ouvrante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Parenthese_Fermante
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Parenthese_Fermante_E;
   end Est_Parenthese_Fermante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Superieur
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Superieur_E;
   end Est_Superieur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Inferieur
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Inferieur_E;
   end Est_Inferieur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Operateur_Plus
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Operateur_Plus_E;
   end Est_Operateur_Plus;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Operateur_Moins
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Operateur_Moins_E;
   end Est_Operateur_Moins;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Operateur_Multiplier
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Operateur_Mul_E;
   end Est_Operateur_Multiplier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Operateur_Diviser
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Operateur_Div_E;
   end Est_Operateur_Diviser;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Egal
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Egal_E;
   end Est_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Fin_Expression
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Fin_Expression_E;
   end Est_Fin_Expression;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Identificateur
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Identificateur_E;
   end Est_Identificateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Si
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Si_E;
   end Est_Si;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Non
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Non_E;
   end Est_Non;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Et
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Et_E;
   end Est_Et;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Alors
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Alors_E;
   end Est_Alors;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Separateur
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Separateur_E;
   end Est_Separateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Inconnu
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Inconnu_E;
   end Est_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Fin_Fichier
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Fin_Fichier_E;
   end Est_Fin_Fichier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Entier
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Entier_E;
   end Est_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Superieur_Egal
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Superieur_Egal_E;
   end Est_Superieur_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Inferieur_Egal
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Inferieur_Egal_E;
   end Est_Inferieur_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Different
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Different_E;
   end Est_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Fait_Booleen
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Fait_Booleen_E;
   end Est_Fait_Booleen;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Fait_Symbolique
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Fait_Symbolique_E;
   end Est_Fait_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Fait_Entier
      (This : in     Jeton_T)
      return Boolean
   is
   begin
      return This.Sorte = Fait_Entier_E;
   end Est_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Un_Signe_De_Comparaison_Symbolique
      (This : in     Jeton_T)
      return Boolean
   is
      subtype Signe_De_Comparaison_T is Sorte_T
         with Static_Predicate =>
            Signe_De_Comparaison_T in Egal_E | Different_E;
   begin
      return This.Sorte in Signe_De_Comparaison_T;
   end Est_Un_Signe_De_Comparaison_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Est_Un_Signe_De_Comparaison_Entiere
      (This : in     Jeton_T)
      return Boolean
   is
      subtype Signe_De_Comparaison_T is Sorte_T
         with Static_Predicate => Signe_De_Comparaison_T in
            Egal_E           | Different_E |
            Inferieur_E      | Superieur_E |
            Inferieur_Egal_E | Superieur_Egal_E;
   begin
      return This.Sorte in Signe_De_Comparaison_T;
   end Est_Un_Signe_De_Comparaison_Entiere;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P;
