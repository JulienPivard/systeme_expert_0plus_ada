with Ada.Text_IO;

package body Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Premisse_False_T)
   is
      pragma Unreferenced (Item);
   begin
      Ada.Text_IO.Put_Line (Item => "Attendu [FALSE]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P.Text_IO;
