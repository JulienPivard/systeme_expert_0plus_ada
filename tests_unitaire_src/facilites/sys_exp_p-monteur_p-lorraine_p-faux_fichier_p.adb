with Ada.Strings.Fixed;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P
   with Spark_Mode => Off
is

   function Chercher_Prochain_Saut
      (Contenu : in     Contenu_T)
      return Integer;

   ---------------------------------------------------------------------------
   procedure Ouvrir
      (
         Contenu : in out Contenu_T;
         Nom     : in     Nom_Fichier_T
      )
   is
      pragma Unreferenced (Nom);
   begin
      Contenu := Contenu_T'
         (
            Num_Ligne    => 0,
            Fin_Atteinte => False,
            Position     => Faux_Contenu'First
         );
   end Ouvrir;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Ligne
      (Contenu : in out Contenu_T)
      return String
   is
      Debut : constant Integer := Contenu.Position;
      Fin   : constant Integer := Chercher_Prochain_Saut (Contenu => Contenu);

      Resultat : constant String := Faux_Contenu (Debut .. Fin - 1);
   begin
      Contenu.Position     := Fin + 1;
      Contenu.Num_Ligne    := Contenu.Num_Ligne + 1;
      Contenu.Fin_Atteinte := Contenu.Position >= Fin_Faux_Contenu;

      return Resultat;
   end Lire_Ligne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Lire_Numero_Ligne
      (Contenu : in     Contenu_T)
      return Numero_Ligne_T
   is
   begin
      return Contenu.Num_Ligne;
   end Lire_Numero_Ligne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Fin_Est_Atteinte
      (Contenu : in     Contenu_T)
      return Boolean
   is
   begin
      return Contenu.Fin_Atteinte;
   end Fin_Est_Atteinte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Remplir
      (Contenu : in     String)
      return Contenu_T
   is
      Resultat : constant Contenu_T := Contenu_T'
         (
            Num_Ligne    => Numero_Ligne_T'Last,
            Fin_Atteinte => True,
            Position     => Faux_Contenu'Last
         );
   begin
      Ada.Strings.Fixed.Move
         (
            Source => Contenu,
            Target => Faux_Contenu,
            Drop   => Ada.Strings.Right
         );
      Fin_Faux_Contenu := Contenu'Length;

      return Resultat;
   end Remplir;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Chercher_Prochain_Saut
      (Contenu : in     Contenu_T)
      return Integer
   is
      I : Integer := Contenu.Position;
   begin
      B_Recherche :
      loop
         exit B_Recherche when I > Fin_Faux_Contenu;
         exit B_Recherche when Faux_Contenu (I) = Fin_Ligne;
         I := I + 1;
      end loop B_Recherche;

      return I;
   end Chercher_Prochain_Saut;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;
