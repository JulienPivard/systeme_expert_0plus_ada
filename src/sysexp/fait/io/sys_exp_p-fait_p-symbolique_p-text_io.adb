with Ada.Text_IO;

package body Sys_Exp_P.Fait_P.Symbolique_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Fait_Symbolique_T)
   is
   begin
      Ada.Text_IO.Put (Item => "Nom [" & String (Item.Lire_Nom) & "] ");
      Ada.Text_IO.Put (Item => "Valeur [" & String (Item.Lire_Valeur) & "]");
      Ada.Text_IO.New_Line (Spacing => 1);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;
