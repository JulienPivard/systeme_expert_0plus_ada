with Ada.Text_IO;

with Sys_Exp_P.Valeur_P.Text_IO;

package body Sys_Exp_P.Valeur_P.Operateur_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put
      (Item : in     Operateur_Abstrait_T'Class)
   is
   begin
      Ada.Text_IO.Put                (Item => "(");
      Sys_Exp_P.Valeur_P.Text_IO.Put (Item => Item.Lire_Element_Gauche);
      Ada.Text_IO.Put                (Item => " ");
      Ada.Text_IO.Put                (Item => Item.Symbol);
      Ada.Text_IO.Put                (Item => " ");
      Sys_Exp_P.Valeur_P.Text_IO.Put (Item => Item.Lire_Element_Droite);
      Ada.Text_IO.Put                (Item => ")");
   end Put;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Operateur_Abstrait_T'Class)
   is
   begin
      Put                  (Item    => Item);
      Ada.Text_IO.New_Line (Spacing => 1);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Operateur_P.Text_IO;
