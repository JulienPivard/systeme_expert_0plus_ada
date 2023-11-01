with Sys_Exp_P.Regles_P;

--  @summary
--  Constructeur de la base de règles.
--  @description
--  Création de base de règles à partir d'une source
--  quelconque.
--  @group Monteur
package Sys_Exp_P.Monteur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   subtype Base_De_Regles_T is Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class;

   type Monteur_Abstrait_T is interface;
   --  Le constructeur de règles.

   procedure Construire_Jeu_De_Regles
      (This : in out Monteur_Abstrait_T)
   is abstract;
   --  Construit le jeu de règles.
   --  @param This
   --  Le monteur de jeu de règles.

   function Lire_Resultat
      (This : in     Monteur_Abstrait_T)
      return Base_De_Regles_T
   is abstract;
   --  Permet de récupérer le résultat de la construction.
   --  @param This
   --  Le monteur de jeu de règles.
   --  @return Le jeu de règles construit.

private

end Sys_Exp_P.Monteur_P;
