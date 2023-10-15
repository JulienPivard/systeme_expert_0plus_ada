--  @summary
--  Le du visiteur de règles avec ou sans prémisse.
--  @description
--  Ce visiteur a pour but d'évaluer chaque forme pour en
--  tirer des conclusions.
--  @group Visiteur Forme
package Sys_Exp_P.Visiteur_Forme_P.Declencheur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Visiteur_T is new Visiteur_Forme_Abstrait_T with private;
   --  Visiteur concret de règles conclusion et de prémisses.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Forme_P.Conclusion_P.Bool_False_P.Conclusion_False_T
      );
   --  Porte d'entrée pour visiter une conclusion booléenne fausse.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Forme_P.Conclusion_P.Bool_True_P.Conclusion_True_T
      );
   --  Porte d'entrée pour visiter une conclusion booléenne vraie.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Expression_T
      );
   --  Porte d'entrée pour visiter une conclusion d'expression entière.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Fait_Entier_T
      );
   --  Porte d'entrée pour visiter une conclusion de fait entier.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Symbolique_Constante_T
      );
   --  Porte d'entrée pour visiter une conclusion symbolique.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Conclusion_Symbolique_Fait_T
      );
   --  Porte d'entrée pour visiter une conclusion de fait symbolique.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_False_T
      );
   --  Porte d'entrée pour visiter une prémisse booléenne fausse.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_True_T
      );
   --  Porte d'entrée pour visiter une prémisse booléenne vraie.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Expression_T
      );
   --  Porte d'entrée pour visiter une prémisse d'expression entière.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Fait_Entier_T
      );
   --  Porte d'entrée pour visiter une prémisse de fait entier.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Symbolique_Constante_T
      );
   --  Porte d'entrée pour visiter une prémisse symbolique.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Premisse_Symbolique_Fait_T
      );
   --  Porte d'entrée pour visiter une prémisse de fait symbolique.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

private

   type Visiteur_T is new Visiteur_Forme_Abstrait_T with
      record
         null;
      end record;

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P;
