--  @summary
--  Représentation concrète d'une valeur constante.
--  @description
--  Permet de représenter une valeur, seule ou dans
--  une partie gauche ou droite d'une opération.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Constante_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Valeur_Constante_T is new Valeur_Abstraite_T with private;
   --  Une valeur constante, dont la valeur ne changera pas
   --  au cours de l'exécution.

   not overriding
   function Creer
      (Valeur : in     Entier_T)
      return Valeur_Constante_T;
   --  Crée une valeur constante qui peut être utilisée tel quel,
   --  ou dans une expression en partie gauche ou droite.
   --  @param Valeur
   --  La valeur constante stockée.
   --  @return Une feuille associé à une valeur constante.

   overriding
   function Interpreter
      (
         This : in     Valeur_Constante_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T;
   --  Permet d'évaluer la valeur.
   --  @param This
   --  La valeur.
   --  @param Base
   --  La base de faits à utiliser pour évaluer les expressions.
   --  @return La valeur de l'opération ou de la feuille.

   overriding
   function Image
      (This : in     Valeur_Constante_T)
      return String;
   --  Image d'une valeur constante.
   --  @param This
   --  La valeur constante.
   --  @return L'image de la valeur constante.

private

   type Valeur_Constante_T is new Valeur_Abstraite_T with
      record
         Valeur : Entier_T;
         --  La valeur constante à stocker.
      end record;

end Sys_Exp_P.Valeur_P.Constante_P;
