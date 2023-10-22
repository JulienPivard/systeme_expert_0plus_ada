package body Sys_Exp_P.Regles_P.Sans_Premisse_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
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
         Base : in     Accesseur_Base_T
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
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Regles_P.Sans_Premisse_P;
