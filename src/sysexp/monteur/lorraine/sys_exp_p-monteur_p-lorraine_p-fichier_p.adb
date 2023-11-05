package body Sys_Exp_P.Monteur_P.Lorraine_P.Fichier_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Ouvrir
      (
         Fichier     : in out Ada.Text_IO.File_Type;
         Nom_Fichier : in     String
      )
   is
   begin
      Ada.Text_IO.Open
         (
            File => Fichier,
            Name => Nom_Fichier,
            Mode => Ada.Text_IO.In_File
         );
   end Ouvrir;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Ligne
      (Fichier : in out Ada.Text_IO.File_Type)
      return String
   is
   begin
      return Ada.Text_IO.Get_Line (File => Fichier);
   end Lire_Ligne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Fichier_P;
