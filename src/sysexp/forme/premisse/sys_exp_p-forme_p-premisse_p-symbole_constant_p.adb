package body Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Nom_Symbole_T;
         Nom_Symbole : in     Nom_Symbole_T
      )
      return Premisse_T
   is
   begin
      return Premisse_T'
         (
            Nom         => Nom_P.To_Holder         (New_Item => Nom),
            Comparateur => Comparateur,
            Nom_Symbole => Nom_Symbole_P.To_Holder (New_Item => Nom_Symbole)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Premisse_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is
   begin
      Visiteur.Visiter (Forme => This);
   end Accepte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   not overriding
   function Comparer
      (
         This   : in     Premisse_T;
         Gauche : in     Nom_Symbole_T;
         Droite : in     Nom_Symbole_T
      )
      return Boolean
   is
   begin
      return This.Comparateur
         (
            Gauche => Gauche,
            Droite => Droite
         );
   end Comparer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   not overriding
   function Lire_Nom_Symbole
      (This : in     Premisse_T)
      return Nom_Symbole_T
   is
   begin
      return This.Nom_Symbole.Element;
   end Lire_Nom_Symbole;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P;
