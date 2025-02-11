with Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   not overriding
   function Creer
      (
         Nom_Fichier : in     Nom_Fichier_T;
         Fabrique    : in     Fabrique_R.Fabrique_Interface_T'Class
      )
      return Monteur_T
   is
      Fichier : constant Nom_Fichier_Memorise_T := Nom_Fichier_Memorise_T'
         (
            Taille => Nom_Fichier'Length,
            Nom    => Nom_Fichier
         );
   begin
      return Monteur_T'
         (
            Nom_Fichier    => Fichier,
            Fabrique       =>
               Fabrique_Holder_P.To_Holder (New_Item => Fabrique),
            Base_De_Regles => Base_De_Regles_P.Empty_Holder
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Construire_Jeu_De_Regles
      (This : in out Monteur_T)
   is
      Syntaxique : Syntaxique_P.Syntaxique_T := Syntaxique_P.Creer
         (
            Nom_Fichier => This.Nom_Fichier.Nom,
            Fabrique    => This.Fabrique.Element
         );
   begin
      This.Base_De_Regles := Base_De_Regles_P.To_Holder
         (New_Item => Syntaxique.Parser);
   end Construire_Jeu_De_Regles;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Lire_Resultat
      (This : in     Monteur_T)
      return Base_De_Regles_T
   is
   begin
      return This.Base_De_Regles.Element;
   end Lire_Resultat;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P;
