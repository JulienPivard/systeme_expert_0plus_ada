with Sys_Exp_P.Fait_P;

private with Map_Fait_P;

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

   subtype Fait_Abstrait_T is Fait_P.Fait_Abstrait_T;

   type Base_De_Faits_T is tagged limited private;
   --  La base de faits.

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

   procedure Vider
      (This : in out Base_De_Faits_T);
   --  Vide la base de faits.
   --  @param This
   --  La base de faits.

private

   subtype Map_Faits_T is Map_Fait_P.Map;

   type Base_De_Faits_T is tagged limited
      record
         Map_Faits : Map_Faits_T;
         --  Les faits sont stocké dans une map indexé
         --  par le hash de leurs nom.
      end record;

end Sys_Exp_P.Base_Faits_P;
