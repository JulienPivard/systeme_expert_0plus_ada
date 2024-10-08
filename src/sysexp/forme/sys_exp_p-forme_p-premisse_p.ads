--  @summary
--  Squelette de représentation d'une prémisse.
--  @description
--  Les prémisses sont quasiment vide, tout le code réellement utile
--  se trouvera dans le visiteur qui sera passé à la méthode visiter.
--  Les prémisses réalisent des tests en  prenant en entré la base
--  de faits. Elles ne font que lire la base de fait sans la
--  modifier.
--
--  Exemple
--      si malhonnete et fort alors            ...conclusion ;
--      si parents riches et intelligent alors ...conclusion ;
--      si travailleur et intelligent alors    ...conclusion ;
--      si fortune > 10000 alors               ...conclusion ;
--  @group Forme Premisse
package Sys_Exp_P.Forme_P.Premisse_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Premisse_Abstraite_T is abstract new Forme_Abstraite_T with private;
   --  Une forme qui est une prémisse.

   type Comparateur_Entier_A is access
      function
         (
            Gauche : in     Entier_T;
            Droite : in     Entier_T
         )
         return Boolean;
   --  Une opération de comparaison entre deux valeurs entières.
   --  @param Gauche
   --  L'entier de gauche.
   --  @param Droite
   --  L'entier de droite.
   --  @return Le tests sur des entiers a réussi.

   type Comparateur_Nom_Symbole_A is access
      function
         (
            Gauche : in     Nom_Symbole_T;
            Droite : in     Nom_Symbole_T
         )
         return Boolean;
   --  Une opération de comparaison entre deux noms symboliques.
   --  @param Gauche
   --  Le nom symbolique de gauche.
   --  @param Droite
   --  Le nom symbolique de droite.
   --  @return Le tests sur les noms symbolique a réussi.

private

   type Premisse_Abstraite_T is abstract new Forme_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Premisse_P;
