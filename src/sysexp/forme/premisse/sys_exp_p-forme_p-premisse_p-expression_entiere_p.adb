package body Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (
         Nom         : in     Nom_T;
         Comparateur : in     Comparateur_Entier_T;
         Expression  : in     Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
      )
      return Premisse_Expression_T
   is
   begin
      return Premisse_Expression_T'
         (
            Nom         => Nom_P.To_Holder (New_Item => Nom),
            Comparateur => Comparateur,
            Expression  =>
               Valeur_Abstraite_P.To_Holder (New_Item => Expression)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Accepte
      (
         This     : in     Premisse_Expression_T;
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
         This   : in     Premisse_Expression_T;
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
   function Lire_Valeur
      (
         This : in     Premisse_Expression_T;
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
