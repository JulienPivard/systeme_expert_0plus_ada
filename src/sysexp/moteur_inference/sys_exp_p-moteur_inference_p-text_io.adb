with Sys_Exp_P.Base_Faits_P.Text_IO;

package body Sys_Exp_P.Moteur_Inference_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Moteur_Inference_T)
   is
   begin
      Sys_Exp_P.Base_Faits_P.Text_IO.Put_Line (Item => Item.Base);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Moteur_Inference_P.Text_IO;
