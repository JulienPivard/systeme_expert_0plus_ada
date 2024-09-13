package body Sys_Exp_P.Fait_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Lire_Nom
      (This : in     Fait_Abstrait_T)
      return Nom_T
   is
   begin
      return This.Nom.Element;
   end Lire_Nom;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Modifier_Nom
      (
         This : in out Fait_Abstrait_T;
         Nom  : in     Nom_T
      )
   is
   begin
      This.Nom := Nom_Holder_P.To_Holder (New_Item => Nom);
   end Modifier_Nom;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function "="
      (
         Gauche : in     Fait_Abstrait_T'Class;
         Droite : in     Fait_Abstrait_T'Class
      )
      return Boolean
   is
   begin
      return Gauche.Nom.Element = Droite.Nom.Element;
   end "=";
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P;
