with Ada.Text_IO;
with Ada.Wide_Wide_Text_IO;

with Sys_Exp_P.Fait_P.Text_IO;

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
         Sys_Exp_P.Fait_P.Text_IO.Put_Line (Item => E);
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
      type Sorte_De_Valeur_T is (Vrais_E, Faux_E, Autre_E);

      Vrais_Str : constant String := True'Image;
      Faux_Str  : constant String := False'Image;
   begin
      for E : Fait_P.Fait_Abstrait_T'Class of Item.Map_Faits loop
         Bloc_Afficher_Type :
         declare
            Nom : constant String := E.Lire_Type'Image;

            subtype IT_Nom_Sans_E_T is Integer range Nom'First .. Nom'Last - 2;
            --  On retire le _E à la fin des noms des types
            --  de variables.
         begin
            Ada.Text_IO.Put_Line (Item => "[" & Nom (IT_Nom_Sans_E_T) & "]");
         end Bloc_Afficher_Type;
         W_W_IO_R.Put (Item => "└────────────  ");

         Bloc_Afficher_Valeur :
         declare
            Valeur_Str : constant String := E.Image;

            Sorte_De_Valeur : constant Sorte_De_Valeur_T :=
               (
                  if    Valeur_Str = Vrais_Str then
                     Vrais_E
                  elsif Valeur_Str = Faux_Str  then
                     Faux_E
                  else
                     Autre_E
               );
         begin
            case Sorte_De_Valeur is
               when Vrais_E =>
                  Ada.Text_IO.Put (Item => "[" & String (E.Lire_Nom) & "]");
               when Faux_E =>
                  Ada.Text_IO.Put (Item => "non ");
                  Ada.Text_IO.Put (Item => "[" & String (E.Lire_Nom) & "]");
               when Autre_E =>
                  Ada.Text_IO.Put (Item => "[" & String (E.Lire_Nom) & "]");
                  Ada.Text_IO.Put (Item => " = [" & Valeur_Str & "]");
            end case;

            Ada.Text_IO.New_Line (Spacing => 1);
         end Bloc_Afficher_Valeur;
      end loop;

      Ada.Text_IO.New_Line (Spacing => 1);
   end Afficher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Base_Faits_P.Text_IO;
