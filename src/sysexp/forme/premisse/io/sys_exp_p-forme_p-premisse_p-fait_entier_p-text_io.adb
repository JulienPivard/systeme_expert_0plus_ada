with Ada.Text_IO;

package body Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Premisse_Fait_T)
   is
   begin
      Ada.Text_IO.Put_Line ("Fait [" & String (Item.Nom_Fait.Element) & "]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Text_IO;
