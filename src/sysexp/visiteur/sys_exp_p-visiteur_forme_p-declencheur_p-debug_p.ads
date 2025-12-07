--  @summary
--  Un visiteur de règles avec ou sans prémisse de debug.
--  @description
--  Ce visiteur a pour but d'évaluer chaque forme pour en
--  tirer des conclusions (Comme le visiteur standard) et
--  d'afficher toutes les opérations sur la sortie standard.
--  @group Visiteur Forme
package Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Visiteur_Debug_T is new Visiteur_T with private;
   --  Visiteur concret de règles conclusion et de prémisses.

   overriding
   function Creer
      return Visiteur_Debug_T;
   --  Crée un visiteur de Formes.
   --  @return Le visiteur de formes.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Conclusion_P.Bool_False_P.Conclusion_T
      );
   --  Porte d'entrée pour visiter une conclusion booléenne fausse.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Conclusion_P.Bool_True_P.Conclusion_T
      );
   --  Porte d'entrée pour visiter une conclusion booléenne vraie.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Conclusion_P.Expression_Entiere_P.Conclusion_T
      );
   --  Porte d'entrée pour visiter une conclusion d'expression entière.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Conclusion_P.Fait_Entier_P.Conclusion_T
      );
   --  Porte d'entrée pour visiter une conclusion de fait entier.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Conclusion_P.Symbole_Constant_P.Conclusion_T
      );
   --  Porte d'entrée pour visiter une conclusion symbolique.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Conclusion_P.Symbole_Fait_P.Conclusion_T
      );
   --  Porte d'entrée pour visiter une conclusion de fait symbolique.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La conclusion à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Premisse_P.Bool_False_P.Premisse_T
      );
   --  Porte d'entrée pour visiter une prémisse booléenne fausse.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Premisse_P.Bool_True_P.Premisse_T
      );
   --  Porte d'entrée pour visiter une prémisse booléenne vraie.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Premisse_P.Expression_Entiere_P.Premisse_T
      );
   --  Porte d'entrée pour visiter une prémisse d'expression entière.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Premisse_P.Fait_Entier_P.Premisse_T
      );
   --  Porte d'entrée pour visiter une prémisse de fait entier.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Premisse_P.Symbole_Constant_P.Premisse_T
      );
   --  Porte d'entrée pour visiter une prémisse symbolique.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La prémisse à visiter.

   overriding
   procedure Visiter
      (
         This  : in out Visiteur_Debug_T;
         Base  : in out Base_Faits_P.Base_De_Faits_T;
         Forme : in     Forme_P.Premisse_P.Symbole_Fait_P.Premisse_T
      );
   --  Porte d'entrée pour visiter une prémisse de fait symbolique.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Base
   --  La base de fait à utiliser.
   --  @param Forme
   --  La prémisse à visiter.

private

   subtype Parent_T is Visiteur_T;

   function Creer_Parent
      return Parent_T
   renames Creer;

   type Visiteur_Debug_T is new Visiteur_T with
      record
         null;
      end record;

   procedure Afficher
      (This : in     Visiteur_Debug_T);
   --  Affiche les paramètre internes du visiteur.
   --  @param This
   --  Le visiteur de forme.

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Debug_P;
