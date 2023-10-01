with Ada.Text_IO;

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
         Ada.Text_IO.Put_Line
            (Item => "Type de fait [" & E.Lire_Type'Image & "]");

         case E.Lire_Type is
            when Fait_P.Booleen_E =>
               Bloc_Afficher_Booleen :
               declare
                  F : constant Fait_P.Booleen_P.Fait_Booleen_T :=
                     Fait_P.Booleen_P.Fait_Booleen_T (E);
               begin
                  Fait_P.Booleen_P.Text_IO.Put_Line (Item => F);
               end Bloc_Afficher_Booleen;
            when Fait_P.Entier_E =>
               Bloc_Afficher_Entier :
               declare
                  F : constant Fait_P.Entier_P.Fait_Entier_T :=
                     Fait_P.Entier_P.Fait_Entier_T (E);
               begin
                  Fait_P.Entier_P.Text_IO.Put_Line (Item => F);
               end Bloc_Afficher_Entier;
            when Fait_P.Symbole_E =>
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

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Base_Faits_P.Text_IO;
