with Ada.Text_IO;
with Ada.Strings.Fixed;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P;

with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P;

with Sys_Exp_P.Forme_P.Text_IO;

package body Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P
   with Spark_Mode => Off
is

   function Trim
      (
         Source : in     String;
         Side   : in     Ada.Strings.Trim_End := Ada.Strings.Both
      )
      return String
      renames Ada.Strings.Fixed.Trim;

   ---------------------------------------------------------------------------
   overriding
   function Creer
      (Base : in     Base_Faits_P.Base_De_Faits_A)
      return Visiteur_Debug_T
   is
   begin
      return Visiteur_Debug_T'
         (
            Creer_Parent (Base => Base)
            with null record
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                       La visite des conclusions                       --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Conclusion_P.Bool_False_P.Conclusion_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Conclusion_P.Bool_True_P.Conclusion_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Conclusion_P.Expression_Entiere_P.Conclusion_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Conclusion_P.Fait_Entier_P.Conclusion_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Conclusion_P.Symbole_Constant_P.Conclusion_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Conclusion_P.Symbole_Fait_P.Conclusion_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                        La visite des prémisses                        --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Premisse_P.Bool_False_P.Premisse_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Test de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Premisse_P.Bool_True_P.Premisse_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Test de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Premisse_P.Expression_Entiere_P.Premisse_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Test de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Premisse_P.Fait_Entier_P.Premisse_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Test de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Premisse_P.Symbole_Constant_P.Premisse_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Test de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Forme : in     Forme_P.Premisse_P.Symbole_Fait_P.Premisse_T
      )
   is
      Parent : Parent_T renames Parent_T (This);
   begin
      Ada.Text_IO.Put          (Item => "Test de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);

      This.Afficher;
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Afficher
      (This : in     Visiteur_Debug_T)
   is
   begin
      Ada.Text_IO.Put_Line
         (
            Item => "Conclusion Déclenchée " &
               "[" & This.Conclusion_A_Ete_Declenchee'Image & "]"
         );
      Ada.Text_IO.Put_Line
         (
            Item => "Prémisse Vérifié      " &
               "[" & This.Premisse_A_Ete_Verifiee'Image & "]"
         );
      Ada.Text_IO.Put_Line
         (
            Item => "Code erreur           " &
               "[" & This.Code_Erreur'Image & "]"
         );
      Ada.Text_IO.Put_Line
         (
            Item => "Message erreur        " &
               "[" & Trim (Source => This.Message_D_Erreur) & "]"
         );
      Ada.Text_IO.New_Line     (Spacing => 1);
   end Afficher;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P;
