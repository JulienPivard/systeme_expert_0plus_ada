with Sys_Exp_P.Fait_P;
with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Symbolique_P;

--  @summary
--  Des facilité pour créer des faits.
--  @description
--  Des facilité pour créer des faits.
--  @group Facilité
package Facilites_P.Fait_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   function Creer_Fait
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
   --  Crée un fait de type aléatoire avec des valeurs aléatoires.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait
      (
         Nom   : in     Sys_Exp_P.Nom_T;
         Sorte : in     Sys_Exp_P.Fait_P.Type_De_Fait_T
      )
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
   --  Crée un fait du type demandé avec des valeurs aléatoires.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @param Sorte
   --  Le type de fait à créer.
   --  @return Le fait.

   function Creer_Fait_Booleen
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T;
   --  Crée un fait de type booléen avec une valeur aléatoires.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Entier
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
   --  Crée un fait de type entier avec une valeur aléatoires.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Symbolique
      (Nom : in     Sys_Exp_P.Nom_T)
      return Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T;
   --  Crée un fait de type symbolique avec une valeur aléatoires.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
   --  Crée un fait de type aléatoire avec des valeurs aléatoires
   --  qui sera différent du fait en entré, dans ses valeurs mais
   --  aussi dans son type.
   --  @param Fait
   --  Le fait de référence.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Different
      (
         Fait  : in     Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
         Nom   : in     Sys_Exp_P.Nom_T;
         Sorte : in     Sys_Exp_P.Fait_P.Type_De_Fait_T
      )
      return Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class;
   --  Crée un fait du type demandé avec des valeurs aléatoires
   --  qui sera différent du fait en entré, dans ses valeurs.
   --  @param Fait
   --  Le fait de référence.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @param Sorte
   --  Le type de fait à créer.
   --  @return Le fait.

   function Creer_Fait_Booleen_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T;
   --  Crée un fait de type booléen avec une valeur aléatoires.
   --  @param Fait
   --  Le fait de référence.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Entier_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T;
   --  Crée un fait de type entier avec une valeur aléatoires.
   --  @param Fait
   --  Le fait de référence.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

   function Creer_Fait_Symbolique_Different
      (
         Fait : in     Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T;
         Nom  : in     Sys_Exp_P.Nom_T
      )
      return Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T;
   --  Crée un fait de type symbolique avec une valeur aléatoires.
   --  @param Fait
   --  Le fait de référence.
   --  @param Nom
   --  Le nom que devra porter le fait.
   --  @return Le fait.

end Facilites_P.Fait_P;
