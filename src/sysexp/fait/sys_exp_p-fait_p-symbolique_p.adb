package body Sys_Exp_P.Fait_P.Symbolique_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (
         Nom    : in     Nom_T;
         Valeur : in     Nom_Symbole_T
      )
      return Fait_Symbolique_T
   is
      Fait : Fait_Symbolique_T;
   begin
      Fait.Modifier_Nom (Nom => Nom);
      Fait.Symbole := Symbole_P.To_Holder (New_Item => Valeur);

      return Fait;
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Lire_Type
      (This : in     Fait_Symbolique_T)
      return Type_De_Fait_T
   is
      pragma Unreferenced (This);
   begin
      return Symbole_E;
   end Lire_Type;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Valeur
      (This : in     Fait_Symbolique_T)
      return Nom_Symbole_T
   is
   begin
      return This.Symbole.Element;
   end Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Symbolique_P;
