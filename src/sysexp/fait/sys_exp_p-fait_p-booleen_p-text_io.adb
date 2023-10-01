with Ada.Text_IO;

package body Sys_Exp_P.Fait_P.Booleen_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Fait_Booleen_T)
   is
   begin
      Ada.Text_IO.Put (Item => "Nom [" & String (Item.Lire_Nom) & "] ");
      Ada.Text_IO.Put (Item => "Symbole [" & Item.Lire_Valeur'Image & "]");
      Ada.Text_IO.New_Line (Spacing => 1);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
