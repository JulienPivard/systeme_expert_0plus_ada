--  @summary
--  Une règle sans prémisse.
--  @description
--  Une règle contient toujours une conclusion que l'on
--  déclenchera systématiquement si c'est possible.
--  @group Regle
package Sys_Exp_P.Regles_P.Sans_Premisse_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Regle_T is new Regle_Abstraite_T with private;
   --  Une règle sans prémisses.

   not overriding
   function Creer
      (
         ID_Regle   : in     ID_Regle_T;
         Conclusion : in     Conclusion_R.Conclusion_Abstraite_T'Class
      )
      return Regle_T;
   --  Crée une règle sans prémisse avec une conclusion.
   --  @param ID_Regle
   --  Le numéro de la règle.
   --  @param Conclusion
   --  La conclusion associer à la règle.
   --  @return La règle construite.

   overriding
   function Verifier_Premisse
      (
         This : in     Regle_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Boolean;
   --  La prémisse a été vérifiée.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return La prémisse de la règle a été vérifiée.

   overriding
   function Creer_Visiteur
      (
         This : in     Regle_T;
         Base : in out Base_Faits_P.Base_De_Faits_T
      )
      return Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class;
   --  Crée un nouveau visiteur de forme.
   --  @param This
   --  La règle actuelle.
   --  @param Base
   --  Le base de faits.
   --  @return Un visiteur de forme.

private

   type Regle_T is new Regle_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Regles_P.Sans_Premisse_P;
