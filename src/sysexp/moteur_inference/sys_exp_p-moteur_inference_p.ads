with Sys_Exp_P.Regles_P;

private with Ada.Containers.Indefinite_Holders;

private with Sys_Exp_P.Base_Faits_P;

--  @summary
--  Le moteur d'inférence du système expert.
--  @description
--  Le moteur d'inférence qui va s'exécuter sur la base de règles,
--  pour produire la base de faits.
--  @group Moteur Inference
package Sys_Exp_P.Moteur_Inference_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Moteur_Inference_T is tagged limited private;

   function Creer
      (Base_De_Regles : in     Regles_P.Regle_Abstraite_T'Class)
      return Moteur_Inference_T;
   --  Crée un moteur d'inférence qui va travailler sur une
   --  base de règles.
   --  @param Base_De_Regles
   --  La base de regles sur laquelle travailler.
   --  @return Le moteur d'inférence.

   procedure Analyser_Base_Regles
      (This : in out Moteur_Inference_T);
   --  Lance l'analyse de la base de règles.
   --  @param This
   --  Le moteur d'inférence.

private

   package Regle_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Regles_P.Regle_Abstraite_T'Class,
         "="          => Regles_P."="
      );

   subtype Base_De_Regles_T is Regle_Holder_P.Holder;

   type Moteur_Inference_T is tagged limited
      record
         Regles : Base_De_Regles_T;
         Base   : aliased Base_Faits_P.Base_De_Faits_T;
      end record;

end Sys_Exp_P.Moteur_Inference_P;
