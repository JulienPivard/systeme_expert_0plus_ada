private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Test avec un monteur facile.
--  @description
--  Test avec un monteur facile.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Test_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Monteur_T is new Monteur_Abstrait_T with private;
   --  Un monteur de test.

   overriding
   procedure Construire_Jeu_De_Regles
      (This : in out Monteur_T);
   --  Construit le jeu de règles.
   --  @param This
   --  Le monteur de jeu de règles.

   overriding
   function Lire_Resultat
      (This : in     Monteur_T)
      return Base_De_Regles_T;
   --  Permet de récupérer le résultat de la construction.
   --  @param This
   --  Le monteur de jeu de règles.
   --  @return Le jeu de règles construit.

private

   package Base_De_Regles_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Base_De_Regles_T,
         "="          => Sys_Exp_P.Regles_P."="
      );

   subtype Base_De_Regles_Holder_T is Base_De_Regles_Holder_P.Holder;

   type Monteur_T is new Monteur_Abstrait_T with
      record
         Base_De_Regles : Base_De_Regles_Holder_T :=
            Base_De_Regles_Holder_P.Empty_Holder;
         --  La base de règles une fois construite.
      end record;

end Sys_Exp_P.Monteur_P.Test_P;
