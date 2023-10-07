--  @summary
--  Systeme expert 0+ en Ada.
--  @description
--  Un système expert 0+ en Ada qui utilise la syntaxe loraine.
--  @group Systeme_Expert
package Sys_Exp_P
   with
      Pure           => True,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Entier_T is range -2**31 .. 2**31 - 1;
   --  Une valeur entière.

   type Taille_Nom_T is range 1 .. 50;
   --  La taille maximum d'un nom de fait.
   type Nom_T        is array (Taille_Nom_T range <>) of Character;
   --  Un nom de fait.

end Sys_Exp_P;
