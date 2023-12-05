private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Le directeur de construction du jeu de règles.
--  @description
--  Le directeur de construction du jeu de règles.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Directeur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Directeur_T (<>) is tagged limited private;
   --  Le directeur de construction du jeu de règles.

   function Creer
      (Monteur : in     Monteur_Abstrait_T'Class)
      return Directeur_T;
   --  Crée un directeur de construction de jeu de règles.
   --  @param Monteur
   --  Le monteur chargé de la construction.
   --  @return Le directeur de construction.

   procedure Construire_Jeu_De_Regles
      (This : in out Directeur_T);
   --  Lance la construction du jeu de règles à partir
   --  du monteur.
   --  @param This
   --  Le directeur de construction.

   function Livrer
      (This : in     Directeur_T)
      return Base_De_Regles_T;
   --  Permet de récupérer le jeu de règle une fois la
   --  construction finie.
   --  @param This
   --  Le directeur de construction.
   --  @return Le jeu de règles construit.

private

   package Monteur_Holder_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => Monteur_Abstrait_T'Class);
   --  @private Package interne.

   subtype Monteur_Holder_T is Monteur_Holder_P.Holder;
   --  Conteneur de monteur.

   type Directeur_T is tagged limited
      record
         Monteur : Monteur_Holder_T := Monteur_Holder_P.Empty_Holder;
         --  Le monteur de jeu de règles.
      end record;

end Sys_Exp_P.Monteur_P.Directeur_P;
