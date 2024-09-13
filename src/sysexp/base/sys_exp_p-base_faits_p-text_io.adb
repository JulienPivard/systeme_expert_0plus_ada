with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO;

with Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
with Sys_Exp_P.Fait_P.Entier_P.Text_IO;
with Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;

package body Sys_Exp_P.Base_Faits_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Base_De_Faits_T)
   is
   begin
      for E : Fait_P.Fait_Abstrait_T'Class of Item.Map_Faits loop
         Ada.Text_IO.Put
            (Item => "Type de fait [" & E.Lire_Type'Image & "] ");

         case E.Lire_Type is
            when Booleen_E =>
               Bloc_Afficher_Booleen :
               declare
                  F : constant Fait_P.Booleen_P.Fait_Booleen_T :=
                     Fait_P.Booleen_P.Fait_Booleen_T (E);
               begin
                  Fait_P.Booleen_P.Text_IO.Put_Line (Item => F);
               end Bloc_Afficher_Booleen;

            when Entier_E =>
               Bloc_Afficher_Entier :
               declare
                  F : constant Fait_P.Entier_P.Fait_Entier_T :=
                     Fait_P.Entier_P.Fait_Entier_T (E);
               begin
                  Fait_P.Entier_P.Text_IO.Put_Line (Item => F);
               end Bloc_Afficher_Entier;

            when Symbolique_E =>
               Bloc_Afficher_Symbole :
               declare
                  F : constant Fait_P.Symbolique_P.Fait_Symbolique_T :=
                     Fait_P.Symbolique_P.Fait_Symbolique_T (E);
               begin
                  Fait_P.Symbolique_P.Text_IO.Put_Line (Item => F);
               end Bloc_Afficher_Symbole;
         end case;
      end loop;
      Ada.Text_IO.New_Line (Spacing => 1);
   end Put_Line;
   ---------------------------------------------------------------------------

   package W_W_IO_R renames Ada.Wide_Wide_Text_IO;
   --  @private Package interne.

   ---------------------------------------------------------------------------
   procedure Afficher
      (Item : in     Base_De_Faits_T)
   is
   begin
      for E : Fait_P.Fait_Abstrait_T'Class of Item.Map_Faits loop
         Bloc_Afficher_Type :
         declare
            Nom : constant String := E.Lire_Type'Image;

            subtype IT_Nom_Sans_E_T is Integer range Nom'First .. Nom'Last - 2;
            --  On retire le _E à la fin des noms des types
            --  de variables.
         begin
            Ada.Text_IO.Put_Line
               (Item => "[" & Nom (IT_Nom_Sans_E_T) & "]");
         end Bloc_Afficher_Type;
         W_W_IO_R.Put (Item => "└────────────  ");

         case E.Lire_Type is
            when Booleen_E =>
               Bloc_Afficher_Booleen :
               declare
                  F : constant Fait_P.Booleen_P.Fait_Booleen_T :=
                     Fait_P.Booleen_P.Fait_Booleen_T (E);
               begin
                  if not F.Lire_Valeur then
                     Ada.Text_IO.Put (Item => "Non ");
                  end if;
                  Ada.Text_IO.Put_Line
                     (Item => "[" & String (F.Lire_Nom) & "]");
               end Bloc_Afficher_Booleen;

            when Entier_E =>
               Bloc_Afficher_Entier :
               declare
                  F : constant Fait_P.Entier_P.Fait_Entier_T :=
                     Fait_P.Entier_P.Fait_Entier_T (E);
               begin
                  Ada.Text_IO.Put
                     (Item => "[" & String (F.Lire_Nom) & "] = ");
                  Ada.Text_IO.Put_Line
                     (Item => "[" & F.Lire_Valeur'Image & "]");
               end Bloc_Afficher_Entier;

            when Symbolique_E =>
               Bloc_Afficher_Symbole :
               declare
                  F : constant Fait_P.Symbolique_P.Fait_Symbolique_T :=
                     Fait_P.Symbolique_P.Fait_Symbolique_T (E);
               begin
                  Ada.Text_IO.Put
                     (Item => "[" & String (F.Lire_Nom) & "] = ");
                  Ada.Text_IO.Put_Line
                     (Item => "[" & String (F.Lire_Valeur) & "]");
               end Bloc_Afficher_Symbole;
         end case;
      end loop;
      Ada.Text_IO.New_Line (Spacing => 1);
   end Afficher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Base_Faits_P.Text_IO;
