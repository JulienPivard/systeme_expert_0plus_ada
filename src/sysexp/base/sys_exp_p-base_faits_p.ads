private with Ada.Containers.Indefinite_Hashed_Maps;

with Sys_Exp_P.Fait_P;

--  @summary
--  La base contenant tous les faits.
--  @description
--  La base contenant tous les faits.
--  @group Base de faits
package Sys_Exp_P.Base_Faits_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   subtype Fait_Abstrait_T is Sys_Exp_P.Fait_P.Fait_Abstrait_T;

   type Base_De_Faits_T is tagged limited private;
   --  La base de faits.

   type Accesseur_Base_T is access all Base_De_Faits_T
      with Storage_Size => 0;

   function Contient
      (
         This     : in     Base_De_Faits_T;
         Nom_Fait : in     Nom_T
      )
      return Boolean;
   --  Test si le fait qui porte ce nom est dans la base.
   --  @param This
   --  La base de faits.
   --  @param Nom_Fait
   --  Le nom du fait recherché.
   --  @return Le fait est dans la base.

   function Trouver
      (
         This     : in     Base_De_Faits_T;
         Nom_Fait : in     Nom_T
      )
      return Fait_Abstrait_T'Class;
   --  Extrait le fait qui porte ce nom de la base.
   --  Le fait reste présent dans la base.
   --  @param This
   --  La base de faits.
   --  @param Nom_Fait
   --  Le nom du fait recherché.
   --  @return Le fait trouvé.

   procedure Ajouter
      (
         This        : in out Base_De_Faits_T;
         Nouvel_Item : in     Fait_Abstrait_T'Class
      );
   --  Ajoute le fait à la base. Si il est déjà présent on lève
   --  une exception.
   --  @param This
   --  La base de faits.
   --  @param Nouvel_Item
   --  Le fait à ajouter à la base.

private

   function Hash
      (Nom : in     Nom_T)
      return Ada.Containers.Hash_Type;
   --  Fonction de hash du nom d'un fait.
   --  @param Nom
   --  Le nom à hacher.
   --  @return Le hash.

   package Map_Fait_P is new Ada.Containers.Indefinite_Hashed_Maps
      (
         Key_Type        => Nom_T,
         Element_Type    => Fait_Abstrait_T'Class,
         Hash            => Hash,
         Equivalent_Keys => Sys_Exp_P."=",
         "="             => Sys_Exp_P.Fait_P."="
      );
   --  @private Package interne.

   subtype Map_Faits_T is Map_Fait_P.Map;

   type Base_De_Faits_T is tagged limited
      record
         Map_Faits : Map_Faits_T;
         --  Les faits sont stocké dans une map indexé
         --  par le hash de leurs nom.
      end record;

end Sys_Exp_P.Base_Faits_P;
