package body Sys_Exp_P.Regles_P.Sans_Premisse_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         ID_Regle   : in     ID_Regle_T;
         Conclusion : in     Conclusion_R.Conclusion_Abstraite_T'Class;
         Fabrique   : in     Fabrique_R.Fabrique_Interface_T'Class
      )
      return Regle_T
   is
   begin
      return Regle_T'
         (
            ID_Regle         => ID_Regle,
            Regle_Declenchee => False,
            Conclusion       =>
               Conclusion_Holder_P.To_Holder (New_Item => Conclusion),
            Fabrique         =>
               Fabrique_Holder_P.To_Holder   (New_Item => Fabrique),
            Successeur       => Regle_Holder_P.Empty_Holder
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Verifier_Premisse
      (
         This : in     Regle_T;
         Base : aliased in out Base_Faits_P.Base_De_Faits_T
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
         Base : aliased in out Base_Faits_P.Base_De_Faits_T
      )
      return Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class
   is
   begin
      return This.Fabrique.Element.Fabriquer_Visiteur (Base => Base'Access);
   end Creer_Visiteur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Regles_P.Sans_Premisse_P;
