package body Sys_Exp_P.Fait_P.Entier_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom    : in     Nom_T;
         Valeur : in     Entier_T
      )
      return Fait_Entier_T
   is
      Fait : Fait_Entier_T;
   begin
      Fait.Modifier_Nom (Nom => Nom);
      Fait.Valeur := Valeur;

      return Fait;
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Lire_Type
      (This : in     Fait_Entier_T)
      return Type_De_Fait_T
   is
      pragma Unreferenced (This);
   begin
      return Entier_E;
   end Lire_Type;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Image
      (This : in     Fait_Entier_T)
      return String
   is
      V : constant Entier_T := This.Valeur;

      V_Str : constant String := V'Image;

      Debut : constant Integer := V_Str'First + (if V < 0 then 0 else 1);
      Fin   : constant Integer := V_Str'Last;
   begin
      return V_Str (Debut .. Fin);
   end Image;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   not overriding
   function Lire_Valeur
      (This : in     Fait_Entier_T)
      return Entier_T
   is
   begin
      return This.Valeur;
   end Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Entier_P;
