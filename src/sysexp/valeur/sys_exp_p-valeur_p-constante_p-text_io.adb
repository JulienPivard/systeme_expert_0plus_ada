with Ada.Text_IO;

package body Sys_Exp_P.Valeur_P.Constante_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Feuille_Constante_T)
   is
   begin
      Ada.Text_IO.Put_Line (Item => "Constante [" & Item.Valeur'Image & "]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Constante_P.Text_IO;
