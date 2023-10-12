private with Ada.Containers.Indefinite_Holders;

with Sys_Exp_P.Visiteur_P;

--  @summary
--  Squelette de représentation d'une prémisse ou d'un conclusion.
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

   subtype Classe_Visiteur_T is Sys_Exp_P.Visiteur_P.Visiteur_Abstrait_T'Class;
   --  N'importe quel visiteur de cette classe.

   procedure Accepte
      (
         This     : in     Forme_Abstraite_T;
         Visiteur : in out Classe_Visiteur_T
      )
   is abstract;
   --  Accepte un visiteur pour étendre le fonctions.
   --  @param This
   --  La prémisse ou la conclusion.
   --  @param Visiteur
   --  Le visiteur de forme.

private

   package Nom_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => Nom_T);

   type Forme_Abstraite_T is abstract tagged
      record
         Nom : Nom_P.Holder;
         --  Le nom de la prémisse ou de la conclusion.
      end record;

   --------------------------------------
   function Lire_Nom
      (This : in     Forme_Abstraite_T)
      return Nom_T
   is (This.Nom.Element);
   --------------------------------------

end Sys_Exp_P.Forme_P;
