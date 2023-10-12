--  @summary
--  Squelette de représentation d'une conclusion.
--  @description
--  Les conclusion sont quasiment vide, tout le code réellement
--  utile se trouvera dans le visiteur qui sera passé à la méthode
--  visiter.
--  Les conclusions vont modifier la base de fait si leur
--  contenu est valide. Si un des objets présent dans la conclusion
--  renvoie une erreur alors la conclusion n'est pas valide et donc
--  pas ajoutée à la base de fait.
--
--  Exemple :
--   chercheur ;
--   non thesard ;
--   profession = medecin ;
--   poids = (−46 + 95);
--   fortune parents = (1000/10 ∗ (25 + 80) / 3 +
--       50 ∗ (12 − 5) + 14000 / 2) − 1000 ;
--  @group Forme Conclusion
package Sys_Exp_P.Forme_P.Conclusion_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   type Conclusion_Abstraite_T is abstract new Forme_Abstraite_T with private;
   --  Une forme qui est une conclusion.

private

   type Conclusion_Abstraite_T is abstract new Forme_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P;
