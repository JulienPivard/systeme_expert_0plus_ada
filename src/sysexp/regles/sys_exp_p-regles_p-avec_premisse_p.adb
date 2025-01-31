package body Sys_Exp_P.Regles_P.Avec_Premisse_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         ID_Regle   : in     ID_Regle_T;
         Premisse   : in     Premisse_R.Premisse_Abstraite_T'Class;
         Conclusion : in     Conclusion_R.Conclusion_Abstraite_T'Class;
         Fabrique   : in     Fabrique_R.Fabrique_Interface_T'Class
      )
      return Regle_T
   is
      Liste : Liste_Premisses_T;
   begin
      Liste.Append (New_Item => Premisse);

      return Regle_T'
         (
            ID_Regle         => ID_Regle,
            Premisses        => Liste,
            Regle_Declenchee => False,
            Conclusion       =>
               Conclusion_Holder_P.To_Holder (New_Item => Conclusion),
            Fabrique         =>
               Fabrique_Holder_P.To_Holder   (New_Item => Fabrique),
            Successeur       => Regle_Holder_P.Empty_Holder
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Verifier_Premisse
      (
         This : in     Regle_T;
         Base : in     Base_Faits_P.Base_De_Faits_A
      )
      return Boolean
   is
      Premisses_Verifiee : Boolean := True;
   begin
      B_Visiter :
      for E : Premisse_R.Premisse_Abstraite_T'Class of This.Premisses loop
         Bloc_Visiter :
         declare
            Visiteur : Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class :=
               This.Creer_Visiteur (Base => Base);
         begin
            E.Accepte (Visiteur => Visiteur);
            Verifier_Flag_Erreur_Visiteur
               (
                  Regle    => This,
                  Visiteur => Visiteur
               );
            Premisses_Verifiee := Premisses_Verifiee and then
               Visiteur.Au_Moins_Une_Premisse_Verifiee;
         end Bloc_Visiter;

         exit B_Visiter when not Premisses_Verifiee;
      end loop B_Visiter;

      return Premisses_Verifiee;
   end Verifier_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Creer_Visiteur
      (
         This : in     Regle_T;
         Base : in     Base_Faits_P.Base_De_Faits_A
      )
      return Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class
   is
   begin
      return This.Fabrique.Element.Fabriquer_Visiteur (Base => Base);
   end Creer_Visiteur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Ajouter
      (
         This     : in out Regle_T;
         Premisse : in     Premisse_R.Premisse_Abstraite_T'Class
      )
   is
   begin
      This.Premisses.Append (New_Item => Premisse);
   end Ajouter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Regles_P.Avec_Premisse_P;
