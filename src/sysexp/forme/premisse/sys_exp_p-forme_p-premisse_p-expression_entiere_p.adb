package body Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Entier_A;
         Expression  : in     Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
      )
      return Premisse_T
   is
   begin
      return Premisse_T'
         (
            Nom         => Nom_Holder_P.To_Holder (New_Item => Nom),
            Comparateur => Comparateur,
            Expression  => Valeur_R.To_Holder (New_Item => Expression)
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
   not overriding
   function Lire_Valeur
      (
         This : in     Premisse_T;
         Base : in     Sys_Exp_P.Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T
   is
   begin
      return This.Expression.Element.Interpreter (Base => Base);
   end Lire_Valeur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;
