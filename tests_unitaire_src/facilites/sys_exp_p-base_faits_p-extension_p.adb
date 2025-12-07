package body Sys_Exp_P.Base_Faits_P.Extension_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function NB_Elements
      (B : in     Base_De_Faits_T)
      return Integer
   is
   begin
      return Integer (B.Map_Faits.Length);
   end NB_Elements;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Base_Faits_P.Extension_P;
