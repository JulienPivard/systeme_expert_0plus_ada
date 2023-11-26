package body Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom        : in     Nom_T;
         Expression : in     Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class
      )
      return Conclusion_T
   is
   begin
      return Conclusion_T'
         (
            Nom        => Nom_P.To_Holder              (New_Item => Nom),
            Expression => Valeur_Abstraite_P.To_Holder (New_Item => Expression)
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
   function Lire_Valeur
      (
         This : in     Conclusion_T;
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

end Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
