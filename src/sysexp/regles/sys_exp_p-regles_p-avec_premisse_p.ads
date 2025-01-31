with Sys_Exp_P.Forme_P.Premisse_P;
with Sys_Exp_P.Visiteur_Forme_P;
with Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;

private with Ada.Containers.Indefinite_Doubly_Linked_Lists;

--  @summary
--  Une règle avec prémisse.
--  @description
--  Une règle contient toujours une conclusion que l'on
--  déclenchera si toutes les prémisses associées sont vérifiées.
--  @group Regle
package Sys_Exp_P.Regles_P.Avec_Premisse_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   package Premisse_R renames Sys_Exp_P.Forme_P.Premisse_P;
   --  @private Package interne.
   package Fabrique_R renames Visiteur_Forme_P.Fabrique_Interface_P;
   --  @private Package interne.

   type Regle_T is new Regle_Abstraite_T with private;
   --  Une règle avec prémisses.

   not overriding
   function Creer
      (
         ID_Regle   : in     ID_Regle_T;
         Premisse   : in     Premisse_R.Premisse_Abstraite_T'Class;
         Conclusion : in     Conclusion_R.Conclusion_Abstraite_T'Class;
         Fabrique   : in     Fabrique_R.Fabrique_Interface_T'Class
      )
      return Regle_T;
   --  Crée une règle avec au moins une prémisse et une conclusion.
   --  @param ID_Regle
   --  Le numéro de la règle.
   --  @param Premisse
   --  La prémisse associée.
   --  @param Conclusion
   --  La conclusion associer à la règle.
   --  @param Fabrique
   --  La fabrique de visiteurs de formes.
   --  @return La règle construite.

   overriding
   function Verifier_Premisse
      (
         This : in     Regle_T;
         Base : aliased in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean;
   --  Toutes les prémisses ont été vérifiées.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return Toutes les prémisses sont vérifié.

   overriding
   function Creer_Visiteur
      (
         This : in     Regle_T;
         Base : aliased in out Base_Faits_P.Base_De_Faits_T
      )
      return Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class;
   --  Crée un nouveau visiteur de forme.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return Un visiteur de forme.

   procedure Ajouter
      (
         This     : in out Regle_T;
         Premisse : in     Premisse_R.Premisse_Abstraite_T'Class
      );
   --  Ajoute une prémisse à la règle. La prémisse est ajoutée
   --  à toutes les autres, elles seront toutes évaluées avec
   --  un et logique entre chacune.
   --  @param This
   --  La règle.
   --  @param Premisse
   --  La prémisse à ajouter.

private

   package Liste_P is new Ada.Containers.Indefinite_Doubly_Linked_Lists
      (
         Element_Type => Premisse_R.Premisse_Abstraite_T'Class,
         "="          => Premisse_R."="
      );
   --  @private Package interne.

   subtype Liste_Premisses_T is Liste_P.List;

   package Fabrique_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Fabrique_R.Fabrique_Interface_T'Class,
         "="          => Fabrique_R."="
      );
   --  @private Package interne.

   type Regle_T is new Regle_Abstraite_T with
      record
         Premisses : Liste_Premisses_T;
         --  La liste des prémisses à satisfaire pour
         --  pouvoir déclencher la conclusion.
         Fabrique  : Fabrique_Holder_P.Holder;
         --  La fabrique de visiteur de formes à utiliser.
      end record;

end Sys_Exp_P.Regles_P.Avec_Premisse_P;
