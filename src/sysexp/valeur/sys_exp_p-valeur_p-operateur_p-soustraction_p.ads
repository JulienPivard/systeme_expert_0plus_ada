--  @summary
--  Représente une opération de soustraction.
--  @description
--  Opération de soustraction entre deux valeurs.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Operateur_Moins_T is new Operateur_Abstrait_T with private;
   --  Représentation d'une opération de soustraction.

   overriding
   function Creer
      (
         Valeur_Gauche : in     Valeur_Abstraite_T'Class;
         Valeur_Droite : in     Valeur_Abstraite_T'Class
      )
      return Operateur_Moins_T;
   --  Crée un opérateur de soustraction à partir de valeurs.
   --  @param Valeur_Gauche
   --  La valeur gauche.
   --  @param Valeur_Droite
   --  La valeur gauche.
   --  @return L'opérateur de soustraction.

   overriding
   function Interpreter
      (
         This : in     Operateur_Moins_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T;
   --  Permet d'évaluer la soustraction.
   --  @param This
   --  L'opérateur.
   --  @param Base
   --  La base de faits à utiliser pour évaluer les expressions.
   --  @return Le résultat de la soustraction.

   overriding
   function Lire_Symbole
      (This : in     Operateur_Moins_T)
      return Symbole_T;
   --  Lit le symbole associé à l'opération pour l'affichage.
   --  @param This
   --  L'opérateur.
   --  @return Le symbole de la soustraction.

private

   type Operateur_Moins_T is new Operateur_Abstrait_T with
      record
         null;
      end record;

end Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P;
