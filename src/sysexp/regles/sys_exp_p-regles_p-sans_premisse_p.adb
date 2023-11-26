with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;

package body Sys_Exp_P.Regles_P.Sans_Premisse_P
   with Spark_Mode => Off
is

   package Declencheur_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         ID_Regle   : in     ID_Regle_T;
         Conclusion : in     Conclusion_R.Conclusion_Abstraite_T'Class
      )
      return Regle_T
   is
   begin
      return Regle_T'
         (
            ID_Regle         => ID_Regle,
            Conclusion       =>
               Conclusion_Holder_P.To_Holder (New_Item => Conclusion),
            Regle_Declenchee => False,
            Successeur       => Regle_Holder_P.Empty_Holder
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Verifier_Premisse
      (
         This : in     Regle_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean
   is
      pragma Unreferenced (This);
      pragma Unreferenced (Base);
   begin
      return True;
   end Verifier_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Creer_Visiteur
      (
         This : in     Regle_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class
   is
      pragma Unreferenced (This);
   begin
      return Declencheur_R.Creer (Base => Base'Unchecked_Access);
   end Creer_Visiteur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Regles_P.Sans_Premisse_P;
