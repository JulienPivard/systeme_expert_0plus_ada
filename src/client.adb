------------------------------------------------------------------------------
--                                                                          --
--                          Auteur : PIVARD Julien                          --
--           Dernière modification : Jeudi 12 septembre[09] 2024
--                                                                          --
------------------------------------------------------------------------------
with Ada.Text_IO;

with GNAT.Source_Info;

with Executeur_P;
with Version_Compilateur_P;

procedure Client is
begin

   Ada.Text_IO.Put      (Item => "+---------------------+");
   Ada.Text_IO.Put_Line (Item => " - - - - - - - - - - - ");
   Ada.Text_IO.Put      (Item => "| Date de compilation :");
   Ada.Text_IO.Put      (Item => "  ");
   Ada.Text_IO.Put      (Item => GNAT.Source_Info.Compilation_ISO_Date);
   Ada.Text_IO.Put      (Item => " ");
   Ada.Text_IO.Put_Line (Item => GNAT.Source_Info.Compilation_Time);
   Ada.Text_IO.Put      (Item => "+---------------------+");
   Ada.Text_IO.Put_Line (Item => " - - - - - - - - - - - ");

   Ada.Text_IO.Put      (Item => "Version du compilateur : ");
   Ada.Text_IO.Put_Line (Item => "[" & Version_Compilateur_P.Version & "]");

   Ada.Text_IO.New_Line (Spacing => 1);

   if Executeur_P.Verifier_Nombre_D_Arguments_Est_Valide then
   Executeur_P.Executer
      (
         Nom_Fichier => Executeur_P.Verifier_Nom_Fichier,
         Mode_Debug  => Executeur_P.Verifier_Mode_Debug
      );
   end if;

exception
   when Executeur_P.Valeur_Option_Incorrect_E =>
      null;
end Client;
