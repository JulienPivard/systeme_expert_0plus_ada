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
   begin
      return Jeton_T'
         (
            Sorte          => Sorte,
            Representation => String_Holder_P.To_Holder
               (New_Item => Representation)
         );
   end Creer;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P;
