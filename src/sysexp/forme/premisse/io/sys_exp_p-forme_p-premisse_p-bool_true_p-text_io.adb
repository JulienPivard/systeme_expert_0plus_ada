with Ada.Text_IO;

package body Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Premisse_True_T)
   is
      pragma Unreferenced (Item);
   begin
      Ada.Text_IO.Put_Line (Item => "Attendu [TRUE]");
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P.Text_IO;
