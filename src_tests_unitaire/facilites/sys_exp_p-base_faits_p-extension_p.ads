--  @summary
--  Extension de la base de fait pour les tests unitaires.
--  @description
--  Extension de la base de fait pour les tests unitaires.
--  @group Base
package Sys_Exp_P.Base_Faits_P.Extension_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure R_A_Z
      (Base : in out Base_De_Faits_T);

end Sys_Exp_P.Base_Faits_P.Extension_P;
