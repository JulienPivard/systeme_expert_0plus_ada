package body Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Nom_Symbole : in     Nom_Symbole_T
      )
      return Conclusion_T
   is
   begin
      return Conclusion_T'
         (
            Nom         => Nom_Holder_P.To_Holder  (New_Item => Nom),
            Nom_Symbole => Nom_Symbole_R.To_Holder (New_Item => Nom_Symbole)
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
   function Lire_Nom_Symbole
      (This : in     Conclusion_T)
      return Nom_Symbole_T
   is
   begin
      return This.Nom_Symbole.Element;
   end Lire_Nom_Symbole;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P;
