with Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G;
with Sys_Exp_P.Visiteur_Forme_P.Fabrique_Interface_P;

private with Ada.Containers.Indefinite_Doubly_Linked_Lists;
private with Ada.Containers.Indefinite_Hashed_Maps;
private with Ada.Containers.Indefinite_Holders;
private with Ada.Strings.Hash;

private with Sys_Exp_P.Forme_P.Conclusion_P;
private with Sys_Exp_P.Forme_P.Premisse_P;
private with Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P;
private with Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P;
private with Sys_Exp_P.Regles_P.Avec_Premisse_P;
private with Sys_Exp_P.Regles_P.Sans_Premisse_P;
private with Sys_Exp_P.Valeur_P;

generic

   with package Lexical_P is new Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G
      (others => <>);

--  @summary
--  Un analyseur syntaxique de la grammaire Lorraine.
--  @description
--  Un analyseur syntaxique de la grammaire Lorraine.
--  L'analyseur syntaxique va utiliser le parseur lexical
--  pour lire le contenu et va lui donner un sens.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G is

   pragma Elaborate_Body;

   type Syntaxique_T (<>) is tagged limited private;
   --  Le parseur syntaxique.

   package Fabrique_R renames Visiteur_Forme_P.Fabrique_Interface_P;

   function Creer
      (
         Nom_Fichier : in     String;
         Fabrique    : in     Fabrique_R.Fabrique_Interface_T'Class
      )
      return Syntaxique_T;
   --  Crée un parseur syntaxique.
   --  @param Nom_Fichier
   --  Le nom du fichier à parser.
   --  @param Fabrique
   --  La fabrique de visiteurs.
   --  @return Le parseur syntaxique.

   function Parser
      (This : in out Syntaxique_T)
      return Base_De_Regles_T;
   --  Construit la base de règles à partir d'un parseur lexical.
   --  @param This
   --  Le parseur syntaxique.
   --  @return La base de règles.

private

   subtype ID_Regle_T is Sys_Exp_P.Regles_P.ID_Regle_T;

   package Map_Fait_P is new Ada.Containers.Indefinite_Hashed_Maps
      (
         Key_Type        => String,
         Element_Type    => Type_De_Fait_T,
         Hash            => Ada.Strings.Hash,
         Equivalent_Keys => Standard."="
      );

   package Fabrique_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Fabrique_R.Fabrique_Interface_T'Class,
         "="          => Fabrique_R."="
      );

   type Syntaxique_T is tagged limited
      record
         Parseur_Lexical : Lexical_P.Lexical_T;
         --  Le parseur lexical.
         Jeton_Precharge : Jeton_P.Jeton_T :=
            Jeton_P.Fabrique_P.Faire_Inconnu (Representation => "");
         --  Le dernier jeton lu depuis le parseur lexical.
         Noms_Faits      : Map_Fait_P.Map;
         --  Nom des faits associé à leur types.
         Fabrique        : Fabrique_Holder_P.Holder;
         --  La fabrique de visiteur de formes à donner aux règles.
      end record;

   package Conclusion_R    renames Sys_Exp_P.Forme_P.Conclusion_P;
   package Premisse_R      renames Sys_Exp_P.Forme_P.Premisse_P;
   package Valeur_R        renames Sys_Exp_P.Valeur_P;
   package Avec_Premisse_R renames Sys_Exp_P.Regles_P.Avec_Premisse_P;
   package Sans_Premisse_R renames Sys_Exp_P.Regles_P.Sans_Premisse_P;

   procedure Creer_Exception
      (
         This    : in out Syntaxique_T;
         Message : in     String
      );
   --  Crée une exception de parsage du fichier.
   --  @param This
   --  Le parseur syntaxique.
   --  @param Message
   --  Le message à remonter.
   pragma No_Return (Creer_Exception);

   function Jeton_Est_Un_Nom_De_Fait
      (This : in     Syntaxique_T)
      return Boolean;
   --  Le Jeton préchargé par le parseur est il un nom de fait.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Le jeton préchargé est un nom de fait.

   function Lire_Type_Jeton_Fait
      (This : in     Syntaxique_T)
      return Type_De_Fait_T;
   --  Lit le type de fait du Jeton préchargé par le parseur.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Le type de fait jeton préchargé.

   procedure Suivant
      (This : in out Syntaxique_T);
   --  Passe au jeton lexical suivant.
   --  @param This
   --  Le parseur syntaxique.

   procedure Faire_Declaration
      (This : in out Syntaxique_T);
   --  Ajoute les faits à la liste de fait avec le type associé.
   --  @param This
   --  Le parseur syntaxique.

   procedure Faire_Declaration_Entier
      (This : in out Syntaxique_T);
   --  Ajoute les faits à la liste de fait avec le type entier.
   --  @param This
   --  Le parseur syntaxique.

   procedure Faire_Declaration_Symbolique
      (This : in out Syntaxique_T);
   --  Ajoute les faits à la liste de fait avec le type symbolique.
   --  @param This
   --  Le parseur syntaxique.

   procedure Faire_Declaration_Booleen
      (This : in out Syntaxique_T);
   --  Ajoute les faits à la liste de fait avec le type booléen.
   --  @param This
   --  Le parseur syntaxique.

   procedure Faire_Liste_Faits
      (
         This : in out Syntaxique_T;
         Race : in     Type_De_Fait_T
      );
   --  Ajout les noms de faits à la liste de fait avec le type de fait
   --  auquel il est associé.
   --  @param This
   --  Le parseur syntaxique.
   --  @param Race
   --  La type de fait à enregistrer.

   function Faire_Base_De_Regles
      (This : in out Syntaxique_T)
      return Base_De_Regles_T;
   --  Construit la base de règles à partir du parseur lexical.
   --  @param This
   --  Le parseur syntaxique.
   --  @return La base de règles.

   function Faire_Regle
      (
         This : in out Syntaxique_T;
         ID   : in     ID_Regle_T
      )
      return Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class;
   --  Construit une règle avec ou sans prémisses.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une règle avec ou sans prémisses.

   function Faire_Regle_Sans_Premisse
      (
         This : in out Syntaxique_T;
         ID   : in     ID_Regle_T
      )
      return Sans_Premisse_R.Regle_T;
   --  Construit une règle sans prémisses.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une règle sans prémisses.

   function Faire_Conclusion
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class;
   --  Construit une conclusion.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une conclusion.

   function Faire_Conclusion_Booleenne
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class;
   --  Construit une conclusion booléenne.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une conclusion booléenne.

   function Faire_Conclusion_Symbolique
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class;
   --  Construit une conclusion symbolique.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une conclusion symbolique.

   function Faire_Conclusion_Entiere
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class;
   --  Construit une conclusion d'expression entière.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une conclusion d'expression entière.

   function Faire_Regle_Avec_Premisse
      (
         This : in out Syntaxique_T;
         ID   : in     ID_Regle_T
      )
      return Avec_Premisse_R.Regle_T;
   --  Construit une règle avec prémisses.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une règle avec prémisses.

   package Liste_P is new Ada.Containers.Indefinite_Doubly_Linked_Lists
      (
         Element_Type => Premisse_R.Premisse_Abstraite_T'Class,
         "="          => Premisse_R."="
      );

   subtype Liste_Premisses_T is Liste_P.List;

   function Faire_Condition
      (This : in out Syntaxique_T)
      return Liste_Premisses_T;
   --  Construit la liste des prémisses de la condition.
   --  @param This
   --  Le parseur syntaxique.
   --  @return La liste des prémisses de la condition.

   function Faire_Premisse
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class;
   --  Construit une prémisse.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une prémisse.

   function Faire_Premisse_Booleenne
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class;
   --  Construit une prémisse booléenne.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une prémisse booléenne.

   function Faire_Premisse_Symbolique
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class;
   --  Construit une prémisse symbolique.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une prémisse symbolique.

   function Faire_Premisse_Entiere
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class;
   --  Construit une prémisse entière.
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une prémisse entière.

   function Faire_Expression_Entiere
      (This : in out Syntaxique_T)
      return Valeur_R.Valeur_Abstraite_T'Class;
   --  Construit une expression entière.
   --  La structure d'une expression : [+|-] Terme {(+|-) Terme}
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une expression entière.

   function Faire_Terme
      (This : in out Syntaxique_T)
      return Valeur_R.Valeur_Abstraite_T'Class;
   --  Construit un des termes de l'expression entière.
   --  la structure d'un terme est : facteur {(x|/) facteur}
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une expression entière.

   function Faire_Facteur
      (This : in out Syntaxique_T)
      return Valeur_R.Valeur_Abstraite_T'Class;
   --  Construit un des termes de l'expression entière.
   --  La structure d'un facteur est :
   --  (Fait_Entier|Fait_symbolique|(Expression_Entiere))
   --  @param This
   --  Le parseur syntaxique.
   --  @return Une expression entière.

   package Valeur_Holder_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Valeur_R.Valeur_Abstraite_T'Class,
         "="          => Valeur_R."="
      );

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G;
