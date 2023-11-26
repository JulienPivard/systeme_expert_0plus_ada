with Ada.Tags;
with Ada.Text_IO;

with Sys_Exp_P.Forme_P.Conclusion_P.Text_IO;
with Sys_Exp_P.Forme_P.Premisse_P.Text_IO;

package body Sys_Exp_P.Forme_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Forme_Abstraite_T'Class)
   is
      subtype Parent_Premisse_T   is Premisse_P.Premisse_Abstraite_T;
      subtype Parent_Conclusion_T is Conclusion_P.Conclusion_Abstraite_T;
   begin
      Ada.Text_IO.Put
         (Item => "Fait [" & String (Item.Lire_Nom) & "] ");
      Ada.Text_IO.Put_Line
         (Item => "[" & Ada.Tags.Expanded_Name (T => Item'Tag) & "]");

      if    Item in Parent_Premisse_T'Class   then
         Premisse_P.Text_IO.Put_Line
            (Item => Parent_Premisse_T'Class   (Item));
      elsif Item in Parent_Conclusion_T'Class then
         Conclusion_P.Text_IO.Put_Line
            (Item => Parent_Conclusion_T'Class (Item));
      end if;
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Text_IO;
