with AUnit.Assertions;

with Facilites_P;

with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Symbolique_P;

with Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Fait_Entier_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Constant_P;
with Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P;

with Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;
with Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;
with Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;
with Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Constant_P;
with Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P;

package body Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
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
   procedure Test_Creer
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => not T.Visiteur.Premisse_A_Ete_Verifiee,
            Message   => "Aucune prémisse ne doit etre verifiee"
         );
      AUnit.Assertions.Assert
         (
            Condition => not T.Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => "Aucune conclusion ne doit etre declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va bien"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Message_D_Erreur = Message_Vide,
            Message   => "le message d'erreur doit etre vide"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   package C_Bool_False_R renames Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Bool_False
      (T : in out Test_Fixt_T)
   is
      C : constant C_Bool_False_R.Conclusion_False_T :=
         C_Bool_False_R.Creer (Nom => Facilites_P.Creer_Nom);
   begin
      C.Accepte (Visiteur => T.Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not T.Visiteur.Premisse_A_Ete_Verifiee,
            Message   => "Aucune prémisse ne doit etre verifiee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => "Une conclusion doit etre declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va bien"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Message_D_Erreur = Message_Vide,
            Message   => "le message d'erreur doit etre vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Base.Contient (Nom_Fait => C.Lire_Nom),
            Message   => "Le fait booleen [" & String (C.Lire_Nom) & "] " &
               "devrait etre dans la base"
         );

      Bloc_Lire_Fait :
      declare
         use type Sys_Exp_P.Fait_P.Type_De_Fait_T;

         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            T.Visiteur.Base.Trouver (Nom_Fait => C.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Fait_P.Booleen_E,
               Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                  "devrait etre de type booleen mais est " &
                  "[" & Fait.Lire_Type'Image & "]"
            );
         Bloc_Convertir :
         declare
            Fait_Bool : Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T renames
               Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => not Fait_Bool.Lire_Valeur,
                  Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                     "devrait etre FALSE mais est " &
                     "[" & Fait_Bool.Lire_Valeur'Image & "]"
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Bool_False;
   ---------------------------------------------------------------------------

   package C_Bool_True_R renames Sys_Exp_P.Forme_P.Conclusion_P.Bool_True_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Bool_True
      (T : in out Test_Fixt_T)
   is
      C : constant C_Bool_True_R.Conclusion_True_T :=
         C_Bool_True_R.Creer (Nom => Facilites_P.Creer_Nom);
   begin
      C.Accepte (Visiteur => T.Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not T.Visiteur.Premisse_A_Ete_Verifiee,
            Message   => "Aucune prémisse ne doit etre verifiee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => "Une conclusion doit etre declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va bien"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Message_D_Erreur = Message_Vide,
            Message   => "le message d'erreur doit etre vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Base.Contient (Nom_Fait => C.Lire_Nom),
            Message   => "Le fait booleen [" & String (C.Lire_Nom) & "] " &
               "devrait etre dans la base"
         );

      Bloc_Lire_Fait :
      declare
         use type Sys_Exp_P.Fait_P.Type_De_Fait_T;

         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            T.Visiteur.Base.Trouver (Nom_Fait => C.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Fait_P.Booleen_E,
               Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                  "devrait etre de type booleen mais est " &
                  "[" & Fait.Lire_Type'Image & "]"
            );
         Bloc_Convertir :
         declare
            Fait_Bool : Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T renames
               Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Bool.Lire_Valeur,
                  Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                     "devrait etre TRUE mais est " &
                     "[" & Fait_Bool.Lire_Valeur'Image & "]"
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Bool_True;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Expression
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Conclusion_Expression;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Fait_Entier
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Conclusion_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Symbolique_Const
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Conclusion_Symbolique_Const;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Symbolique_Fait
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Conclusion_Symbolique_Fait;
   ---------------------------------------------------------------------------

   package P_Bool_False_R renames Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Bool_False
      (T : in out Test_Fixt_T)
   is
      C : constant P_Bool_False_R.Premisse_False_T :=
         P_Bool_False_R.Creer (Nom => Facilites_P.Creer_Nom);
   begin
      C.Accepte (Visiteur => T.Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not T.Visiteur.Premisse_A_Ete_Verifiee,
            Message   => "Aucune prémisse ne doit etre verifiee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => "Aucune conclusion doit etre declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va bien"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Message_D_Erreur = Message_Vide,
            Message   => "le message d'erreur doit etre vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Base.Contient (Nom_Fait => C.Lire_Nom),
            Message   => "Le fait booleen [" & String (C.Lire_Nom) & "] " &
               "devrait etre dans la base"
         );

      Bloc_Lire_Fait :
      declare
         use type Sys_Exp_P.Fait_P.Type_De_Fait_T;

         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            T.Visiteur.Base.Trouver (Nom_Fait => C.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Fait_P.Booleen_E,
               Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                  "devrait etre de type booleen mais est " &
                  "[" & Fait.Lire_Type'Image & "]"
            );
         Bloc_Convertir :
         declare
            Fait_Bool : Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T renames
               Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => not Fait_Bool.Lire_Valeur,
                  Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                     "devrait etre FALSE mais est " &
                     "[" & Fait_Bool.Lire_Valeur'Image & "]"
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Premisse_Bool_False;
   ---------------------------------------------------------------------------

   package P_Bool_True_R renames Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Bool_True
      (T : in out Test_Fixt_T)
   is
      C : constant P_Bool_True_R.Premisse_True_T :=
         P_Bool_True_R.Creer (Nom => Facilites_P.Creer_Nom);
   begin
      C.Accepte (Visiteur => T.Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not T.Visiteur.Premisse_A_Ete_Verifiee,
            Message   => "Aucune prémisse ne doit etre verifiee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => "Aucune conclusion doit etre declenchee"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va bien"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Message_D_Erreur = Message_Vide,
            Message   => "le message d'erreur doit etre vide"
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Visiteur.Base.Contient (Nom_Fait => C.Lire_Nom),
            Message   => "Le fait booleen [" & String (C.Lire_Nom) & "] " &
               "devrait etre dans la base"
         );

      Bloc_Lire_Fait :
      declare
         use type Sys_Exp_P.Fait_P.Type_De_Fait_T;

         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            T.Visiteur.Base.Trouver (Nom_Fait => C.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Fait_P.Booleen_E,
               Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                  "devrait etre de type booleen mais est " &
                  "[" & Fait.Lire_Type'Image & "]"
            );
         Bloc_Convertir :
         declare
            Fait_Bool : Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T renames
               Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Bool.Lire_Valeur,
                  Message   => "Le fait [" & String (C.Lire_Nom) & "] " &
                     "devrait etre TRUE mais est " &
                     "[" & Fait_Bool.Lire_Valeur'Image & "]"
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Premisse_Bool_True;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Expression
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Premisse_Expression;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Fait_Entier
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Premisse_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Symbolique_Const
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Premisse_Symbolique_Const;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Symbolique_Fait
      (T : in out Test_Fixt_T)
   is
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "A faire"
         );
   end Test_Premisse_Symbolique_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P;
