with Ada.Text_IO;

package body Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Conclusion_T)
   is
   begin
      Ada.Text_IO.Put_Line
         (Item => "Symbole [" & String (Item.Nom_Symbole.Element) & "]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P.Text_IO;
