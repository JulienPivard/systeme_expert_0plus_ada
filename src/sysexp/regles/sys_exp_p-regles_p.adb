with Ada.Text_IO;

package body Sys_Exp_P.Regles_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   procedure Ajouter
      (
         This       : in out Regle_Abstraite_T;
         Successeur : in     Regle_Interface_T'Class
      )
   is
   begin
      This.Successeur := Regle_Holder_P.To_Holder (New_Item => Successeur);
   end Ajouter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Iterer
      (
         This : in out Regle_Abstraite_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean
   is
      Une_Autre_Conclusion_Declenchee : constant Boolean :=
         (
            if This.Possede_Successeur then
               This.Successeur.Reference.Iterer (Base => Base)
            else
               False
         );
      La_Regle_A_Ete_Declenchee : constant Boolean :=
         (
            if This.Regle_Declenchee then
               False
            else
               This.Declencher (Base => Base)
         );
   begin
      return La_Regle_A_Ete_Declenchee or else Une_Autre_Conclusion_Declenchee;
   end Iterer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Declencher
      (
         This : in out Regle_Abstraite_T'Class;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean
   is
   begin
      if This.Verifier_Premisse (Base => Base) then
         Bloc_Visiter :
         declare
            Visiteur : Visiteur_R.Visiteur_Forme_Abstrait_T'Class :=
               This.Creer_Visiteur;
         begin
            This.Conclusion.Element.Accepte
               (
                  Base     => Base,
                  Visiteur => Visiteur
               );
            This.Regle_Declenchee :=
               Visiteur.Au_Moins_Une_Conclusion_Declenchee;
            Verifier_Flag_Erreur_Visiteur
               (
                  Regle    => This,
                  Visiteur => Visiteur
               );
         end Bloc_Visiter;
      end if;

      return This.Regle_Declenchee;
   end Declencher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Verifier_Flag_Erreur_Visiteur
      (
         Regle    : in     Regle_Abstraite_T'Class;
         Visiteur : in     Visiteur_R.Visiteur_Forme_Abstrait_T'Class
      )
   is
      use type Visiteur_Forme_P.Code_Erreur_T;
   begin
      if Visiteur.Lire_Code_Erreur = Visiteur_Forme_P.Div_Par_Zero_E then
         Ada.Text_IO.Put_Line
            (
               Item => "Erreur [" & Visiteur.Lire_Code_Erreur'Image & "] " &
                  "avec la regle [" & Regle.ID_Regle'Image & "] " &
                  "Message [" & Visiteur.Lire_Message_Erreur & "]"
            );
         raise E_Division_Par_Zero;
      end if;
      if Visiteur.Lire_Code_Erreur = Visiteur_Forme_P.Incoherence_Fait_E then
         Ada.Text_IO.Put_Line
            (
               Item => "Erreur [" & Visiteur.Lire_Code_Erreur'Image & "] " &
                  "avec la regle [" & Regle.ID_Regle'Image & "] " &
                  "Message [" & Visiteur.Lire_Message_Erreur & "]"
            );
         raise E_Fait_Deja_Present;
      end if;
   end Verifier_Flag_Erreur_Visiteur;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Regles_P;
