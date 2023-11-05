private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Les jetons qui seront utilisé pour gérer le contenu du fichier.
--  @description
--  Les jetons qui seront utilisé pour gérer le contenu du fichier.
--  On ne se préoccupe que du contenu du fichier et pas de sa
--  signification. Ce sera le rôle du parseur syntaxique.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Sorte_T is
      (
         Parenthese_Ouvrante_E,
         --  Une parenthèse ouvrante.
         Parenthese_Fermante_E,
         --  Une parenthèse fermante.
         Operateur_Plus_E,
         --  Un opérateur d'addition.
         Operateur_Moins_E,
         --  Un opérateur de soustraction.
         Operateur_Mul_E,
         --  Un opérateur de multiplication.
         Operateur_Div_E,
         --  Un opérateur de division.
         Separateur_E,
         --  Un séparateur léger (,)
         Fin_Expression_E,
         --  Marqueur de fin d'expression (;).
         Fin_Fichier_E,
         --  Marqueur de la fin d'un fichier.
         Identificateur_E,
         --  Un identificateur comme un nom de variable.
         Entier_E,
         --  Une valeur entière. Composée de chiffres.
         Si_E,
         --  Expression d'un test.
         Non_E,
         --  Expression d'une négation.
         Et_E,
         --  Expression d'un et logique.
         Alors_E,
         --  Expression de la conséquence d'un test.
         Egal_E,
         --  Test d'égalité entre deux entités.
         Superieur_E,
         --  Test de supériorité d'une entité sur une autre.
         Inferieur_E,
         --  Test d'infériorité d'une entité sur une autre.
         Superieur_Egal_E,
         --  Test de supériorité égalité d'une entité sur une autre.
         Inferieur_Egal_E,
         --  Test d'infériorité égalité d'une entité sur une autre.
         Different_E,
         --  Test de différence entre deux entités.
         Fait_Booleen_E,
         --  Marqueur de déclarations des noms des fait booléen.
         Fait_Symbolique_E,
         --  Marqueur de déclarations des noms des fait symbolique.
         Fait_Entier_E,
         --  Marqueur de déclarations des noms des fait entier.
         Inconnu_E
         --  Marqueur d'une entité inconnue du lexique.
      );
   --  Les différentes sortes de jetons possibles.

   type Jeton_T is tagged private;
   --  Un jeton qui représentera un objet lu et identifié dans le fichier.

   function Lire_Sorte
      (This : in     Jeton_T)
      return Sorte_T;
   --  Lit la sorte de jeton.
   --  @param This
   --  Le jeton.
   --  @return La sorte de jeton.

   function Lire_Representation
      (This : in     Jeton_T)
      return String;
   --  Lit la représentation du jeton.
   --  @param This
   --  Le jeton.
   --  @return La représentation du jeton.

   function Est_Parenthese_Ouvrante
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est une parenthèse ouvrante.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est une parenthèse ouvrante.

   function Est_Parenthese_Fermante
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est une parenthèse fermante.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est une parenthèse fermante.

   function Est_Superieur
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est supérieur.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est supérieur.

   function Est_Inferieur
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est inférieur.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est inférieur.

   function Est_Operateur_Plus
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un plus.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un plus.

   function Est_Operateur_Moins
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un moins.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un moins.

   function Est_Operateur_Multiplier
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un multiplier.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un multiplier.

   function Est_Operateur_Diviser
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un diviser.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un diviser.

   function Est_Egal
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un égal.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un égal.

   function Est_Fin_Expression
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un point virgule.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un point virgule.

   function Est_Identificateur
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un identificateur.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un identificateur.

   function Est_Si
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un si.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un si.

   function Est_Non
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un non.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un non.

   function Est_Et
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un et.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un et.

   function Est_Alors
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un alors.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un alors.

   function Est_Separateur
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est une virgule.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est une virgule.

   function Est_Inconnu
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est inconnu.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est inconnu.

   function Est_Fin_Fichier
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est fin du fichier.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est fin du fichier.

   function Est_Entier
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un entier.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un entier.

   function Est_Superieur_Egal
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un test supérieur ou égal.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un test supérieur ou égal.

   function Est_Inferieur_Egal
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un test inférieur ou égal.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un test inférieur ou égal.

   function Est_Different
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est un test différent.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est un test différent.

   function Est_Fait_Booleen
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est littéralement fait_booleen.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est littéralement fait_booleen.

   function Est_Fait_Symbolique
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est littéralement fait_symbolique.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est littéralement fait_symbolique.

   function Est_Fait_Entier
      (This : in     Jeton_T)
      return Boolean;
   --  Indique si le jeton est littéralement fait_entier.
   --  @param This
   --  Le jeton.
   --  @return Le jeton est littéralement fait_entier.

private

   package String_Holder_P is new Ada.Containers.Indefinite_Holders
      (Element_Type => String);

   subtype String_T is String_Holder_P.Holder;

   type Jeton_T is tagged
      record
         Sorte          : Sorte_T;
         --  La sorte de jeton.
         Representation : String_T := String_Holder_P.Empty_Holder;
         --  La chaine de caractères associé au jeton.
      end record;

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P;
