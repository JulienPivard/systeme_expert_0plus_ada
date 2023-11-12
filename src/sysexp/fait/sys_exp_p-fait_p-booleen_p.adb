package body Sys_Exp_P.Fait_P.Booleen_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom    : in     Nom_T;
         Valeur : in     Boolean
      )
      return Fait_Booleen_T
   is
      Fait : Fait_Booleen_T;
   begin
      Fait.Modifier_Nom (Nom => Nom);
      Fait.Valeur := Valeur;

      return Fait;
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Lire_Type
      (This : in     Fait_Booleen_T)
      return Type_De_Fait_T
   is
      pragma Unreferenced (This);
   begin
      return Booleen_E;
   end Lire_Type;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   not overriding
   function Lire_Valeur
      (This : in     Fait_Booleen_T)
      return Boolean
   is
   begin
      return This.Valeur;
   end Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Booleen_P;
