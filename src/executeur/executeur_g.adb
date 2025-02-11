with Ada.Directories;
with Ada.Text_IO;

package body Executeur_G is

   ---------------------------------------------------------------------------
   procedure Executer
      (
         Nom_Fichier : in     Sys_Exp_P.Nom_Fichier_T;
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
   function Verifier_Nombre_D_Arguments_Est_Valide
      return Boolean
   is
      subtype Intervale_Valide_T is NB_Args_T range
         Nombre_D_Arguments_Min .. Nombre_D_Arguments_Max;

      pragma Annotate
         (
            gnatcheck,
            Exempt_On,
            "Membership_Tests",
            "Test d'un intervalle, plus lisible."
         );
      Resultat : Boolean := NB_Args in Intervale_Valide_T;
      pragma Annotate
         (
            gnatcheck,
            Exempt_Off,
            "Membership_Tests"
         );
   begin
      Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Success);

      if NB_Args = 0 and then Nombre_D_Arguments_Min > 0 then
         Afficher_Aide;
         Resultat := False;

      elsif NB_Args > Nombre_D_Arguments_Max then
         Afficher_Aide;
         W_W_IO_R.Put
            (File => W_W_IO_R.Standard_Error, Item => "Trop d'arguments. ");
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Les arguments suivants sont invalide : "
            );
         Bloc_Afficher_Arguments_En_Trop :
         declare
            subtype Arguments_En_Trop_T is NB_Args_T range
               NB_Args_Max + 1 .. NB_Args;
            --  L'intervalle des arguments en trop.
         begin
            for I in Arguments_En_Trop_T loop
               Ada.Text_IO.Put
                  (File => Ada.Text_IO.Standard_Error, Item => "  - ");
               pragma Annotate
                  (
                     gnatcheck,
                     Exempt_On,
                     "Predefined_Numeric_Types",
                     "impossible de ne pas convertir I en Natural"
                  );
               Ada.Text_IO.Put_Line
                  (
                     File => Ada.Text_IO.Standard_Error,
                     Item => Ada.Command_Line.Argument (Number => Natural (I))
                  );
               pragma Annotate
                  (
                     gnatcheck,
                     Exempt_Off,
                     "Predefined_Numeric_Types"
                  );
            end loop;
         end Bloc_Afficher_Arguments_En_Trop;

         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         Resultat := False;

      elsif NB_Args < Nombre_D_Arguments_Min then
         Afficher_Aide;
         W_W_IO_R.Put_Line
            (
               File => W_W_IO_R.Standard_Error,
               Item => "Vous devez donner au moins le [argument]."
            );
         Ada.Command_Line.Set_Exit_Status (Code => Ada.Command_Line.Failure);
         Resultat := False;

      else
         Resultat := True;
      end if;

      return Resultat;
   end Verifier_Nombre_D_Arguments_Est_Valide;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Verifier_Nom_Fichier
      return Sys_Exp_P.Nom_Fichier_T
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

      if Nom'Length > Sys_Exp_P.NB_Caractres then
         Ada.Text_IO.Put_Line
            (
               Item => "Le fichier [" & Nom & "] est trop long, il fait " &
                  "[" & Nom'Length'Image & "]" &
                  " Il doit faire moins de " &
                  "[" & Sys_Exp_P.NB_Caractres'Image & "] caractères."
            );
         raise Valeur_Option_Incorrect_E;
      end if;

      return Sys_Exp_P.Nom_Fichier_T (Nom);
   end Verifier_Nom_Fichier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Verifier_Mode_Debug
      return Boolean
   is
   begin
      return
         NB_Args >= 2
         and then
         Ada.Command_Line.Argument (Number => 2) = "-d";
   end Verifier_Mode_Debug;
   ---------------------------------------------------------------------------

end Executeur_G;
