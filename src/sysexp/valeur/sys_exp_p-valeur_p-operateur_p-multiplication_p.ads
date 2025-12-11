--  @summary
--  Représente une opération de multiplication.
--  @description
--  Opération de multiplication entre deux valeurs.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Operateur_Mult_T is new Operateur_Abstrait_T with private;
   --  Représentation d'une opération de multiplication.

   overriding
   function Creer
      (
         Valeur_Gauche : in     Valeur_Abstraite_T'Class;
         Valeur_Droite : in     Valeur_Abstraite_T'Class
      )
      return Operateur_Mult_T;
   --  Crée un opérateur de multiplication à partir de valeurs.
   --  @param Valeur_Gauche
   --  La valeur gauche.
   --  @param Valeur_Droite
   --  La valeur gauche.
   --  @return L'opérateur de multiplication.

   overriding
   function Interpreter
      (
         This : in     Operateur_Mult_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T;
   --  Permet d'évaluer la multiplication.
   --  @param This
   --  L'opérateur.
   --  @param Base
   --  La base de faits à utiliser pour évaluer les expressions.
   --  @return Le résultat de la multiplication.

   overriding
   function Lire_Symbole
      (This : in     Operateur_Mult_T)
      return Symbole_T;
   --  Lit le symbole associé à l'opération pour l'affichage.
   --  @param This
   --  L'opérateur.
   --  @return Le symbole de la multiplication.

   overriding
   function Image
      (This : in     Operateur_Mult_T)
      return String;
   --  Image d'un opérateur multiplication.
   --  @param This
   --  La valeur d'un opérateur.
   --  @return L'image d'un opérateur multiplication.

private

   type Operateur_Mult_T is new Operateur_Abstrait_T with
      record
         null;
      end record;

end Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P;
