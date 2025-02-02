package body Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Faire_Entier
      (Representation : in     String)
      return Jeton_T
   is
   begin
      return Creer
         (
            Sorte          => Entier_E,
            Representation => Representation
         );
   end Faire_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Identificateur
      (Representation : in     String)
      return Jeton_T
   is
   begin
      return Creer
         (
            Sorte          => Identificateur_E,
            Representation => Representation
         );
   end Faire_Identificateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Inconnu
      (Representation : in     String)
      return Jeton_T
   is
   begin
      return Creer
         (
            Sorte          => Inconnu_E,
            Representation => Representation
         );
   end Faire_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer
      (
         Sorte          : in     Sorte_T;
         Representation : in     String
      )
      return Jeton_T
   is
      D : constant Integer := Representation'First;
      L : constant Integer := Representation'Length;

      Taille : constant Integer :=
         (if L > Taille_Max_Nom then Taille_Max_Nom else L);

      --  Fin de la chaine.
      F_C : constant NB_T := NB_T (Taille);
      --  Fin de la représentation.
      F_R : constant Integer := D + Taille - 1;

      R : constant String_T (1 .. F_C) :=
         String_T (Representation (D .. F_R));
   begin
      return Jeton_T'
         (
            Sorte          => Sorte,
            Representation => String_Holder_P.To_Holder (New_Item => R)
         );
   end Creer;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P;
