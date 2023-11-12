with Sys_Exp_P;
with Sys_Exp_P.Base_Faits_P;

--  @summary
--  Des facilité de créations de valeurs.
--  @description
--  Des fonctions pour faciliter la création de valeurs
--  aléatoires pour les tests unitaires.
--  @group Facilité
package Facilites_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   subtype Nom_T         is Sys_Exp_P.Nom_T;
   subtype Nom_Symbole_T is Sys_Exp_P.Nom_Symbole_T;

   function Creer_Chaine
      return String;
   --  Crée aléatoirement une chaine de taille aléatoire.
   --  @return Une chaine aléatoire.

   function Creer_Nom
      return Nom_T;
   --  Crée aléatoirement un nom de taille aléatoire.
   --  @return Un nom aléatoire.

   function Creer_Nom
      (Base : in     Sys_Exp_P.Base_Faits_P.Base_De_Faits_T)
      return Nom_T;
   --  Crée aléatoirement un nom jusqu'à en trouver un
   --  qui n'est pas déjà présent dans la base.
   --  @param Base
   --  La base de fait.
   --  @return Le nom aléatoire.

   function Creer_Nom_Different
      (Nom : in     Nom_T)
      return Nom_T;
   --  Crée aléatoirement un nom de taille aléatoire
   --  différent de celui donné en entré.
   --  @param Nom
   --  Le nom de base.
   --  @return Un nom aléatoire différent.

   function Creer_Symbole
      return Nom_Symbole_T;
   --  Crée aléatoirement un nom symbolique de taille aléatoire.
   --  @return Un nom symbolique aléatoire.

   function Creer_Symbole_Different
      (Nom : in     Nom_Symbole_T)
      return Nom_Symbole_T;
   --  Crée aléatoirement un nom symbolique de taille aléatoire
   --  différent de celui donné en entré.
   --  @param Nom
   --  Le nom de base.
   --  @return Un nom symbolique aléatoire différent.

end Facilites_P;
