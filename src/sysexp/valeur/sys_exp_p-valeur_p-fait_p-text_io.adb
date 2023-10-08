with Ada.Text_IO;

package body Sys_Exp_P.Valeur_P.Fait_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Feuille_Fait_T)
   is
   begin
      Ada.Text_IO.Put (Item => "Fait [" & String (Item.Nom.Element) & "]");
      Ada.Text_IO.New_Line (Spacing => 1);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Fait_P.Text_IO;
