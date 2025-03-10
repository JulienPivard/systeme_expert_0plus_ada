with Ada.Containers;

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

   Taille_Max_Nom : constant := 50;

   type Entier_T is range -2**63 .. 2**63 - 1;
   --  Une valeur entière.

   type Taille_Nom_T is range 1 .. Taille_Max_Nom;
   --  La taille maximum d'un nom de fait.
   type Nom_T        is array (Taille_Nom_T range <>) of Character;
   --  Un nom de fait.

   type Nom_Symbole_T is new Nom_T;
   --  Un nom symbolique différent d'un nom.

   type Type_De_Fait_T is (Booleen_E, Entier_E, Symbolique_E);
   --  Les différents type de fait possible.
   --  @Value Booleen_E
   --  C'est un fait booléen.
   --  @Value Entier_E
   --  C'est un fait entier.
   --  @Value Symbolique_E
   --  C'est un fait symbolique.

   E_Fait_Non_Entier   : exception;
   --  Exception déclenchée quand le fait lu n'est pas un entier.
   E_Division_Par_Zero : exception;
   --  Exception déclenché par une division par zéro.
   E_Fait_Deja_Present : exception;
   --  Exception déclenchée quand un fait est déjà présent dans la base.
   E_Fait_Inconnu      : exception;
   --  Exception déclenchée quand le fait est inconnu de la base.

   function Hash
      (Nom : in     Nom_T)
      return Ada.Containers.Hash_Type;
   --  Fonction de hash du nom d'un fait.
   --  @param Nom
   --  Le nom à hacher.
   --  @return Le hash.

   NB_Caractres : constant := 255;

   type NB_Caractres_T is range 0 .. NB_Caractres;

   subtype ID_Nom_T is NB_Caractres_T range 1 .. NB_Caractres_T'Last;

   type Nom_Fichier_T is array (ID_Nom_T range <>) of Character;

end Sys_Exp_P;
