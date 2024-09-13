package body Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom      : in     Nom_T;
         Nom_Fait : in     Nom_T
      )
      return Conclusion_T
   is
   begin
      return Conclusion_T'
         (
            Nom      => Nom_Holder_P.To_Holder (New_Item => Nom),
            Nom_Fait => Nom_Holder_P.To_Holder (New_Item => Nom_Fait)
         );
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
   not overriding
   function Lire_Nom_Fait
      (This : in     Conclusion_T)
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
