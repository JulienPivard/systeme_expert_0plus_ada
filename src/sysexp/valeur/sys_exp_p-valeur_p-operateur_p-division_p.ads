--  @summary
--  Représente une opération de division.
--  @description
--  Opération de division entre deux valeurs.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Operateur_P.Division_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Operateur_Div_T is new Operateur_Abstrait_T with private;

   overriding
   function Creer
      (
         Valeur_Gauche : in     Valeur_Abstraite_T'Class;
         Valeur_Droite : in     Valeur_Abstraite_T'Class
      )
      return Operateur_Div_T;
   --  Crée un opérateur à partir de valeurs.
   --  @param Valeur_Gauche
   --  La valeur gauche.
   --  @param Valeur_Droite
   --  La valeur gauche.
   --  @return L'opérateur.

   overriding
   function Interpreter
      (
         This : in     Operateur_Div_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T;
   --  Permet d'évaluer la valeur.
   --  @param This
   --  L'opérateur.
   --  @param Base
   --  La base de faits à utiliser pour évaluer les expressions.
   --  @return La valeur de l'opération ou de la feuille.

   overriding
   function Lire_Symbole
      (This : in     Operateur_Div_T)
      return Symbole_T;
   --  Lit le symbole associé à l'opération pour l'affichage.
   --  @param This
   --  L'opérateur.
   --  @return Le symbole de l'opération.

private

   type Operateur_Div_T is new Operateur_Abstrait_T with
      record
         null;
      end record;

end Sys_Exp_P.Valeur_P.Operateur_P.Division_P;
