with Nom_Holder_P;

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

   function Image
      (This : in     Forme_Abstraite_T)
      return String
   is abstract;
   --  La forme convertie en chaine de caractères.
   --  @param This
   --  La forme.
   --  @return L'image de la forme.

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
