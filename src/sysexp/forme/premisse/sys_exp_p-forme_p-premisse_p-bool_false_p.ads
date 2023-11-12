--  @summary
--  Une prémisse booléenne fausse.
--  @description
--  Une prémisse booléenne fausse.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Premisse_False_T is new Premisse_Abstraite_T with private;
   --  Une prémisse booléenne dont la valeur est fausse.

   not overriding
   function Creer
      (Nom : in     Nom_T)
      return Premisse_False_T;
   --  Crée une prémisse booléenne dont la valeur est fausse.
   --  @param Nom
   --  Le nom de la prémisse.
   --  @return Une prémisse fausse.

   overriding
   procedure Accepte
      (
         This     : in     Premisse_False_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La prémisse.
   --  @param Visiteur
   --  Le visiteur de forme.

private

   type Premisse_False_T is new Premisse_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
