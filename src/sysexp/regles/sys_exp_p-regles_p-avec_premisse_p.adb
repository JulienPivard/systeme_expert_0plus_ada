with Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;

package body Sys_Exp_P.Regles_P.Avec_Premisse_P
   with Spark_Mode => Off
is

   package Declencheur_R renames Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         ID_Regle   : in     ID_Regle_T;
         Premisse   : in     Premisse_R.Premisse_Abstraite_T'Class;
         Conclusion : in     Conclusion_R.Conclusion_Abstraite_T'Class
      )
      return Regle_T
   is
      Liste : Liste_Premisses_T;
   begin
      Liste.Append (New_Item => Premisse);

      return Regle_T'
         (
            ID_Regle         => ID_Regle,
            Conclusion       =>
               Conclusion_Holder_P.To_Holder (New_Item => Conclusion),
            Premisses        => Liste,
            Regle_Declenchee => False,
            Successeur       => Regle_Holder_P.Empty_Holder
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Verifier_Premisse
      (
         This : in     Regle_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean
   is
      Premisses_Verifiee : Boolean := True;
   begin
      B_Visiter :
      for E : Premisse_R.Premisse_Abstraite_T'Class of This.Premisses loop
         Bloc_Visiter :
         declare
            Visiteur : Declencheur_R.Visiteur_T :=
               Declencheur_R.Creer (Base => Base'Unchecked_Access);
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
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class
   is
      pragma Unreferenced (This);
   begin
      return Declencheur_R.Creer (Base => Base'Unchecked_Access);
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
