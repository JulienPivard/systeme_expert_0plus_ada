with Sys_Exp_P.Base_Faits_P;

--  @summary
--  Le squelette d'une expression de valeur entière.
--  @description
--  Toutes les valeurs utilisées dans la construction d'une
--  expression entière seront des descendants de cette classe.
--  (Valeur constantes, opérations + - / *, ...)
--  @group Valeur
package Sys_Exp_P.Valeur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   E_Fait_Non_Entier   : exception;
   --  Exception déclenchée quand le fait lu n'est pas un entier.
   E_Fait_Inconnu      : exception;
   --  Exception déclenchée quand le fait est inconnu de la base.
   E_Division_Par_Zero : exception;
   --  Exception déclenché par une division par zéro.

   type Valeur_Abstraite_T is interface;
   --  Une valeur d'une expression.

   function Interpreter
      (
         This : in     Valeur_Abstraite_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T
   is abstract;
   --  Permet d'évaluer la valeur.
   --  @param This
   --  La valeur.
   --  @param Base
   --  La base de faits à utiliser pour évaluer les expressions.
   --  @return La valeur de l'opération ou de la feuille.

end Sys_Exp_P.Valeur_P;
