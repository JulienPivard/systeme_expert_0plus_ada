with Ada.Text_IO;

package body Sys_Exp_P.Regles_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put_Line
      (I : in     Regle_Interface_T'Class)
   is
      Regle : Regle_Abstraite_T'Class renames Regle_Abstraite_T'Class (I);
   begin
      Put_Line (Item => Regle);
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Regle_Abstraite_T'Class)
   is
   begin
      Ada.Text_IO.Put      (Item => "==== Règle numéro :");
      Ada.Text_IO.Put      (Item => Item.ID_Regle'Image);
      Ada.Text_IO.Put_Line (Item => " ====");
      Ada.Text_IO.Put      (Item => "Règle déclenchée : ");
      Ada.Text_IO.Put_Line (Item => Item.Regle_Declenchee'Image);
      Ada.Text_IO.Put_Line
         (
            Item => "Conclusion " &
               "[" & String (Item.Conclusion.Element.Lire_Nom) & "]"
         );
      if Item.Possede_Successeur then
         Put_Line (I => Item.Successeur.Element);
      end if;
   end Put_Line;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Regles_P.Text_IO;
