with Nom_Holder_P;
with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Visiteur_Forme_P;

--  @summary
--  Squelette de représentation d'une prémisse ou d'une conclusion.
--  @description
--  Les prémisses et conclusion sont quasiment vide, tout le code
--  réellement utile se trouvera dans le visiteur qui sera passé
--  à la méthode visiter.
--  @group Forme
package Sys_Exp_P.Forme_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Forme_Abstraite_T is abstract tagged private;
   --  Une conclusion ou une prémisse.

   function Lire_Nom
      (This : in     Forme_Abstraite_T)
      return Nom_T;
   --  Lit le nom de la prémisse ou de la conclusion.
   --  @param This
   --  La forme.
   --  @return Son nom.

   subtype Classe_Visiteur_Forme_T is
      Sys_Exp_P.Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class;
   --  N'importe quel visiteur de cette classe.

   procedure Accepte
      (
         This     : in     Forme_Abstraite_T;
         Base     : in out Base_Faits_P.Base_De_Faits_T;
         Visiteur : in out Classe_Visiteur_Forme_T
      )
   is abstract;
   --  Accepte un visiteur pour étendre les fonctions.
   --  @param This
   --  La prémisse ou la conclusion.
   --  @param Base
   --  La base de faits où on va ajouter les conclusions déclenchées.
   --  @param Visiteur
   --  Le visiteur de forme.

private

   type Forme_Abstraite_T is abstract tagged
      record
         Nom : Nom_Holder_P.Holder;
         --  Le nom de la prémisse ou de la conclusion.
      end record;

   --------------------------------------
   function Lire_Nom
      (This : in     Forme_Abstraite_T)
      return Nom_T
   is (This.Nom.Element);
   --------------------------------------

end Sys_Exp_P.Forme_P;
