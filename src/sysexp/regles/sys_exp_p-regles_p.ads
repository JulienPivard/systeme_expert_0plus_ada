with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Forme_P.Conclusion_P;
with Sys_Exp_P.Visiteur_Forme_P;

private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Une règle avec ou sans prémisse.
--  @description
--  Une règle contient toujours une conclusion que l'on essayera
--  de déclencher.
--  @group Regle
package Sys_Exp_P.Regles_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   package Conclusion_R renames Sys_Exp_P.Forme_P.Conclusion_P;

   type Regle_Interface_T is interface;
   --  Une règle abstraite qui représentera tous les type de
   --  règles possible dans le système expert.

   function Iterer
      (
         This : in out Regle_Interface_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean
   is abstract;
   --  Lance une visite des toutes les règles avec la
   --  base de faits.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return Au moins une règle a été déclenchée.

   function Possede_Successeur
      (This : in     Regle_Interface_T)
      return Boolean
   is abstract;
   --  La règle possède une règle suivante.
   --  @param This
   --  La règle actuelle.
   --  @return La règle possède un successeur.

   function Est_Declenchee
      (This : in     Regle_Interface_T)
      return Boolean
   is abstract;
   --  La règle a déjà été déclenchée.
   --  @param This
   --  La règle actuelle.
   --  @return La règle a déjà été déclenchée.

   function Verifier_Premisse
      (
         This : in     Regle_Interface_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean
   is abstract;
   --  La prémisse a été vérifiée.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return La prémisse de la règle a été vérifiée.

   type ID_Regle_T is mod 2**32;
   --  L'identifiant unique d'une règle.

   type Regle_Abstraite_T is abstract new Regle_Interface_T with private;
   --  Une règle abstraite qui représentera tous les type de
   --  règles possible dans le système expert.

   not overriding
   procedure Ajouter
      (
         This       : in out Regle_Abstraite_T;
         Successeur : in     Regle_Interface_T'Class
      );
   --  Ajoute une règle successeur à la règle actuelle.
   --  @param This
   --  La règle à laquelle on ajoute un successeur.
   --  @param Successeur
   --  La règle qui sera la suivante.

   overriding
   function Iterer
      (
         This : in out Regle_Abstraite_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean;
   --  Lance une visite des toutes les règles avec la
   --  base de faits.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return Au moins une règle a été déclenchée.

   overriding
   function Possede_Successeur
      (This : in     Regle_Abstraite_T)
      return Boolean;
   --  La règle possède une règle suivante.
   --  @param This
   --  La règle actuelle.
   --  @return La règle possède un successeur.

   overriding
   function Est_Declenchee
      (This : in     Regle_Abstraite_T)
      return Boolean;
   --  La règle a déjà été déclenchée.
   --  @param This
   --  La règle actuelle.
   --  @return La règle a déjà été déclenchée.

private

   package Conclusion_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Conclusion_R.Conclusion_Abstraite_T'Class,
         "="          => Conclusion_R."="
      );

   package Regle_Holder_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => Regle_Interface_T'Class);

   package Visiteur_R renames Sys_Exp_P.Visiteur_Forme_P;

   subtype Conclusion_T is Conclusion_Holder_P.Holder;
   subtype Successeur_T is Regle_Holder_P.Holder;

   type Regle_Abstraite_T is abstract new Regle_Interface_T with
      record
         ID_Regle         : ID_Regle_T   := ID_Regle_T'First;
         --  Le numéro de la règles dans la base de règles.
         Conclusion       : Conclusion_T := Conclusion_Holder_P.Empty_Holder;
         --  La conclusion qui sera déclenchée par la règle si possible.
         Regle_Declenchee : Boolean      := False;
         --  Pour garder en mémoire si la règle a déjà été déclenchée.
         Successeur       : Successeur_T := Regle_Holder_P.Empty_Holder;
         --  La règle suivante.
      end record;

   function Declencher
      (
         This : in out Regle_Abstraite_T'Class;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean;
   --  Essaye de déclencher une conclusion.
   --  @param This
   --  La règle à déclencher.
   --  @param Base
   --  Le base de faits.
   --  @return La conclusion a pu être ajoutée.

   procedure Verifier_Flag_Erreur_Visiteur
      (
         Regle    : in     Regle_Abstraite_T'Class;
         Visiteur : in     Visiteur_R.Visiteur_Forme_Abstrait_T'Class
      );
   --  Vérifie le contenu des erreurs du visiteur.
   --  @param Regle
   --  La règle abstraite.
   --  @param Visiteur
   --  Le visiteur utilisé.

   --------------------------------------
   overriding
   function Possede_Successeur
      (This : in     Regle_Abstraite_T)
      return Boolean
   is (not This.Successeur.Is_Empty);
   --------------------------------------

   --------------------------------------
   overriding
   function Est_Declenchee
      (This : in     Regle_Abstraite_T)
      return Boolean
   is (This.Regle_Declenchee);
   --------------------------------------

end Sys_Exp_P.Regles_P;
