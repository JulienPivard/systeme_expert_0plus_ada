package body Sys_Exp_P.Valeur_P.Constante_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (Valeur : in     Entier_T)
      return Valeur_Constante_T
   is
   begin
      return Valeur_Constante_T'(Valeur => Valeur);
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Interpreter
      (
         This : in     Valeur_Constante_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T
   is
      pragma Unreferenced (Base);
      --  La base n'est pas utilisé car la feuille constante
      --  contient déjà sa valeur concrète.
   begin
      return This.Valeur;
   end Interpreter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Image
      (This : in     Valeur_Constante_T)
      return String
   is
      V : constant Entier_T := This.Valeur;

      V_Str : constant String := V'Image;

      Debut : constant Integer := V_Str'First + (if V < 0 then 0 else 1);
      Fin   : constant Integer := V_Str'Last;
   begin
      return "Constante [" & V_Str (Debut .. Fin) & "]";
   end Image;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Constante_P;
