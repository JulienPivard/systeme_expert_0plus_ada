with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P.Text_IO;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P.Text_IO;
with Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P.Text_IO;
with Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P.Text_IO;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P.Text_IO;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P.Text_IO;

package body Sys_Exp_P.Forme_P.Premisse_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Premisse_Abstraite_T'Class)
   is
   begin
      if    Item in Bool_False_P.Premisse_False_T              then
         Bool_False_P.Text_IO.Put_Line
            (Item => Bool_False_P.Premisse_False_T              (Item));
      elsif Item in Bool_True_P.Premisse_True_T                then
         Bool_True_P.Text_IO.Put_Line
            (Item => Bool_True_P.Premisse_True_T                (Item));
      elsif Item in Expression_Entiere_P.Premisse_Expression_T then
         Expression_Entiere_P.Text_IO.Put_Line
            (Item => Expression_Entiere_P.Premisse_Expression_T (Item));
      elsif Item in Fait_Entier_P.Premisse_Fait_T              then
         Fait_Entier_P.Text_IO.Put_Line
            (Item => Fait_Entier_P.Premisse_Fait_T              (Item));
      elsif Item in Symbole_Constant_P.Premisse_Symbolique_T   then
         Symbole_Constant_P.Text_IO.Put_Line
            (Item => Symbole_Constant_P.Premisse_Symbolique_T   (Item));
      elsif Item in Symbole_Fait_P.Premisse_Symbolique_T       then
         Symbole_Fait_P.Text_IO.Put_Line
            (Item => Symbole_Fait_P.Premisse_Symbolique_T       (Item));
      end if;
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Premisse_P.Text_IO;
