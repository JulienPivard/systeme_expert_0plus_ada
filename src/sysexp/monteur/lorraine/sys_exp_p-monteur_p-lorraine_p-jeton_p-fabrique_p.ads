--  @summary
--  Fabrique de jetons pour la grammaire Lorraine.
--  @description
--  Fabrique de jetons pour la grammaire Lorraine.
--  @group Lorraine
package Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => False,
      Spark_Mode     => Off
is

   function Faire_Parenthese_Ouvrante
      return Jeton_T;
   --  Construit un jeton de parenthèse ouvrante.
   --  @return le jeton associé à la parenthèse ouvrante.

   function Faire_Parenthese_Fermante
      return Jeton_T;
   --  Construit un jeton de parenthèse fermante.
   --  @return le jeton associé à la parenthèse fermante.

   function Faire_Inferieur
      return Jeton_T;
   --  Construit un jeton de signe inférieur.
   --  @return le jeton associé au signe inférieur.

   function Faire_Superieur
      return Jeton_T;
   --  Construit un jeton de signe supérieur.
   --  @return le jeton associé au signe supérieur.

   function Faire_Operateur_Plus
      return Jeton_T;
   --  Construit un jeton d'opérateur plus.
   --  @return le jeton associé à l'opérateur plus.

   function Faire_Operateur_Moins
      return Jeton_T;
   --  Construit un jeton d'opérateur moins.
   --  @return le jeton associé à l'opérateur moins.

   function Faire_Operateur_Multiplier
      return Jeton_T;
   --  Construit un jeton d'opérateur multiplier.
   --  @return le jeton associé à l'opérateur multiplier.

   function Faire_Operateur_Diviser
      return Jeton_T;
   --  Construit un jeton d'opérateur diviser.
   --  @return le jeton associé à l'opérateur diviser.

   function Faire_Egal
      return Jeton_T;
   --  Construit un jeton de signe égal.
   --  @return le jeton associé au signe égal.

   function Faire_Fin_Expression
      return Jeton_T;
   --  Construit un jeton de point virgule.
   --  @return le jeton associé au point virgule.

   function Faire_Si
      return Jeton_T;
   --  Construit un jeton de si.
   --  @return le jeton associé au si.

   function Faire_Non
      return Jeton_T;
   --  Construit un jeton de non.
   --  @return le jeton associé au non.

   function Faire_Et
      return Jeton_T;
   --  Construit un jeton de et.
   --  @return le jeton associé au et.

   function Faire_Alors
      return Jeton_T;
   --  Construit un jeton de alors.
   --  @return le jeton associé au alors.

   function Faire_Separateur
      return Jeton_T;
   --  Construit un jeton de virgule.
   --  @return le jeton associé à la virgule.

   function Faire_Fin_Fichier
      return Jeton_T;
   --  Construit un jeton de fin du fichier.
   --  @return le jeton associé à la fin du fichier.

   function Faire_Superieur_Egal
      return Jeton_T;
   --  Construit un jeton de supérieur ou égal.
   --  @return le jeton associé à un supérieur ou égal.

   function Faire_Inferieur_Egal
      return Jeton_T;
   --  Construit un jeton de inférieur ou égal.
   --  @return le jeton associé à un inférieur ou égal.

   function Faire_Different
      return Jeton_T;
   --  Construit un jeton de différent.
   --  @return le jeton associé à un différent.

   function Faire_Fait_Booleen
      return Jeton_T;
   --  Construit un jeton de faits_booleens.
   --  @return le jeton associé à faits_booleens.

   function Faire_Fait_Symbolique
      return Jeton_T;
   --  Construit un jeton de faits_symboliques.
   --  @return le jeton associé à faits_symboliques.

   function Faire_Fait_Entier
      return Jeton_T;
   --  Construit un jeton de faits_entiers.
   --  @return le jeton associé a faits_entiers.

   function Faire_Entier
      (Representation : in     String)
      return Jeton_T;
   --  Construit un jeton d'entier.
   --  @param Representation
   --  La string qui représente notre valeur entière.
   --  @return le jeton associé à un entier.

   function Faire_Identificateur
      (Representation : in     String)
      return Jeton_T;
   --  Construit un jeton d'identificateur.
   --  @param Representation
   --  La string qui représente notre identificateur.
   --  @return le jeton associé à un identificateur.

   function Faire_Inconnu
      (Representation : in     String)
      return Jeton_T;
   --  Construit un jeton inconnu.
   --  @param Representation
   --  La string qui représente notre jeton inconnu.
   --  @return le jeton associé à un inconnu.

private

   --------------------------------------
   function Creer
      (
         Sorte          : in     Sorte_T;
         Representation : in     String
      )
      return Jeton_T
   is
      (
         Jeton_T'
            (
               Taille         => Representation'Length,
               Sorte          => Sorte,
               Representation => Representation
            )
      );
   --------------------------------------

   Parenthese_O   : constant String := "(";
   Parenthese_F   : constant String := ")";
   Test_Sup       : constant String := ">";
   Test_Inf       : constant String := "<";
   Signe_Plus     : constant String := "+";
   Signe_Moins    : constant String := "-";
   Signe_Mult     : constant String := "*";
   Signe_Div      : constant String := "/";
   Test_Egal      : constant String := "=";
   Fin_Expr       : constant String := ";";
   Test_Si        : constant String := "si";
   Test_Non       : constant String := "non";
   Et_Logique     : constant String := "et";
   Consequence    : constant String := "alors";
   Separateur     : constant String := ",";
   Fin_Fichier    : constant String := "";
   Test_Sup_Egal  : constant String := ">=";
   Test_Inf_Egal  : constant String := "<=";
   Test_Different : constant String := "/=";
   Fait_Bool      : constant String := "faits_booleens";
   Fait_Symbol    : constant String := "faits_symboliques";
   Fait_Entier    : constant String := "faits_entiers";

   --------------------------------------
   function Faire_Parenthese_Ouvrante
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Parenthese_Ouvrante_E,
               Representation => Parenthese_O
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Parenthese_Fermante
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Parenthese_Fermante_E,
               Representation => Parenthese_F
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Inferieur
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Inferieur_E,
               Representation => Test_Inf
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Superieur
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Superieur_E,
               Representation => Test_Sup
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Operateur_Plus
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Operateur_Plus_E,
               Representation => Signe_Plus
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Operateur_Moins
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Operateur_Moins_E,
               Representation => Signe_Moins
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Operateur_Multiplier
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Operateur_Mul_E,
               Representation => Signe_Mult
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Operateur_Diviser
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Operateur_Div_E,
               Representation => Signe_Div
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Egal
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Egal_E,
               Representation => Test_Egal
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Fin_Expression
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Fin_Expression_E,
               Representation => Fin_Expr
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Si
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Si_E,
               Representation => Test_Si
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Non
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Non_E,
               Representation => Test_Non
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Et
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Et_E,
               Representation => Et_Logique
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Alors
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Alors_E,
               Representation => Consequence
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Separateur
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Separateur_E,
               Representation => Separateur
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Fin_Fichier
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Fin_Fichier_E,
               Representation => Fin_Fichier
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Superieur_Egal
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Superieur_Egal_E,
               Representation => Test_Sup_Egal
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Inferieur_Egal
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Inferieur_Egal_E,
               Representation => Test_Inf_Egal
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Different
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Different_E,
               Representation => Test_Different
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Fait_Booleen
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Fait_Booleen_E,
               Representation => Fait_Bool
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Fait_Symbolique
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Fait_Symbolique_E,
               Representation => Fait_Symbol
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Fait_Entier
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Fait_Entier_E,
               Representation => Fait_Entier
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Entier
      (Representation : in     String)
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Entier_E,
               Representation => Representation
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Identificateur
      (Representation : in     String)
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Identificateur_E,
               Representation => Representation
            )
      );
   --------------------------------------

   --------------------------------------
   function Faire_Inconnu
      (Representation : in     String)
      return Jeton_T
   is
      (
         Creer
            (
               Sorte          => Inconnu_E,
               Representation => Representation
            )
      );
   --------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Fabrique_P;
