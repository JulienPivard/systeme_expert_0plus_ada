with Sys_Exp_P.Base_Faits_P;

limited with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
limited with Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
limited with Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
limited with Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P;
limited with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P;
limited with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P;

limited with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
limited with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;
limited with Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;
limited with Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;
limited with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P;
limited with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P;

private with Sys_Exp_P.Fait_P;

--  @summary
--  Le squelette du visiteur de règles avec ou sans prémisse.
--  @description
--  Visiteur qui permettra de faire toutes les opérations
--  dont on a besoin sur la structure des prémisses et
--  de conclusions.
--  @group Visiteur Forme
package Sys_Exp_P.Visiteur_Forme_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Code_Erreur_T is
      (
         Tout_Va_Bien_E,
         --  Pas d'erreur
         Div_Par_Zero_E,
         --  Erreur division par zéro rencontrée.
         Incoherence_Fait_E,
         --  Erreur incohérence détectée dans la base de fait.
         Fait_Entier_Inconnu_E,
         --  Erreur le fait entier n'existe pas
         Fait_Expression_Inconnu_E,
         --  Erreur le fait n'existe pas dans l'expression.
         Fait_Symbolique_Inconnu_E
         --  Erreur le fait symbolique n'existe pas.
      );
   --  Pour stocker l'état de l'erreur rencontré.

   Taille_Message_Erreur : constant := 100;
   --  Taille max d'un message d'erreur.

   subtype ID_Msg_Err_T is Integer range 1 .. Taille_Message_Erreur;
   --  Taille de messages d'erreur.

   subtype Message_Erreur_T is String (ID_Msg_Err_T);
   --  Le message de l'erreur rencontrée.

   Message_Vide : constant Message_Erreur_T;
   --  Un message d'erreur vide.

   subtype Accesseur_Base_A is Sys_Exp_P.Base_Faits_P.Accesseur_Base_A;
   --  Accesseur sur la base de faits.

   type Visiteur_Forme_Abstrait_T (<>) is abstract tagged limited private;
   --  Un visiteur de Formes abstrait. Le squelette de base de tout
   --  les visiteur de prémisses ou de conclusions.

   function Au_Moins_Une_Premisse_Verifiee
      (This : in     Visiteur_Forme_Abstrait_T)
      return Boolean;
   --  Au moins une prémisse a été vérifiée par le visiteur.
   --  @param This
   --  Le visiteur.
   --  @return Au moins une prémisse a été vérifiée.

   function Au_Moins_Une_Conclusion_Declenchee
      (This : in     Visiteur_Forme_Abstrait_T)
      return Boolean;
   --  Au moins une conclusion a été déclenchée par le visiteur.
   --  @param This
   --  Le visiteur.
   --  @return Au moins une conclusion a été déclenchée.

   function Lire_Code_Erreur
      (This : in     Visiteur_Forme_Abstrait_T)
      return Code_Erreur_T;
   --  Lit le code d'erreur.
   --  @param This
   --  Le visiteur.
   --  @return Le code d'erreur.

   function Lire_Message_Erreur
      (This : in     Visiteur_Forme_Abstrait_T)
      return Message_Erreur_T;
   --  Lit le message de l'erreur rencontrée.
   --  @param This
   --  Le visiteur.
   --  @return Le message d'erreur.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Conclusion_P.Bool_False_P.Conclusion_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une conclusion booléenne fausse.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Conclusion_P.Bool_True_P.Conclusion_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une conclusion booléenne vraie.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Conclusion_P.Expression_Entiere_P.Conclusion_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une conclusion d'expression entière.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Conclusion_P.Fait_Entier_P.Conclusion_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une conclusion de fait entier.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Conclusion_P.Symbole_Constant_P.Conclusion_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une conclusion symbolique.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Conclusion_P.Symbole_Fait_P.Conclusion_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une conclusion de fait symbolique.
   --  Ajoute la conclusion de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La conclusion à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Premisse_P.Bool_False_P.Premisse_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une prémisse booléenne fausse.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Premisse_P.Bool_True_P.Premisse_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une prémisse booléenne vraie.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Premisse_P.Expression_Entiere_P.Premisse_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une prémisse d'expression entière.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Premisse_P.Fait_Entier_P.Premisse_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une prémisse de fait entier.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Premisse_P.Symbole_Constant_P.Premisse_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une prémisse symbolique.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

   procedure Visiter
      (
         This  : in out Visiteur_Forme_Abstrait_T;
         Forme : in     Forme_P.Premisse_P.Symbole_Fait_P.Premisse_T
      )
   is abstract;
   --  Porte d'entrée pour visiter une prémisse de fait symbolique.
   --  Ajoute la prémisse de la règle à la base de faits
   --  si celle ci est déclenchée.
   --  @param This
   --  Le visiteur
   --  @param Forme
   --  La prémisse à visiter.

private

   Message_Vide : constant Message_Erreur_T :=
      Message_Erreur_T'(others => ' ');

   type Visiteur_Forme_Abstrait_T is abstract tagged limited
      record
         Base                        : Accesseur_Base_A := null;
         --  La base de faits où on va ajouter les conclusions déclenchées.
         Premisse_A_Ete_Verifiee     : Boolean          := False;
         --  Permet de savoir si la prémisse est vérifiée.
         Conclusion_A_Ete_Declenchee : Boolean          := False;
         --  Permet de savoir si on a ajouté une conclusion à la base de faits.
         Code_Erreur                 : Code_Erreur_T    := Tout_Va_Bien_E;
         --  Permet de savoir quel type d'erreur a été rencontrée.
         Message_D_Erreur            : Message_Erreur_T := Message_Vide;
         --  Le message de l'erreur qui à été déclenchée.
      end record;

   procedure Ajouter_Un_Fait
      (
         This : in out Visiteur_Forme_Abstrait_T'Class;
         Fait : in     Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class
      );
   --  Ajoute un fait à la base de faits.
   --  @param This
   --  Le visiteur.
   --  @param Fait
   --  Le fait à ajouter.

   --------------------------------------
   function Au_Moins_Une_Premisse_Verifiee
      (This : in     Visiteur_Forme_Abstrait_T)
      return Boolean
   is (This.Premisse_A_Ete_Verifiee);
   --------------------------------------

   --------------------------------------
   function Au_Moins_Une_Conclusion_Declenchee
      (This : in     Visiteur_Forme_Abstrait_T)
      return Boolean
   is (This.Conclusion_A_Ete_Declenchee);

   --------------------------------------
   function Lire_Code_Erreur
      (This : in     Visiteur_Forme_Abstrait_T)
      return Code_Erreur_T
   is (This.Code_Erreur);
   --------------------------------------

   --------------------------------------
   function Lire_Message_Erreur
      (This : in     Visiteur_Forme_Abstrait_T)
      return Message_Erreur_T
   is (This.Message_D_Erreur);
   --------------------------------------

end Sys_Exp_P.Visiteur_Forme_P;
