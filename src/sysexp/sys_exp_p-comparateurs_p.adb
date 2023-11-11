package body Sys_Exp_P.Comparateurs_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Tester_G
      (Gauche, Droite : in     Valeur_G_T)
      return Boolean
   is
   begin
      return Comparateur_G (Gauche => Gauche, Droite => Droite);
   end Tester_G;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Comparateurs_P;
