with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Visiteur_Forme_P;

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
--     chercheur ;
--     non thesard ;
--     profession = medecin ;
--     poids = (−46 + 95);
--     fortune parents = (1000/10 ∗ (25 + 80) / 3 +
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

   subtype Classe_Visiteur_Forme_T is
      Sys_Exp_P.Visiteur_Forme_P.Visiteur_Forme_Abstrait_T'Class;
   --  N'importe quel visiteur de cette classe.

   procedure Accepte
      (
         This     : in     Conclusion_Abstraite_T;
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

   overriding
   function Image
      (This : in     Conclusion_Abstraite_T)
      return String
   is abstract;
   --  La conclusion convertie en chaine de caractères.
   --  @param This
   --  La conclusion.
   --  @return L'image de la conclusion.

private

   type Conclusion_Abstraite_T is abstract new Forme_Abstraite_T with
      record
         null;
      end record;

end Sys_Exp_P.Forme_P.Conclusion_P;
