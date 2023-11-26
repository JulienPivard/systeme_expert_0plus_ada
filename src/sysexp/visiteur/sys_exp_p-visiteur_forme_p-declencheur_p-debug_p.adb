with Ada.Text_IO;

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

   ---------------------------------------------------------------------------
   overriding
   function Creer
      (Base : in     not null Accesseur_Base_T)
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
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);
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
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);
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
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);
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
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);
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
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);
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
      Ada.Text_IO.Put          (Item => "Ajout de ");
      Forme_P.Text_IO.Put_Line (Item => Forme);

      Parent.Visiter (Forme => Forme);
   end Visiter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P;
