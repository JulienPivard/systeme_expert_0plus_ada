package body Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      return Fabrique_T
   is
   begin
      return Fabrique_T'(null record);
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Fabriquer_Visiteur
      (This : in     Fabrique_T)
      return Visiteur_Forme_Abstrait_T'Class
   is
      pragma Unreferenced (This);
   begin
      return Creer;
   end Fabriquer_Visiteur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Fabrique_P;
