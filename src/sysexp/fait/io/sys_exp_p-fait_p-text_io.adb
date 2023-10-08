with Ada.Text_IO;

with Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
with Sys_Exp_P.Fait_P.Entier_P.Text_IO;
with Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;

package body Sys_Exp_P.Fait_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put
      (Item : in     Fait_Abstrait_T'Class)
   is

   begin
      if    Item in Fait_P.Booleen_P.Fait_Booleen_T       then
         Afficher (Bool    => Fait_P.Booleen_P.Fait_Booleen_T       (Item));
      elsif Item in Fait_P.Entier_P.Fait_Entier_T         then
         Afficher (Entier  => Fait_P.Entier_P.Fait_Entier_T         (Item));
      elsif Item in Fait_P.Symbolique_P.Fait_Symbolique_T then
         Afficher (Symbole => Fait_P.Symbolique_P.Fait_Symbolique_T (Item));
      end if;
   end Put;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Fait_Abstrait_T'Class)
   is
   begin
      Put                  (Item    => Item);
      Ada.Text_IO.New_Line (Spacing => 1);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher
      (Bool : in     Fait_P.Booleen_P.Fait_Booleen_T)
   is
   begin
      Fait_P.Booleen_P.Text_IO.Put (Item => Bool);
   end Afficher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher
      (Entier : in     Fait_P.Entier_P.Fait_Entier_T)
   is
   begin
      Fait_P.Entier_P.Text_IO.Put (Item => Entier);
   end Afficher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher
      (Symbole : in     Fait_P.Symbolique_P.Fait_Symbolique_T)
   is
   begin
      Fait_P.Symbolique_P.Text_IO.Put (Item => Symbole);
   end Afficher;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Fait_P.Text_IO;
