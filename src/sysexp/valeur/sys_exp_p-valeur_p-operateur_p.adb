package body Sys_Exp_P.Valeur_P.Operateur_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Lire_Element_Gauche
      (This : in     Operateur_Abstrait_T'Class)
      return Valeur_Abstraite_T'Class
   is
   begin
      return This.Gauche.Element;
   end Lire_Element_Gauche;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Element_Droite
      (This : in     Operateur_Abstrait_T'Class)
      return Valeur_Abstraite_T'Class
   is
   begin
      return This.Droite.Element;
   end Lire_Element_Droite;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Operateur_P;
