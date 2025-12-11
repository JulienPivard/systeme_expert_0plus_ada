package body Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (Nom : in     Nom_T)
      return Premisse_T
   is
   begin
      return Premisse_T'(Nom => Nom_Holder_P.To_Holder (New_Item => Nom));
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Premisse_T;
         Base     : in     Base_Faits_P.Base_De_Faits_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is
   begin
      Visiteur.Visiter
         (
            Forme => This,
            Base  => Base
         );
   end Accepte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Image
      (This : in     Premisse_T)
      return String
   is
      pragma Unreferenced (This);
   begin
      return "Attendu [TRUE]";
   end Image;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;
