package body Sys_Exp_P.Base_Faits_P.Extension_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure R_A_Z
      (Base : in out Base_De_Faits_T)
   is
   begin
      Base.Map_Faits.Clear;
   end R_A_Z;
   ---------------------------------------------------------------------------

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
