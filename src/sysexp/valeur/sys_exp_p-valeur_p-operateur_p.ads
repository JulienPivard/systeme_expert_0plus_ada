private with Sys_Exp_P.Valeur_P.Holder_P;

--  @summary
--  Représentation d'une opération.
--  @description
--  Opération abstraite entre deux valeurs. Toutes les opérations
--  d'addition, soustraction, division, multiplication...
--  descendront de cette classe.
--  @group Valeur
package Sys_Exp_P.Valeur_P.Operateur_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   subtype Symbole_T is Character;
   --  Le symbole associé à l'opération. Utilisé pour l'affichage.

   type Operateur_Abstrait_T is abstract new Valeur_Abstraite_T with private;
   --  Représentation abstraite d'une opération.

   not overriding
   function Creer
      (
         Valeur_Gauche : in     Valeur_Abstraite_T'Class;
         Valeur_Droite : in     Valeur_Abstraite_T'Class
      )
      return Operateur_Abstrait_T
   is abstract;
   --  Crée un opérateur à partir de valeurs.
   --  @param Valeur_Gauche
   --  La valeur gauche.
   --  @param Valeur_Droite
   --  La valeur gauche.
   --  @return L'opérateur.

   not overriding
   function Lire_Symbole
      (This : in     Operateur_Abstrait_T)
      return Symbole_T
   is abstract;
   --  Lit le symbole associé à l'opération pour l'affichage.
   --  @param This
   --  L'opérateur.
   --  @return Le symbole de l'opération.

   overriding
   function Image
      (This : in     Operateur_Abstrait_T)
      return String
   is abstract;
   --  Image d'un opérateur.
   --  @param This
   --  La valeur d'un opérateur.
   --  @return L'image d'un opérateur.

private

   type Operateur_Abstrait_T is abstract new Valeur_Abstraite_T with
      record
         Gauche : Holder_P.Holder;
         Droite : Holder_P.Holder;
      end record;

   function Lire_Element_Gauche
      (This : in     Operateur_Abstrait_T'Class)
      return Valeur_Abstraite_T'Class;
   --  Lit l'opérande gauche de l'opération.
   --  @param This
   --  L'opérateur.
   --  @return L'opérande gauche.

   function Lire_Element_Droite
      (This : in     Operateur_Abstrait_T'Class)
      return Valeur_Abstraite_T'Class;
   --  Lit l'opérande droite de l'opération.
   --  @param This
   --  L'opérateur.
   --  @return L'opérande droite.

end Sys_Exp_P.Valeur_P.Operateur_P;
