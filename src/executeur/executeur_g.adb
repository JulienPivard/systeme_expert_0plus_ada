with Ada.Text_IO;
with Ada.Directories;

package body Executeur_G is

   ---------------------------------------------------------------------------
   procedure Executer
      (
         Nom_Fichier : in     String;
         Mode_Debug  : in     Boolean
      )
   is separate;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher_Aide is
      Indentation : constant Wide_Wide_String := "        ";
   begin
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => "Usage : ");
      Ada.Text_IO.Put
         (
            File => Ada.Text_IO.Standard_Error,
            Item => Ada.Directories.Base_Name
               (Name => Ada.Command_Line.Command_Name)
         );
      W_W_IO_R.Put_Line
         (File => W_W_IO_R.Standard_Error, Item => " <nom_fichier> [-d]");
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => Indentation);
      W_W_IO_R.Put_Line
         (File => W_W_IO_R.Standard_Error, Item => "<nom_fichier> :");
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => Indentation & Indentation);
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "Le nom du fichier de règles écrit en "
         );
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => Indentation & Indentation);
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "respectant la grammaire lorraine."
         );
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => Indentation);
      W_W_IO_R.Put_Line
         (File => W_W_IO_R.Standard_Error, Item => "-d :");
      W_W_IO_R.Put
         (File => W_W_IO_R.Standard_Error, Item => Indentation & Indentation);
      W_W_IO_R.Put_Line
         (
            File => W_W_IO_R.Standard_Error,
            Item => "Construit les règles avec un visiteur de debug."
         );
      W_W_IO_R.New_Line
         (File => W_W_IO_R.Standard_Error, Spacing => 1);
   end Afficher_Aide;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Verifier_Nombre_D_Arguments is
   begin
      Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Success);

      if Nb_Args = 0 and then Nombre_D_Arguments_Min > 0 then
         Afficher_Aide;
         raise Pas_Assez_D_Arguments_E;

      elsif Nb_Args > Nombre_D_Arguments_Max then
         Afficher_Aide;
         W_W_IO_R.Put
            (File => W_W_IO_R.Standard_Error, Item => "Trop d'arguments. ");
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Les arguments suivants sont invalide : "
            );
         for I in Arguments_En_Trop_T loop
            Ada.Text_IO.Put
               (File => Ada.Text_IO.Standard_Error, Item => "  - ");
            Ada.Text_IO.Put_Line
               (
                  File => Ada.Text_IO.Standard_Error,
                  Item => Ada.Command_Line.Argument (Number => I)
               );
         end loop;
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Trop_D_Arguments_E;

      elsif Nb_Args < Nombre_D_Arguments_Min then
         Afficher_Aide;
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Vous devez donner au moins le [argument]."
            );
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Pas_Assez_D_Arguments_E;

      end if;
   end Verifier_Nombre_D_Arguments;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Verifier_Nom_Fichier
      return String
   is
      Nom : constant String := Ada.Command_Line.Argument (Number => 1);
   begin
      if not Ada.Directories.Exists (Name => Nom) then
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         Ada.Text_IO.Put_Line
            (
               Item => "Le fichier [" & Nom & "] n'existe pas dans " &
                  "[" & Ada.Directories.Current_Directory & "]"
            );
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         raise Valeur_Option_Incorrect_E;
      end if;

      return Nom;
   end Verifier_Nom_Fichier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Verifier_Mode_Debug
      return Boolean
   is
   begin
      return
         Nb_Args >= 2
         and then
         Ada.Command_Line.Argument (Number => 2) = "-d";
   end Verifier_Mode_Debug;
   ---------------------------------------------------------------------------

end Executeur_G;
