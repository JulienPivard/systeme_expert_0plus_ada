with Sys_Exp_P.Valeur_P.Text_IO;

package body Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Conclusion_T)
   is
   begin
      Sys_Exp_P.Valeur_P.Text_IO.Put_Line (Item => Item.Expression.Element);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P.Text_IO;
