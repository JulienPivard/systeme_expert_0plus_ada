package body Sys_Exp_P.Monteur_P.Directeur_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (Monteur : in     Monteur_Abstrait_T'Class)
      return Directeur_T
   is
   begin
      return D : Directeur_T do
         D.Monteur := Monteur_Holder_P.To_Holder (New_Item => Monteur);
      end return;
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Construire_Jeu_De_Regles
      (This : in out Directeur_T)
   is
   begin
      This.Monteur.Reference.Construire_Jeu_De_Regles;
   end Construire_Jeu_De_Regles;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Livrer
      (This : in     Directeur_T)
      return Resultat_Parseur_T
   is
   begin
      return This.Monteur.Element.Lire_Resultat;
   end Livrer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Directeur_P;
