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
--   si malhonnete et fort alors            ...conclusion ;
--   si parents riches et intelligent alors ...conclusion ;
--   si travailleur et intelligent alors    ...conclusion ;
--   si fortune > 10000 alors               ...conclusion ;
--  @group Forme
package Sys_Exp_P.Forme_P.Premisse_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Premisse_Abstraite_T is abstract new Forme_Abstraite_T with private;
   --  Une forme qui est une prémisse.

private

   type Premisse_Abstraite_T is abstract new Forme_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Premisse_P;
