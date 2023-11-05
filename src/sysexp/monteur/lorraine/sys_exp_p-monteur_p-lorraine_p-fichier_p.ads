with Ada.Text_IO;

--  @summary
--  Adaptateur pour la lecture de fichier.
--  @description
--  Adaptateur pour la lecture de fichier.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Lorraine_P.Fichier_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Ouvrir
      (
         Fichier     : in out Ada.Text_IO.File_Type;
         Nom_Fichier : in     String
      );
   --  Ouvre un fichier pour le parseur lexical.
   --  @param Fichier
   --  Le fichier.
   --  @param Nom_Fichier
   --  Le nom du fichier.

   function Lire_Ligne
      (Fichier : in out Ada.Text_IO.File_Type)
      return String;
   --  Lit la prochaine ligne du fichier.
   --  @param Fichier
   --  Le fichier.
   --  @return La prochaine ligne du fichier.

end Sys_Exp_P.Monteur_P.Lorraine_P.Fichier_P;
