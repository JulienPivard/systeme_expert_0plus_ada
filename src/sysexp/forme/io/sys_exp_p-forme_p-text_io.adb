with Ada.Tags;
with Ada.Text_IO;

package body Sys_Exp_P.Forme_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Forme_Abstraite_T'Class)
   is
   begin
      Ada.Text_IO.Put
         (Item => "Fait [" & String (Item.Lire_Nom) & "] ");
      Ada.Text_IO.Put_Line
         (Item => "[" & Ada.Tags.Expanded_Name (T => Item'Tag) & "]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Text_IO;
