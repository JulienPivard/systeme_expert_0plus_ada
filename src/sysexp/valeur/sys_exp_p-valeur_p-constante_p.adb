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
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Constante_P;
