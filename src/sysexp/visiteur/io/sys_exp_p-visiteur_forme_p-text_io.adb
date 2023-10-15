with Ada.Tags;
with Ada.Text_IO;

with Sys_Exp_P.Base_Faits_P.Text_IO;

package body Sys_Exp_P.Visiteur_Forme_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Visiteur_Forme_Abstrait_T'Class)
   is
   begin
      Ada.Text_IO.Put_Line
         (
            Item => "La prémisse a été vérifiée " &
               "[" & Item.Premisse_A_Ete_Verifiee'Image & "]"
         );
      Ada.Text_IO.Put_Line
         (
            Item => "La conclusion a été déclenchée " &
               "[" & Item.Conclusion_A_Ete_Declenchee'Image & "]"
         );
      Ada.Text_IO.Put (Item => "Erreur => ");
      case Item.Code_Erreur is
         when Tout_Va_Bien_E =>
            Ada.Text_IO.Put_Line (Item => "Pas d'erreur");
         when Div_Par_Zero_E =>
            Ada.Text_IO.Put_Line (Item => "Division par zéro.");
            Ada.Text_IO.Put_Line (Item => "[" & Item.Message_D_Erreur & "]");
         when Incoherence_Fait_E =>
            Ada.Text_IO.Put_Line (Item => "La base est incohérente.");
            Ada.Text_IO.Put_Line (Item => "[" & Item.Message_D_Erreur & "]");
         when Fait_Entier_Inconnu_E =>
            Ada.Text_IO.Put_Line (Item => "Le fait entier est inconnu.");
            Ada.Text_IO.Put_Line (Item => "[" & Item.Message_D_Erreur & "]");
         when Fait_Expression_Inconnu_E =>
            Ada.Text_IO.Put_Line
               (Item => "Le fait entier dans l'expression est inconnu.");
            Ada.Text_IO.Put_Line (Item => "[" & Item.Message_D_Erreur & "]");
         when Fait_Symbolique_Inconnu_E =>
            Ada.Text_IO.Put_Line (Item => "Le fait symbolique est inconnu.");
            Ada.Text_IO.Put_Line (Item => "[" & Item.Message_D_Erreur & "]");
      end case;

      Ada.Text_IO.Put_Line (Item => "Contenu de la base");
      Sys_Exp_P.Base_Faits_P.Text_IO.Put_Line (Item => Item.Base);

      Ada.Text_IO.Put_Line
         (Item => "[" & Ada.Tags.Expanded_Name (T => Item'Tag) & "]");
      --  Ada.Text_IO.Put_Line
      --     (Item => "[" & Ada.Tags.External_Tag  (T => Item'Tag) & "]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Text_IO;
