package body Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Entier_T;
         Nom_Fait    : in     Nom_T
      )
      return Premisse_Fait_T
   is
   begin
      return Premisse_Fait_T'
         (
            Nom         => Nom_P.To_Holder (New_Item => Nom),
            Comparateur => Comparateur,
            Nom_Fait    => Nom_P.To_Holder (New_Item => Nom_Fait)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Premisse_Fait_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is
   begin
      Visiteur.Visiter (Forme => This);
   end Accepte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Comparer
      (
         This   : in     Premisse_Fait_T;
         Gauche : in     Entier_T;
         Droite : in     Entier_T
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
   function Lire_Nom_Fait
      (This : in     Premisse_Fait_T)
      return Nom_T
   is
   begin
      return This.Nom_Fait.Element;
   end Lire_Nom_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;
