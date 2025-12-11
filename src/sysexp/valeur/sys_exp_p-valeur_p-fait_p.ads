with Nom_Holder_P;

--  @summary
--  Représentation concrète d'une valeur avec un nom.
--  @description
--  Permet de représenter une valeur, seule ou dans
--  une partie gauche ou droite d'une opération.
--  La valeur du fait est récupéré dans la base de faits
--  en utilisant son nom.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Fait_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Valeur_Fait_T is new Valeur_Abstraite_T with private;
   --  Une valeur d'un fait. La valeur est lue dans la base
   --  de faits, et peux donc changer au cours de l'exécution
   --  du programme.

   not overriding
   function Creer
      (Nom : in     Nom_T)
      return Valeur_Fait_T;
   --  Crée une référence à une valeur d'un fait qui peut être utilisée,
   --  ou dans une expression en partie gauche ou droite.
   --  @param Nom
   --  Le nom faisant référence au fait.
   --  @return Une feuille associé à un fait.

   overriding
   function Interpreter
      (
         This : in     Valeur_Fait_T;
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
      (This : in     Valeur_Fait_T)
      return String;
   --  Image d'un fait.
   --  @param This
   --  La valeur d'un fait.
   --  @return L'image d'un fait.

private

   type Valeur_Fait_T is new Valeur_Abstraite_T with
      record
         Nom : Nom_Holder_P.Holder;
         --  La valeur constante à stocker.
      end record;

end Sys_Exp_P.Valeur_P.Fait_P;
