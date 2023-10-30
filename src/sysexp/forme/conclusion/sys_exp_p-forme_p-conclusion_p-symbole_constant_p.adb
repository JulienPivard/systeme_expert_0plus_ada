package body Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (
         Nom         : in     Nom_T;
         Nom_Symbole : in     Nom_Symbole_T
      )
      return Conclusion_Symbolique_T
   is
   begin
      return Conclusion_Symbolique_T'
         (
            Nom         => Nom_P.To_Holder         (New_Item => Nom),
            Nom_Symbole => Nom_Symbole_P.To_Holder (New_Item => Nom_Symbole)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Conclusion_Symbolique_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is
   begin
      Visiteur.Visiter (Forme => This);
   end Accepte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Nom_Symbole
      (This : in     Conclusion_Symbolique_T)
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
