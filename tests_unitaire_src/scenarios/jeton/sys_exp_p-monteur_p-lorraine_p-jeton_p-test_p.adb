with Ada.Numerics.Discrete_Random;

with AUnit.Assertions;

with Encode;
with Facilites_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Test_P
   with Spark_Mode => Off
is

   package Sorte_Alea_P is new Ada.Numerics.Discrete_Random
      (Result_Subtype => Sorte_T);

   Generateur_Sorte : Sorte_Alea_P.Generator;

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
   begin
      null;
   end Tear_Down;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                              scénarios                                --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Sorte
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T :=
         Sorte_Alea_P.Random (Gen => Generateur_Sorte);
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Lire_Sorte = Sorte,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );
   end Test_Lire_Sorte;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Lire_Representation
      (T : in out Test_Fixt_T)
   is
      Repr_S : constant String        := Facilites_P.Creer_Chaine;
      Repr_N : constant Nom_T         := Nom_T (Repr_S);
      Repr_L : constant Nom_Symbole_T := Nom_Symbole_T (Repr_S);
      Sorte  : constant Sorte_T :=
         Sorte_Alea_P.Random (Gen => Generateur_Sorte);
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr_S
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Lire_Representation = Repr_S,
            Message   => Encode
               (
                  Item => "La représentation vaut " &
                     "[" & T.Jeton.Lire_Representation & "] " &
                     "mais devrais valoir [" & Repr_S & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Lire_Representation = Repr_N,
            Message   => Encode
               (
                  Item => "La représentation vaut " &
                     "[" & T.Jeton.Lire_Representation & "] " &
                     "mais devrais valoir [" & String (Repr_N) & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Lire_Representation = Repr_L,
            Message   => Encode
               (
                  Item => "La représentation vaut " &
                     "[" & T.Jeton.Lire_Representation & "] " &
                     "mais devrais valoir [" & String (Repr_L) & "]"
               )
         );
   end Test_Lire_Representation;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Parenthese_Ouvrante
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Parenthese_Ouvrante_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Parenthese_Ouvrante,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Parenthese_Ouvrante,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Parenthese_Ouvrante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Parenthese_Fermante
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Parenthese_Fermante_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Parenthese_Fermante,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Parenthese_Fermante,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Parenthese_Fermante;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Operateur_Plus
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Operateur_Plus_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Operateur_Plus,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Operateur_Plus,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Operateur_Plus;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Operateur_Moins
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Operateur_Moins_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Operateur_Moins,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Operateur_Moins,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Operateur_Moins;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Operateur_Mul
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Operateur_Mul_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Operateur_Multiplier,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Operateur_Multiplier,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Operateur_Mul;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Operateur_Div
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Operateur_Div_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Operateur_Diviser,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Operateur_Diviser,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Operateur_Div;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Separateur
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Separateur_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Separateur,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Separateur,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Separateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Fin_Expression
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Fin_Expression_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Fin_Expression,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Fin_Expression,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Fin_Expression;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Fin_Fichier
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Fin_Fichier_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Fin_Fichier,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Fin_Fichier,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Fin_Fichier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Identificateur
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Identificateur_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Identificateur,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Identificateur,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Identificateur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Entier
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Entier_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Entier,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Entier,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Si
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Si_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Si,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Si,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Si;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Non
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Non_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Non,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Non,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Non;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Et
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Et_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Et,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Et,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Et;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Alors
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Alors_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Alors,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Alors,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Alors;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Egal
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Egal_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Egal,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Egal,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Superieur
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Superieur_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Superieur,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Superieur,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Superieur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Inferieur
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Inferieur_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Inferieur,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Inferieur,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Inferieur;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Superieur_Egal
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Superieur_Egal_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Superieur_Egal,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Superieur_Egal,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Superieur_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Inferieur_Egal
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Inferieur_Egal_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Inferieur_Egal,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Inferieur_Egal,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Inferieur_Egal;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Different
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Different_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Different,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Different,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Different;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Fait_Booleen
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Fait_Booleen_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Fait_Booleen,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Fait_Booleen,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Fait_Booleen;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Fait_Symbolique
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Fait_Symbolique_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Fait_Symbolique,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Fait_Symbolique,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Fait_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Fait_Entier
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Fait_Entier_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Fait_Entier,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Fait_Entier,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Est_Inconnu
      (T : in out Test_Fixt_T)
   is
      Repr  : constant String  := Facilites_P.Creer_Chaine;
      Sorte : constant Sorte_T := Inconnu_E;
   begin
      T.Jeton := Creer
         (
            Sorte          => Sorte,
            Representation => Repr
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Jeton.Est_Inconnu,
            Message   => "Le jeton vaut " &
               "[" & T.Jeton.Lire_Sorte'Image & "] " &
               "mais devrais valoir [" & Sorte'Image & "]"
         );

      Boucle_Tester_Les_Autres_Types :
      for S in Sorte_T loop
         if S /= Sorte then
            T.Jeton := Creer
               (
                  Sorte          => S,
                  Representation => Repr
               );
            AUnit.Assertions.Assert
               (
                  Condition => not T.Jeton.Est_Inconnu,
                  Message   => "Le jeton vaut " &
                     "[" & T.Jeton.Lire_Sorte'Image & "] " &
                     "et ne devrais pas valoir [" & S'Image & "]"
               );
         end if;
      end loop Boucle_Tester_Les_Autres_Types;
   end Test_Est_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Creer
      (
         Sorte          : in     Sorte_T;
         Representation : in     String
      )
      return Jeton_T
   is
      D : constant Integer := Representation'First;
      L : constant Integer := Representation'Length;

      Taille : constant Integer :=
         (if L > Taille_Max_Nom then Taille_Max_Nom else L);

      --  Fin de la chaine.
      F_C : constant NB_T := NB_T (Taille);
      --  Fin de la représentation.
      F_R : constant Integer := D + Taille - 1;

      R : constant String_T (1 .. F_C) :=
         String_T (Representation (D .. F_R));
   begin
      return Jeton_T'
         (
            Sorte          => Sorte,
            Representation => String_Holder_P.To_Holder (New_Item => R)
         );
   end Creer;
   ---------------------------------------------------------------------------

begin

   Sorte_Alea_P.Reset (Gen => Generateur_Sorte);

end Sys_Exp_P.Monteur_P.Lorraine_P.Jeton_P.Test_P;
