package body Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (Nom : in     Nom_T)
      return Conclusion_T
   is
   begin
      return Conclusion_T'(Nom => Nom_Holder_P.To_Holder (New_Item => Nom));
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Conclusion_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is
   begin
      Visiteur.Visiter (Forme => This);
   end Accepte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
