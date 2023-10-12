with Ada.Text_IO;

with Sys_Exp_P.Valeur_P.Fait_P.Text_IO;
with Sys_Exp_P.Valeur_P.Constante_P.Text_IO;
with Sys_Exp_P.Valeur_P.Operateur_P.Text_IO;

package body Sys_Exp_P.Valeur_P.Text_IO
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Put
      (Item : in     Valeur_Abstraite_T'Class)
   is
   begin
      if    Item in Fait_P.Feuille_Fait_T                  then
         Afficher (Fait      => Fait_P.Feuille_Fait_T                  (Item));
      elsif Item in Constante_P.Feuille_Constante_T        then
         Afficher (Constante => Constante_P.Feuille_Constante_T        (Item));
      elsif Item in Operateur_P.Operateur_Abstrait_T'Class then
         Afficher (Operateur => Operateur_P.Operateur_Abstrait_T'Class (Item));
      end if;
   end Put;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Put_Line
      (Item : in     Valeur_Abstraite_T'Class)
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
      (Fait : in     Fait_P.Feuille_Fait_T)
   is
   begin
      Fait_P.Text_IO.Put (Item => Fait);
   end Afficher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher
      (Constante : in     Constante_P.Feuille_Constante_T)
   is
   begin
      Constante_P.Text_IO.Put (Item => Constante);
   end Afficher;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher
      (Operateur : in     Operateur_P.Operateur_Abstrait_T'Class)
   is
   begin
      Operateur_P.Text_IO.Put (Item => Operateur);
   end Afficher;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Text_IO;
