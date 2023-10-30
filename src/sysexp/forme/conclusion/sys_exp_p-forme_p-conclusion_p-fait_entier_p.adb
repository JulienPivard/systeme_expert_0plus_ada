package body Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (
         Nom      : in     Nom_T;
         Nom_Fait : in     Nom_T
      )
      return Conclusion_Fait_T
   is
   begin
      return Conclusion_Fait_T'
         (
            Nom      => Nom_P.To_Holder (New_Item => Nom),
            Nom_Fait => Nom_P.To_Holder (New_Item => Nom_Fait)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Conclusion_Fait_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is
   begin
      Visiteur.Visiter (Forme => This);
   end Accepte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Nom_Fait
      (This : in     Conclusion_Fait_T)
      return Nom_T
   is
   begin
      return This.Nom_Fait.Element;
   end Lire_Nom_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P;
