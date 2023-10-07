--  @summary
--  Systeme expert 0+ en Ada.
--  @description
--  Un système expert 0+ en Ada qui utilise la syntaxe loraine.
--  @group Systeme_Expert
package Sys_Exp_P
   with
      Pure                    => True,
      Preelaborate            => False,
      Elaborate_Body          => False,
      No_Elaboration_Code_All => True,
      Spark_Mode              => Off
is

   type Entier_T is range -2**31 .. 2**31 - 1;
   --  Une valeur entière.

end Sys_Exp_P;
