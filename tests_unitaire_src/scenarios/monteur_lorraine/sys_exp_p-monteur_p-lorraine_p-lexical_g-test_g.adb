with Ada.Characters.Latin_1;
with Ada.Strings.Fixed;

with AUnit.Assertions;

with Sys_Exp_P.Monteur_P.Lorraine_P.Faux_Fichier_P;

with Encode;
with Facilites_P.Entier_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G.Test_G is

   pragma Spark_Mode (Off);

   function Trim
      (
         Source : in     String;
         Side   : in     Ada.Strings.Trim_End := Ada.Strings.Both
      )
      return String
      renames Ada.Strings.Fixed.Trim;

   Fin_Ligne : constant Character := Ada.Characters.Latin_1.LF;

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      null;
   end Set_Up;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Tear_Down
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      null;
   end Tear_Down;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Lexical : constant Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      AUnit.Assertions.Assert
         (
            Condition => Lexical.Lire_Ligne = "",
            Message   => Encode (Item => "Création du parseur lexical")
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_1_Ligne
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Ligne_Attendue : constant String :=
         "faits_booleens = avoir_fait_prison, " &
         "habite_chateau, intelligent, fort, ";

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Fait_Booleen_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "riche, grand, lourd, malhonnete, " &
               "parents_riches, pauvre, travailleur, " &
               Fin_Ligne
         );

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;

         Ligne_Lue : constant String := Lexical.Lire_Ligne;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Fait_Booleen,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Lexical.Lire_Position = 15,
               Message   => "Position lue " &
                  "[" & Lexical.Lire_Position'Image & "] /= [15] attendu"
            );
         AUnit.Assertions.Assert
            (
               Condition => Lexical.Lire_Ancienne_Position = 1,
               Message   => "Ancienne position lue " &
                  "[" & Lexical.Lire_Ancienne_Position'Image & "] /= " &
                  "[1] attendu"
            );
         AUnit.Assertions.Assert
            (
               Condition => Lexical.Lire_Numero_Ligne = Numero_Ligne_G_T'First,
               Message   => Encode
                  (
                     Item => "Numéro ligne lue " &
                        "[" & Lexical.Lire_Numero_Ligne'Image & "] " &
                        "/= [1] attendu"
                  )
            );
         AUnit.Assertions.Assert
            (
               Condition => Ligne_Lue = Ligne_Attendue,
               Message   => "Ligne lue " &
                  "[" & Ligne_Lue & "] /= [" & Ligne_Attendue & "] attendu"
            );
      end Bloc_Tests;
   end Test_Lire_1_Ligne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Parenthese_Ouvrante
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T :=
         Jeton_P.Parenthese_Ouvrante_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "( test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Parenthese_Ouvrante,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[(]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Parenthese_Ouvrante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Parenthese_Fermante
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T :=
         Jeton_P.Parenthese_Fermante_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => ") test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Parenthese_Fermante,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[)]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Parenthese_Fermante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Operateur_Plus
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Operateur_Plus_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "+ test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Operateur_Plus,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[+]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Operateur_Plus;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Operateur_Moins
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Operateur_Moins_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "- test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Operateur_Moins,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[-]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Operateur_Moins;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Operateur_Mul
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Operateur_Mul_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "* test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Operateur_Multiplier,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[*]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Operateur_Mul;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Operateur_Div
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Operateur_Div_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "/ test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Operateur_Diviser,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[/]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Operateur_Div;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Separateur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Separateur_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => ", test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Separateur,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[,]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Separateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Fin_Expression
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Fin_Expression_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "; test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Fin_Expression,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[;]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Fin_Expression;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Fin_Fichier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Fin_Fichier_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "");

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Fin_Fichier,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[Fin de fichier]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Fin_Fichier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Identificateur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Contenu : constant String := Facilites_P.Creer_Chaine;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Identificateur_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => Contenu & " test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Identificateur,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[identificateur]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Representation = Contenu,
               Message   => "Representation du Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Contenu & "]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Identificateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Entier : constant Sys_Exp_P.Entier_T :=
         Facilites_P.Entier_P.Creer_Entier_Positif;

      Contenu         : constant String := Entier'Image;
      Contenu_Attendu : constant String := Trim (Source => Contenu);

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Entier_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => Contenu & " test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Entier,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[entier]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Representation = Contenu_Attendu,
               Message   => Encode
                  (
                     Item => "Représentation du Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                        "[" & Contenu & "]"
                  )
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Si
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Si_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "si test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Si,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[si]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Si;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Non
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Non_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "non test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Non,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[non]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Non;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Et
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Et_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "et test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Et,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[et]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Et;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Alors
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Alors_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "alors test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Alors,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[alors]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Alors;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Egal
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Egal_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "= test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Egal,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[=]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Superieur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Superieur_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "> test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Superieur,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[>]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Superieur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Inferieur
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Inferieur_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "< test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Inferieur,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[<]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Inferieur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Superieur_Egal
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Superieur_Egal_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => ">= test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Superieur_Egal,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[>=]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Superieur_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Inferieur_Egal
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Inferieur_Egal_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "<= test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Inferieur_Egal,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[<=]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Inferieur_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Different
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Different_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "/= test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Different,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[/=]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Fait_Booleen
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Fait_Booleen_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "faits_booleens test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Fait_Booleen,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[faits_booleens]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Fait_Booleen;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Fait_Symbolique
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Fait_Symbolique_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir
         (Contenu => "faits_symboliques test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Fait_Symbolique,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[faits_symboliques]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Fait_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Fait_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Fait_Entier_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => "faits_entiers test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Fait_Entier,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[faits_entiers]"
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jeton_Inconnu
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Contenu : constant String := "@";

      Sorte_Attendue : constant Jeton_P.Sorte_T := Jeton_P.Inconnu_E;

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");
   begin
      Faux_Fichier_P.Remplir (Contenu => Contenu & " test" & Fin_Ligne);

      Bloc_Tests :
      declare
         Jeton_Lu : constant Jeton_T := Lexical.Suivant;
      begin
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendue,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[" & Sorte_Attendue'Image & "]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Est_Inconnu,
               Message   => "Jeton lu " &
                  "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                  "[inconnu]"
            );
         AUnit.Assertions.Assert
            (
               Condition => Jeton_Lu.Lire_Representation = Contenu,
               Message   => Encode
                  (
                     Item => "Représentation du Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] n'est pas " &
                        "[" & Contenu & "]"
                  )
            );

         Bloc_Tests_Non_Jeton :
         declare
            subtype Sorte_Jeton_Non_OK_T is Jeton_P.Sorte_T
               with Static_Predicate =>
                  Sorte_Jeton_Non_OK_T not in Sorte_Attendue;
         begin
            for S in Sorte_Jeton_Non_OK_T loop
               AUnit.Assertions.Assert
                  (
                     Condition => Jeton_Lu.Lire_Sorte /= S,
                     Message   => "Jeton lu " &
                        "[" & Jeton_Lu.Lire_Representation & "] " &
                        "n'est pas [" & S'Image & "]"
                  );
            end loop;
         end Bloc_Tests_Non_Jeton;
      end Bloc_Tests;

      pragma Unreferenced (Lexical);
   end Test_Lire_Jeton_Inconnu;
   ---------------------------------------------------------------------------

   type Sortes_Attendu_T is array (1 .. 232) of Jeton_P.Sorte_T;

   ---------------------------------------------------------------------------
   procedure Test_Lire_Jetons
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      use type Jeton_P.Sorte_T;

      Sortes_Attendue : constant Sortes_Attendu_T := Sortes_Attendu_T'
         (
            1   => Jeton_P.Fait_Booleen_E,
            2   => Jeton_P.Egal_E,
            3   => Jeton_P.Identificateur_E,
            4   => Jeton_P.Separateur_E,
            5   => Jeton_P.Identificateur_E,
            6   => Jeton_P.Separateur_E,
            7   => Jeton_P.Identificateur_E,
            8   => Jeton_P.Separateur_E,
            9   => Jeton_P.Identificateur_E,
            10  => Jeton_P.Separateur_E,
            11  => Jeton_P.Identificateur_E,
            12  => Jeton_P.Separateur_E,
            13  => Jeton_P.Identificateur_E,
            14  => Jeton_P.Separateur_E,
            15  => Jeton_P.Identificateur_E,
            16  => Jeton_P.Separateur_E,
            17  => Jeton_P.Identificateur_E,
            18  => Jeton_P.Separateur_E,
            19  => Jeton_P.Identificateur_E,
            20  => Jeton_P.Separateur_E,
            21  => Jeton_P.Identificateur_E,
            22  => Jeton_P.Separateur_E,
            23  => Jeton_P.Identificateur_E,
            24  => Jeton_P.Separateur_E,
            25  => Jeton_P.Identificateur_E,
            26  => Jeton_P.Separateur_E,
            27  => Jeton_P.Identificateur_E,
            28  => Jeton_P.Separateur_E,
            29  => Jeton_P.Identificateur_E,
            30  => Jeton_P.Fin_Expression_E,
            31  => Jeton_P.Fait_Symbolique_E,
            32  => Jeton_P.Egal_E,
            33  => Jeton_P.Identificateur_E,
            34  => Jeton_P.Fin_Expression_E,
            35  => Jeton_P.Fait_Entier_E,
            36  => Jeton_P.Egal_E,
            37  => Jeton_P.Identificateur_E,
            38  => Jeton_P.Separateur_E,
            39  => Jeton_P.Identificateur_E,
            40  => Jeton_P.Separateur_E,
            41  => Jeton_P.Identificateur_E,
            42  => Jeton_P.Separateur_E,
            43  => Jeton_P.Identificateur_E,
            44  => Jeton_P.Separateur_E,
            45  => Jeton_P.Identificateur_E,
            46  => Jeton_P.Separateur_E,
            47  => Jeton_P.Identificateur_E,
            48  => Jeton_P.Separateur_E,
            49  => Jeton_P.Identificateur_E,
            50  => Jeton_P.Fin_Expression_E,
            51  => Jeton_P.Identificateur_E,
            52  => Jeton_P.Fin_Expression_E,
            53  => Jeton_P.Non_E,
            54  => Jeton_P.Identificateur_E,
            55  => Jeton_P.Fin_Expression_E,
            56  => Jeton_P.Identificateur_E,
            57  => Jeton_P.Egal_E,
            58  => Jeton_P.Identificateur_E,
            59  => Jeton_P.Fin_Expression_E,
            60  => Jeton_P.Identificateur_E,
            61  => Jeton_P.Egal_E,
            62  => Jeton_P.Parenthese_Ouvrante_E,
            63  => Jeton_P.Operateur_Moins_E,
            64  => Jeton_P.Entier_E,
            65  => Jeton_P.Operateur_Plus_E,
            66  => Jeton_P.Entier_E,
            67  => Jeton_P.Parenthese_Fermante_E,
            68  => Jeton_P.Fin_Expression_E,
            69  => Jeton_P.Identificateur_E,
            70  => Jeton_P.Egal_E,
            71  => Jeton_P.Entier_E,
            72  => Jeton_P.Fin_Expression_E,
            73  => Jeton_P.Identificateur_E,
            74  => Jeton_P.Egal_E,
            75  => Jeton_P.Parenthese_Ouvrante_E,
            76  => Jeton_P.Entier_E,
            77  => Jeton_P.Operateur_Div_E,
            78  => Jeton_P.Entier_E,
            79  => Jeton_P.Operateur_Mul_E,
            80  => Jeton_P.Parenthese_Ouvrante_E,
            81  => Jeton_P.Entier_E,
            82  => Jeton_P.Operateur_Plus_E,
            83  => Jeton_P.Entier_E,
            84  => Jeton_P.Parenthese_Fermante_E,
            85  => Jeton_P.Operateur_Div_E,
            86  => Jeton_P.Entier_E,
            87  => Jeton_P.Operateur_Plus_E,
            88  => Jeton_P.Entier_E,
            89  => Jeton_P.Operateur_Mul_E,
            90  => Jeton_P.Parenthese_Ouvrante_E,
            91  => Jeton_P.Entier_E,
            92  => Jeton_P.Operateur_Moins_E,
            93  => Jeton_P.Entier_E,
            94  => Jeton_P.Parenthese_Fermante_E,
            95  => Jeton_P.Operateur_Plus_E,
            96  => Jeton_P.Entier_E,
            97  => Jeton_P.Operateur_Div_E,
            98  => Jeton_P.Entier_E,
            99  => Jeton_P.Parenthese_Fermante_E,
            100 => Jeton_P.Operateur_Moins_E,
            101 => Jeton_P.Entier_E,
            102 => Jeton_P.Fin_Expression_E,
            103 => Jeton_P.Si_E,
            104 => Jeton_P.Identificateur_E,
            105 => Jeton_P.Et_E,
            106 => Jeton_P.Identificateur_E,
            107 => Jeton_P.Alors_E,
            108 => Jeton_P.Identificateur_E,
            109 => Jeton_P.Fin_Expression_E,
            110 => Jeton_P.Si_E,
            111 => Jeton_P.Identificateur_E,
            112 => Jeton_P.Et_E,
            113 => Jeton_P.Identificateur_E,
            114 => Jeton_P.Alors_E,
            115 => Jeton_P.Identificateur_E,
            116 => Jeton_P.Fin_Expression_E,
            117 => Jeton_P.Si_E,
            118 => Jeton_P.Identificateur_E,
            119 => Jeton_P.Et_E,
            120 => Jeton_P.Identificateur_E,
            121 => Jeton_P.Alors_E,
            122 => Jeton_P.Identificateur_E,
            123 => Jeton_P.Fin_Expression_E,
            124 => Jeton_P.Si_E,
            125 => Jeton_P.Identificateur_E,
            126 => Jeton_P.Superieur_E,
            127 => Jeton_P.Identificateur_E,
            128 => Jeton_P.Alors_E,
            129 => Jeton_P.Identificateur_E,
            130 => Jeton_P.Fin_Expression_E,
            131 => Jeton_P.Si_E,
            132 => Jeton_P.Identificateur_E,
            133 => Jeton_P.Egal_E,
            134 => Jeton_P.Identificateur_E,
            135 => Jeton_P.Alors_E,
            136 => Jeton_P.Identificateur_E,
            137 => Jeton_P.Fin_Expression_E,
            138 => Jeton_P.Si_E,
            139 => Jeton_P.Identificateur_E,
            140 => Jeton_P.Egal_E,
            141 => Jeton_P.Identificateur_E,
            142 => Jeton_P.Alors_E,
            143 => Jeton_P.Identificateur_E,
            144 => Jeton_P.Fin_Expression_E,
            145 => Jeton_P.Si_E,
            146 => Jeton_P.Identificateur_E,
            147 => Jeton_P.Egal_E,
            148 => Jeton_P.Identificateur_E,
            149 => Jeton_P.Alors_E,
            150 => Jeton_P.Identificateur_E,
            151 => Jeton_P.Fin_Expression_E,
            152 => Jeton_P.Si_E,
            153 => Jeton_P.Non_E,
            154 => Jeton_P.Identificateur_E,
            155 => Jeton_P.Alors_E,
            156 => Jeton_P.Identificateur_E,
            157 => Jeton_P.Fin_Expression_E,
            158 => Jeton_P.Si_E,
            159 => Jeton_P.Identificateur_E,
            160 => Jeton_P.Alors_E,
            161 => Jeton_P.Non_E,
            162 => Jeton_P.Identificateur_E,
            163 => Jeton_P.Fin_Expression_E,
            164 => Jeton_P.Si_E,
            165 => Jeton_P.Identificateur_E,
            166 => Jeton_P.Alors_E,
            167 => Jeton_P.Non_E,
            168 => Jeton_P.Identificateur_E,
            169 => Jeton_P.Fin_Expression_E,
            170 => Jeton_P.Si_E,
            171 => Jeton_P.Identificateur_E,
            172 => Jeton_P.Alors_E,
            173 => Jeton_P.Identificateur_E,
            174 => Jeton_P.Fin_Expression_E,
            175 => Jeton_P.Si_E,
            176 => Jeton_P.Identificateur_E,
            177 => Jeton_P.Et_E,
            178 => Jeton_P.Identificateur_E,
            179 => Jeton_P.Alors_E,
            180 => Jeton_P.Identificateur_E,
            181 => Jeton_P.Fin_Expression_E,
            182 => Jeton_P.Si_E,
            183 => Jeton_P.Identificateur_E,
            184 => Jeton_P.Superieur_E,
            185 => Jeton_P.Entier_E,
            186 => Jeton_P.Alors_E,
            187 => Jeton_P.Identificateur_E,
            188 => Jeton_P.Fin_Expression_E,
            189 => Jeton_P.Si_E,
            190 => Jeton_P.Identificateur_E,
            191 => Jeton_P.Superieur_E,
            192 => Jeton_P.Entier_E,
            193 => Jeton_P.Alors_E,
            194 => Jeton_P.Identificateur_E,
            195 => Jeton_P.Fin_Expression_E,
            196 => Jeton_P.Si_E,
            197 => Jeton_P.Identificateur_E,
            198 => Jeton_P.Inferieur_E,
            199 => Jeton_P.Entier_E,
            200 => Jeton_P.Alors_E,
            201 => Jeton_P.Identificateur_E,
            202 => Jeton_P.Fin_Expression_E,
            203 => Jeton_P.Si_E,
            204 => Jeton_P.Identificateur_E,
            205 => Jeton_P.Inferieur_E,
            206 => Jeton_P.Entier_E,
            207 => Jeton_P.Alors_E,
            208 => Jeton_P.Identificateur_E,
            209 => Jeton_P.Egal_E,
            210 => Jeton_P.Parenthese_Ouvrante_E,
            211 => Jeton_P.Entier_E,
            212 => Jeton_P.Operateur_Mul_E,
            213 => Jeton_P.Identificateur_E,
            214 => Jeton_P.Parenthese_Fermante_E,
            215 => Jeton_P.Operateur_Moins_E,
            216 => Jeton_P.Entier_E,
            217 => Jeton_P.Fin_Expression_E,
            218 => Jeton_P.Si_E,
            219 => Jeton_P.Identificateur_E,
            220 => Jeton_P.Superieur_E,
            221 => Jeton_P.Identificateur_E,
            222 => Jeton_P.Alors_E,
            223 => Jeton_P.Identificateur_E,
            224 => Jeton_P.Fin_Expression_E,
            225 => Jeton_P.Si_E,
            226 => Jeton_P.Identificateur_E,
            227 => Jeton_P.Superieur_E,
            228 => Jeton_P.Entier_E,
            229 => Jeton_P.Alors_E,
            230 => Jeton_P.Identificateur_E,
            231 => Jeton_P.Fin_Expression_E,
            232 => Jeton_P.Fin_Fichier_E
         );

      Lexical : Lexical_T := Creer (Nom_Fichier => "inutile");

      I : Integer := 1;
   begin
      Faux_Fichier_P.Remplir
         (
            Contenu =>
               "faits_booleens = avoir_fait_prison, " &
               "habite_chateau, intelligent, fort, " &
               Fin_Ligne &
               "riche, grand, lourd, malhonnete, " &
               "parents_riches, pauvre, travailleur, " &
               Fin_Ligne &
               "chercheur, thesard, leger;" &
               Fin_Ligne &
               Fin_Ligne &
               "faits_symboliques = profession; " &
               Fin_Ligne &
               Fin_Ligne &
               "faits_entiers = fortune, fortune_parents, " &
               "poids, taille, travail_par_jour, " &
               Fin_Ligne &
               "combien, palier_richesse; " &
               Fin_Ligne &
               Fin_Ligne &
               "chercheur ; " &
               Fin_Ligne &
               "non thesard ; " &
               Fin_Ligne &
               "profession = medecin; " &
               Fin_Ligne &
               "poids = (-46 + 95) ; " &
               Fin_Ligne &
               "palier_richesse = 10000; " &
               Fin_Ligne &
               "fortune_parents = " &
               Fin_Ligne & Ada.Characters.Latin_1.HT &
               "(1000/10 * (25 + 80) / 3 + 50 * " &
               "(12 - 5) + 14000 /2) - 1000; " &
               Fin_Ligne &
               Fin_Ligne &
               "si malhonnete     et fort        alors riche; " &
               Fin_Ligne &
               "si parents_riches et intelligent alors riche; " &
               Fin_Ligne &
               "si travailleur    et intelligent alors riche; " &
               Fin_Ligne &
               "si fortune > palier_richesse     alors riche; " &
               Fin_Ligne &
               Fin_Ligne &
               "si profession = medecin       alors riche; " &
               Fin_Ligne &
               "si profession = informaticien alors riche; " &
               Fin_Ligne &
               "si profession = fonctionnaire alors pauvre;" &
               Fin_Ligne &
               Fin_Ligne &
               "si non habite_chateau alors pauvre ;" &
               Fin_Ligne &
               Fin_Ligne &
               "si riche             alors non pauvre ;" &
               Fin_Ligne &
               "si pauvre            alors non riche ; " &
               Fin_Ligne &
               "si avoir_fait_prison alors malhonnete ; " &
               Fin_Ligne &
               Fin_Ligne &
               "si grand et lourd alors fort ;" &
               Fin_Ligne &
               Fin_Ligne &
               "si taille > 185 alors grand;" &
               Fin_Ligne &
               "si poids > 95 alors lourd ;" &
               Fin_Ligne &
               "si poids < 50 alors leger ;" &
               Fin_Ligne &
               "si poids < 50 alors fortune = " &
               "(2 * fortune_parents) - 1;" &
               Fin_Ligne &
               Fin_Ligne &
               "si fortune_parents  > palier_richesse " &
               "alors parents_riches;" &
               Fin_Ligne &
               "si travail_par_jour > 8               " &
               "alors travailleur;" &
               Fin_Ligne
         );

      B_Verifier_Jetons :
      for Sorte_Attendu of Sortes_Attendue loop
         Bloc_Verifier_Jeton :
         declare
            Jeton_Lu : constant Jeton_T := Lexical.Suivant;
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Jeton_Lu.Lire_Sorte = Sorte_Attendu,
                  Message   => "Jeton lu " &
                     "[" & Jeton_Lu.Lire_Sorte'Image & "] n'est pas " &
                     "[" & Sorte_Attendu'Image & "] str lue " &
                     "[" & Jeton_Lu.Lire_Representation & "] " &
                     "Case [" & I'Image & "]"
               );
         end Bloc_Verifier_Jeton;

         I := I + 1;
      end loop B_Verifier_Jetons;
   end Test_Lire_Jetons;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_G.Test_G;
