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

   type Entier_T is range -2**63 .. 2**63 - 1;
   --  Une valeur entière.

   type Taille_Nom_T is range 1 .. 50;
   --  La taille maximum d'un nom de fait.
   type Nom_T        is array (Taille_Nom_T range <>) of Character;
   --  Un nom de fait.

   type Nom_Symbole_T is new Nom_T;
   --  Un nom symbolique différent d'un nom.

   E_Fait_Non_Entier   : exception;
   --  Exception déclenchée quand le fait lu n'est pas un entier.
   E_Division_Par_Zero : exception;
   --  Exception déclenché par une division par zéro.
   E_Fait_Deja_Present : exception;
   --  Exception déclenchée quand un fait est déjà présent dans la base.
   E_Fait_Inconnu      : exception;
   --  Exception déclenchée quand le fait est inconnu de la base.

end Sys_Exp_P;
