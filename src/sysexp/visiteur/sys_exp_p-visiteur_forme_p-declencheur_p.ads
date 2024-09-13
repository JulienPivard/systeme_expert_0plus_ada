--  @summary
--  Le visiteur de règles avec ou sans prémisse.
--  @description
--  Ce visiteur a pour but d'évaluer chaque forme pour en
--  tirer des conclusions. Les prémisses seront d'abord
--  évaluées pour décider si on essaye de déclencher la
--  conclusion.
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

   not overriding
   function Creer
      (Base : in     not null Accesseur_Base_A)
      return Visiteur_T;
   --  Crée un visiteur de Formes.
   --  @param Base
   --  La base de faits.
   --  @return Le visiteur de formes.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_T;
         Forme : in     Forme_P.Conclusion_P.Bool_False_P.Conclusion_T
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
         Forme : in     Forme_P.Conclusion_P.Bool_True_P.Conclusion_T
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
         Forme : in     Forme_P.Conclusion_P.Expression_Entiere_P.Conclusion_T
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
         Forme : in     Forme_P.Conclusion_P.Fait_Entier_P.Conclusion_T
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
         Forme : in     Forme_P.Conclusion_P.Symbole_Constant_P.Conclusion_T
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
         Forme : in     Forme_P.Conclusion_P.Symbole_Fait_P.Conclusion_T
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
         Forme : in     Forme_P.Premisse_P.Bool_False_P.Premisse_T
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
         Forme : in     Forme_P.Premisse_P.Bool_True_P.Premisse_T
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
         Forme : in     Forme_P.Premisse_P.Expression_Entiere_P.Premisse_T
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
         Forme : in     Forme_P.Premisse_P.Fait_Entier_P.Premisse_T
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
         Forme : in     Forme_P.Premisse_P.Symbole_Constant_P.Premisse_T
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
         Forme : in     Forme_P.Premisse_P.Symbole_Fait_P.Premisse_T
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
