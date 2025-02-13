private with Ada.Characters.Latin_1;

--  @summary
--  Adaptateur pour simuler la lecture de fichier.
--  @description
--  Adaptateur pour simuler la lecture de fichier.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Numero_Ligne_T is range 0 .. 100;

   type Contenu_T is private;

   procedure Ouvrir
      (
         Contenu : in out Contenu_T;
         Nom     : in     Nom_Fichier_T
      );

   function Lire_Ligne
      (Contenu : in out Contenu_T)
      return String;

   function Lire_Numero_Ligne
      (Contenu : in     Contenu_T)
      return Numero_Ligne_T;

   function Fin_Est_Atteinte
      (Contenu : in     Contenu_T)
      return Boolean;

   function Remplir
      (Contenu : in     String)
      return Contenu_T;

private

   subtype Faux_Contenu_T is String (1 .. 9_999);

   Fin_Ligne : constant Character := Ada.Characters.Latin_1.LF;

   Faux_Contenu : Faux_Contenu_T := Faux_Contenu_T'
      (
         Faux_Contenu_T'Last => Fin_Ligne,
         others              => ' '
      );

   Fin_Faux_Contenu : Integer := 0;

   type Contenu_T is
      record
         Num_Ligne    : Numero_Ligne_T := 0;
         Fin_Atteinte : Boolean        := False;
         Position     : Integer        := 1;
      end record;

end Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;
