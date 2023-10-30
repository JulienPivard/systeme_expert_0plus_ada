--  @summary
--  Une prémisse booléenne vraie.
--  @description
--  Une prémisse booléenne vraie.
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Premisse_True_T is new Premisse_Abstraite_T with private;
   --  Une prémisse booléenne dont la valeur est vraie.

   function Creer
      (Nom : in     Nom_T)
      return Premisse_True_T;
   --  Crée une prémisse booléenne dont la valeur est vraie.
   --  @param Nom
   --  Le nom de la prémisse.
   --  @return Une prémisse vraie.

   overriding
   procedure Accepte
      (
         This     : in     Premisse_True_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      );
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La prémisse.
   --  @param Visiteur
   --  Le visiteur de forme.

private

   type Premisse_True_T is new Premisse_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;
