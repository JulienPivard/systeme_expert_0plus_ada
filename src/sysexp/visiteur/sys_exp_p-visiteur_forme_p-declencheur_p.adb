package body Sys_Exp_P.Visiteur_Forme_P.Declencheur_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_R.Bool_False_P.Conclusion_False_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_R.Bool_True_P.Conclusion_True_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Expr_Entiere_R.Conclusion_Expression_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_R.Fait_Entier_P.Conclusion_Fait_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Symbole_Constant_R.Conclusion_Symbolique_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_R.Symbole_Fait_P.Conclusion_Symbolique_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_R.Bool_False_P.Premisse_False_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_R.Bool_True_P.Premisse_True_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_R.Expression_Entiere_P.Premisse_Expression_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_R.Fait_Entier_P.Premisse_Fait_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_R.Symbole_Constant_P.Premisse_Symbolique_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_R.Symbole_Fait_P.Premisse_Symbolique_T
      )
   is
   begin
      null;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;
