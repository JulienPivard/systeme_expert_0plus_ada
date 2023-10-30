package body Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (Nom : in     Nom_T)
      return Conclusion_False_T
   is
   begin
      return Conclusion_False_T'(Nom => Nom_P.To_Holder (New_Item => Nom));
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Conclusion_False_T;
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

end Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;