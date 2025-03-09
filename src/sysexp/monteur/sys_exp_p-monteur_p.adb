package body Sys_Exp_P.Monteur_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (Message : in     String)
      return Rapport_D_Erreur_T
   is
   begin
      return Rapport_D_Erreur_T'
         (
            Taille  => Message'Length,
            Message => Message (Message'Range)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P;
