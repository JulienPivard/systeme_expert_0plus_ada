with AUnit.Assertions;

with Sys_Exp_P.Base_Faits_P;

with Encode;
with Facilites_P;
with Facilites_P.Fait_P;
with Facilites_P.Valeur_P;

with Sys_Exp_P.Base_Faits_P.Extension_P;

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

with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Division_P;
with Sys_Exp_P.Valeur_P;

package body Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P
   with Spark_Mode => Off
is

   Base : aliased Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

   --------------------------------------
   function Test_Egale
      (
         Gauche : in     Nom_Symbole_T;
         Droite : in     Nom_Symbole_T
      )
      return Boolean
   is (Gauche = Droite);
   --------------------------------------

   --------------------------------------
   function Test_Egale
      (
         Gauche : in     Entier_T;
         Droite : in     Entier_T
      )
      return Boolean
   is (Gauche = Droite);
   --------------------------------------

   ---------------------------------------------------------------------------
   overriding
   procedure Set_Up
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);
   begin
      Sys_Exp_P.Base_Faits_P.Extension_P.R_A_Z (Base => Base);
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
      pragma Unreferenced (T);

      Visiteur : constant Visiteur_T := Creer (Base => Base'Access);
   begin
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout " &
               "va bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et pas " &
                     "[" & Visiteur.Message_D_Erreur & "]"
               )
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   package C_Bool_False_R renames Sys_Exp_P.Forme_P.Conclusion_P.Bool_False_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Bool_False
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      C : constant C_Bool_False_R.Conclusion_T :=
         C_Bool_False_R.Creer (Nom => Facilites_P.Creer_Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      C.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => C.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (C.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );

      Bloc_Lire_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Visiteur.Base.all.Trouver (Nom_Fait => C.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Booleen_E,
               Message   => Encode
                  (
                     Item => "Le fait [" & String (C.Lire_Nom) & "] " &
                        "devrait être de type BOOLEEN mais est " &
                        "[" & Fait.Lire_Type'Image & "]"
                  )
            );
         Bloc_Convertir :
         declare
            Fait_Bool : Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T renames
               Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => not Fait_Bool.Lire_Valeur,
                  Message   => Encode
                     (
                        Item => "Le fait [" & String (C.Lire_Nom) & "] " &
                           "devrait être FALSE mais est " &
                           "[" & Fait_Bool.Lire_Valeur'Image & "]"
                     )
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
      pragma Unreferenced (T);

      C : constant C_Bool_True_R.Conclusion_T :=
         C_Bool_True_R.Creer (Nom => Facilites_P.Creer_Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      C.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => C.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (C.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );

      Bloc_Lire_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Visiteur.Base.all.Trouver (Nom_Fait => C.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Booleen_E,
               Message   => Encode
                  (
                     Item => "Le fait [" & String (C.Lire_Nom) & "] " &
                        "devrait être de type BOOLEEN mais est " &
                        "[" & Fait.Lire_Type'Image & "]"
                  )
            );
         Bloc_Convertir :
         declare
            Fait_Bool : Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T renames
               Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Bool.Lire_Valeur,
                  Message   => Encode
                     (
                        Item => "Le fait [" & String (C.Lire_Nom) & "] " &
                           "devrait être TRUE mais est " &
                           "[" & Fait_Bool.Lire_Valeur'Image & "]"
                     )
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Bool_True;
   ---------------------------------------------------------------------------

   package C_Expr_R renames Forme_P.Conclusion_P.Expression_Entiere_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Expression
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Valeur : Sys_Exp_P.Entier_T;

      Visiteur : Visiteur_T := Creer (Base => Base'Access);

      V : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Visiteur.Base.all,
               Valeur => Valeur
            );

      E : constant C_Expr_R.Conclusion_T := C_Expr_R.Creer
         (
            Nom        => Facilites_P.Creer_Nom,
            Expression => V
         );
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );

      Bloc_Lire_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Visiteur.Base.all.Trouver (Nom_Fait => E.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Entier_E,
               Message   => Encode
                  (
                     Item => "Le fait [" & String (E.Lire_Nom) & "] " &
                        "devrait être de type ENTIER mais est " &
                        "[" & Fait.Lire_Type'Image & "]"
                  )
            );
         Bloc_Convertir :
         declare
            Fait_Entier : Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T renames
               Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Entier.Lire_Valeur = Valeur,
                  Message   => Encode
                     (
                        Item => "Le fait [" & String (E.Lire_Nom) & "] " &
                           "devrait être [" & Valeur'Image & "] mais est " &
                           "[" & Fait_Entier.Lire_Valeur'Image & "]"
                     )
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Expression;
   ---------------------------------------------------------------------------

   package C_Fait_Entier_R renames Forme_P.Conclusion_P.Fait_Entier_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Fait_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant C_Fait_Entier_R.Conclusion_T := C_Fait_Entier_R.Creer
         (
            Nom      => Nom,
            Nom_Fait => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      V : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier (Nom => E.Lire_Nom_Fait);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => V);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => Encode
               (
                  Item => "L'autre fait entier " &
                     "[" & String (E.Lire_Nom_Fait) & "] " &
                     "devrait être dans la base"
               )
         );

      Bloc_Lire_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Visiteur.Base.all.Trouver (Nom_Fait => E.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Entier_E,
               Message   => Encode
                  (
                     Item => "Le fait [" & String (E.Lire_Nom) & "] " &
                        "devrait être de type ENTIER mais est " &
                        "[" & Fait.Lire_Type'Image & "]"
                  )
            );
         Bloc_Convertir :
         declare
            Fait_Entier : Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T renames
               Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Entier.Lire_Valeur = V.Lire_Valeur,
                  Message   => Encode
                     (
                        Item => "Le fait [" & String (E.Lire_Nom) & "] " &
                           "devrait être [" & V.Lire_Valeur'Image & "] " &
                           "mais est " &
                           "[" & Fait_Entier.Lire_Valeur'Image & "]"
                     )
               );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Fait_Entier;
   ---------------------------------------------------------------------------

   package C_Sym_Constant_R renames Forme_P.Conclusion_P.Symbole_Constant_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Symbolique_Const
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      S : constant C_Sym_Constant_R.Conclusion_T := C_Sym_Constant_R.Creer
         (
            Nom         => Nom,
            Nom_Symbole => Facilites_P.Creer_Symbole
         );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      S.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => S.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (S.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );

      Bloc_Lire_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Visiteur.Base.all.Trouver (Nom_Fait => S.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Symbolique_E,
               Message   => Encode
                  (
                     Item => "Le fait [" & String (S.Lire_Nom) & "] " &
                        "devrait être de type SYMBOLIQUE mais est " &
                        "[" & Fait.Lire_Type'Image & "]"
                  )
            );
         Bloc_Convertir :
         declare
            Fait_Symbole : Fait_P.Symbolique_P.Fait_Symbolique_T renames
               Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Symbole.Lire_Valeur = S.Lire_Nom_Symbole,
                  Message   => Encode
                     (
                        Item => "Le fait [" & String (S.Lire_Nom) & "] " &
                           "devrait être " &
                           "[" & String (S.Lire_Nom_Symbole) & "] " &
                           "mais est " &
                           "[" & String (Fait_Symbole.Lire_Valeur) & "]"
                     )
                  );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Symbolique_Const;
   ---------------------------------------------------------------------------

   package C_Sym_Fait_R renames Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P;

   ---------------------------------------------------------------------------
   procedure Test_Conclusion_Symbolique_Fait
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      S : constant C_Sym_Fait_R.Conclusion_T := C_Sym_Fait_R.Creer
         (
            Nom      => Nom,
            Nom_Fait => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      F : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => S.Lire_Nom_Fait);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => F);
      S.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => S.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (S.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );

      Bloc_Lire_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Visiteur.Base.all.Trouver (Nom_Fait => S.Lire_Nom);
      begin
         AUnit.Assertions.Assert
            (
               Condition => Fait.Lire_Type = Sys_Exp_P.Symbolique_E,
               Message   => Encode
                  (
                     Item => "Le fait [" & String (S.Lire_Nom) & "] " &
                        "devrait être de type SYMBOLIQUE mais est " &
                        "[" & Fait.Lire_Type'Image & "]"
                  )
            );
         Bloc_Convertir :
         declare
            Fait_Symbole : Fait_P.Symbolique_P.Fait_Symbolique_T renames
               Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T (Fait);
         begin
            AUnit.Assertions.Assert
               (
                  Condition => Fait_Symbole.Lire_Valeur = F.Lire_Valeur,
                  Message   => Encode
                     (
                        Item => "Le fait [" & String (S.Lire_Nom) & "] " &
                           "devrait être [" & String (F.Lire_Valeur) & "] " &
                           "mais est " &
                           "[" & String (Fait_Symbole.Lire_Valeur) & "]"
                     )
                  );
         end Bloc_Convertir;
      end Bloc_Lire_Fait;
   end Test_Conclusion_Symbolique_Fait;
   ---------------------------------------------------------------------------

   package P_Bool_False_R renames Sys_Exp_P.Forme_P.Premisse_P.Bool_False_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Bool_False_Rate
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      P    : constant P_Bool_False_R.Premisse_T                 :=
         P_Bool_False_R.Creer (Nom => Facilites_P.Creer_Nom);
      Fait : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => P.Lire_Nom,
               Valeur => True
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      P.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => P.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (P.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );

      Visiteur.Base.all.Ajouter (Nouvel_Item => Fait);
      P.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => P.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (P.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Bool_False_Rate;
   ---------------------------------------------------------------------------

   package P_Bool_True_R renames Sys_Exp_P.Forme_P.Premisse_P.Bool_True_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Bool_True_Rate
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      P    : constant P_Bool_True_R.Premisse_T                  :=
         P_Bool_True_R.Creer (Nom => Facilites_P.Creer_Nom);
      Fait : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => P.Lire_Nom,
               Valeur => False
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      P.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => P.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (P.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );

      Visiteur.Base.all.Ajouter (Nouvel_Item => Fait);
      P.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => P.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (P.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Bool_True_Rate;
   ---------------------------------------------------------------------------

   package P_Expr_R renames Sys_Exp_P.Forme_P.Premisse_P.Expression_Entiere_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Expression_Rate
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Valeur : Sys_Exp_P.Entier_T;

      Visiteur : Visiteur_T := Creer (Base => Base'Access);

      V : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Visiteur.Base.all,
               Valeur => Valeur
            );

      E : constant P_Expr_R.Premisse_T := P_Expr_R.Creer
         (
            Nom         => Facilites_P.Creer_Nom,
            Comparateur => Test_Egale'Access,
            Expression  => V
         );
      F : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Sys_Exp_P.Fait_P.Entier_P.Creer
            (
               Nom    => E.Lire_Nom,
               Valeur => Valeur + 1
            );
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );

      Visiteur.Base.all.Ajouter (Nouvel_Item => F);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Expression_Rate;
   ---------------------------------------------------------------------------

   package P_Fait_Entier_R renames Sys_Exp_P.Forme_P.Premisse_P.Fait_Entier_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Fait_Entier_Rate
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant P_Fait_Entier_R.Premisse_T := P_Fait_Entier_R.Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egale'Access,
            Nom_Fait    => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      F_1 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier (Nom => E.Lire_Nom);
      F_2 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier_Different
            (
               Nom  => E.Lire_Nom_Fait,
               Fait => F_1
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et pas " &
                     "[" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );

      Visiteur.Base.all.Ajouter (Nouvel_Item => F_1);
      Visiteur.Base.all.Ajouter (Nouvel_Item => F_2);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (
                  Item => "Aucune prémisse ne doit être vérifiée " &
                     "[" & F_1.Lire_Valeur'Image & "] = " &
                     "[" & F_2.Lire_Valeur'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => "Le fait entier [" & String (E.Lire_Nom) & "] " &
               "devrait pas dans la base"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => "Le fait entier [" & String (E.Lire_Nom_Fait) & "] " &
               "devrait pas dans la base"
         );
   end Test_Premisse_Fait_Entier_Rate;
   ---------------------------------------------------------------------------

   package P_Sym_Constant_R renames Forme_P.Premisse_P.Symbole_Constant_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Symbolique_Const_Rate
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      E : constant P_Sym_Constant_R.Premisse_T := P_Sym_Constant_R.Creer
         (
            Nom         => Facilites_P.Creer_Nom,
            Comparateur => Test_Egale'Access,
            Nom_Symbole => Facilites_P.Creer_Symbole
         );
      F : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Sys_Exp_P.Fait_P.Symbolique_P.Creer
            (
               Nom    => E.Lire_Nom,
               Valeur => Facilites_P.Creer_Symbole_Different
                  (Nom => E.Lire_Nom_Symbole)
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );

      Visiteur.Base.all.Ajouter (Nouvel_Item => F);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Symbolique_Const_Rate;
   ---------------------------------------------------------------------------

   package P_Sym_Fait_R renames Sys_Exp_P.Forme_P.Premisse_P.Symbole_Fait_P;

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Symbolique_Fait_Rate
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant P_Sym_Fait_R.Premisse_T := P_Sym_Fait_R.Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egale'Access,
            Nom_Fait    => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      F_1 : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => E.Lire_Nom);
      F_2 : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique_Different
            (
               Nom  => E.Lire_Nom_Fait,
               Fait => F_1
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );

      Visiteur.Base.all.Ajouter (Nouvel_Item => F_1);
      Visiteur.Base.all.Ajouter (Nouvel_Item => F_2);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (
                  Item => "Aucune prémisse ne doit être vérifiée " &
                     "[" & String (F_1.Lire_Valeur) & "] = " &
                     "[" & String (F_2.Lire_Valeur) & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => "Le fait symbolique " &
               "[" & String (E.Lire_Nom) & "] " &
               "devrait pas dans la base"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => "Le fait symbolique " &
               "[" & String (E.Lire_Nom_Fait) & "] " &
               "devrait pas dans la base"
         );
   end Test_Premisse_Symbolique_Fait_Rate;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Bool_False
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      P    : constant P_Bool_False_R.Premisse_T                 :=
         P_Bool_False_R.Creer (Nom => Facilites_P.Creer_Nom);
      Fait : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => P.Lire_Nom,
               Valeur => False
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => Fait);
      P.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Une prémisse doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => P.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen " &
                     "[" & String (P.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Bool_False;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Bool_True
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      P : constant P_Bool_True_R.Premisse_T                     :=
         P_Bool_True_R.Creer (Nom => Facilites_P.Creer_Nom);
      Fait : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Sys_Exp_P.Fait_P.Booleen_P.Creer
            (
               Nom    => P.Lire_Nom,
               Valeur => True
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => Fait);
      P.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Une prémisse doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => P.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen [" & String (P.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Bool_True;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Expression
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Valeur : Sys_Exp_P.Entier_T;

      Visiteur : Visiteur_T := Creer (Base => Base'Access);

      V : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         Facilites_P.Valeur_P.Creer_Valeur
            (
               Base   => Visiteur.Base.all,
               Valeur => Valeur
            );

      E : constant P_Expr_R.Premisse_T := P_Expr_R.Creer
         (
            Nom         => Facilites_P.Creer_Nom,
            Comparateur => Test_Egale'Access,
            Expression  => V
         );
      F : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Sys_Exp_P.Fait_P.Entier_P.Creer
            (
               Nom    => E.Lire_Nom,
               Valeur => Valeur
            );
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => F);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Une prémisse doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Expression;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Fait_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant P_Fait_Entier_R.Premisse_T := P_Fait_Entier_R.Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egale'Access,
            Nom_Fait    => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      F_1 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier (Nom => E.Lire_Nom);
      F_2 : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Sys_Exp_P.Fait_P.Entier_P.Creer
            (
               Nom    => E.Lire_Nom_Fait,
               Valeur => F_1.Lire_Valeur
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => F_1);
      Visiteur.Base.all.Ajouter (Nouvel_Item => F_2);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (
                  Item => "Une prémisse doit être vérifiée " &
                     "[" & F_1.Lire_Valeur'Image & "] = " &
                     "[" & F_2.Lire_Valeur'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => "Le fait entier [" & String (E.Lire_Nom) & "] " &
               "devrait pas dans la base"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => "Le fait entier [" & String (E.Lire_Nom_Fait) & "] " &
               "devrait pas dans la base"
         );
   end Test_Premisse_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Symbolique_Const
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      E : constant P_Sym_Constant_R.Premisse_T := P_Sym_Constant_R.Creer
         (
            Nom         => Facilites_P.Creer_Nom,
            Comparateur => Test_Egale'Access,
            Nom_Symbole => Facilites_P.Creer_Symbole
         );
      F : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Sys_Exp_P.Fait_P.Symbolique_P.Creer
            (
               Nom    => E.Lire_Nom,
               Valeur => E.Lire_Nom_Symbole
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => F);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "une prémisse doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Premisse_Symbolique_Const;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Premisse_Symbolique_Fait
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant P_Sym_Fait_R.Premisse_T := P_Sym_Fait_R.Creer
         (
            Nom         => Nom,
            Comparateur => Test_Egale'Access,
            Nom_Fait    => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      F_1 : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => E.Lire_Nom);
      F_2 : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Sys_Exp_P.Fait_P.Symbolique_P.Creer
            (
               Nom    => E.Lire_Nom_Fait,
               Valeur => F_1.Lire_Valeur
            );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Base.all.Ajouter (Nouvel_Item => F_1);
      Visiteur.Base.all.Ajouter (Nouvel_Item => F_2);
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (
                  Item => "une prémisse doit être vérifiée " &
                     "[" & String (F_1.Lire_Valeur) & "] = " &
                     "[" & String (F_2.Lire_Valeur) & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => "Le fait symbolique " &
               "[" & String (E.Lire_Nom) & "] " &
               "devrait pas dans la base"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => "Le fait symbolique " &
               "[" & String (E.Lire_Nom_Fait) & "] " &
               "devrait pas dans la base"
         );
   end Test_Premisse_Symbolique_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Ajouter_Un_Fait_Booleen
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      F : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
         Facilites_P.Fait_P.Creer_Fait_Booleen (Nom => Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Ajouter_Un_Fait (Fait => F);
      Visiteur.Ajouter_Un_Fait (Fait => F);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => Nom),
            Message   => Encode
               (
                  Item => "Le fait booleen " &
                     "[" & String (Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Rate_Ajouter_Un_Fait_Booleen;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Ajouter_Un_Fait_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      F : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier (Nom => Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Ajouter_Un_Fait (Fait => F);
      Visiteur.Ajouter_Un_Fait (Fait => F);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => Nom),
            Message   => Encode
               (
                  Item => "Le fait entier " &
                     "[" & String (Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Rate_Ajouter_Un_Fait_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Ajouter_Fait_Symbolique
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      F : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Ajouter_Un_Fait (Fait => F);
      Visiteur.Ajouter_Un_Fait (Fait => F);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Une conclusion doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Tout_Va_Bien_E,
            Message   => "Le code d'erreur doit indiquer que tout va " &
               "bien et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur = Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Rate_Ajouter_Fait_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Expr_Entier_Inconnu
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Valeur   : Sys_Exp_P.Entier_T;
      Base_Tmp : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;

      V : constant Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class :=
         Facilites_P.Valeur_P.Creer_Fait
            (
               Base   => Base_Tmp,
               Valeur => Valeur
            );
      pragma Unreferenced (Valeur);
      --  Le contenu du fait créé ne nous intéresse pas pour les tests.

      E : constant C_Expr_R.Conclusion_T := C_Expr_R.Creer
         (
            Nom        => Facilites_P.Creer_Nom,
            Expression => V
         );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Fait_Expression_Inconnu_E,
            Message   => "Le code d'erreur doit indiquer une expression " &
               "inconnue et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
   end Test_Rate_Concl_Expr_Entier_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Expr_Non_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      V : constant Sys_Exp_P.Valeur_P.Fait_P.Valeur_Fait_T :=
         Sys_Exp_P.Valeur_P.Fait_P.Creer (Nom => Nom);

      E : constant C_Expr_R.Conclusion_T := C_Expr_R.Creer
         (
            Nom        => Facilites_P.Creer_Nom,
            Expression => V
         );

      F : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Ajouter_Un_Fait (Fait => F);
      Visiteur.Conclusion_A_Ete_Declenchee := False;
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Incoherence_Fait_E,
            Message   => Encode
               (
                  Item => "Le code d'erreur doit " &
                     "indiquer une incohérence " &
                     "et pas [" & Visiteur.Code_Erreur'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier [" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
   end Test_Rate_Concl_Expr_Non_Entier;
   ---------------------------------------------------------------------------

   package Division_P renames Sys_Exp_P.Valeur_P.Operateur_P.Division_P;

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Expr_Div_Zero
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Valeur : Sys_Exp_P.Entier_T;

      Visiteur : Visiteur_T := Creer (Base => Base'Access);

      V : constant Division_P.Operateur_Div_T := Division_P.Creer
         (
            Valeur_Gauche => Facilites_P.Valeur_P.Creer_Fait_Ou_Constante
                  (
                     Base   => Visiteur.Base.all,
                     Valeur => Valeur
                  ),
            Valeur_Droite =>
               Sys_Exp_P.Valeur_P.Constante_P.Creer (Valeur => 0)
         );
      pragma Unreferenced (Valeur);
      --  Le contenu du fait créé ne nous intéresse pas pour les tests.

      E : constant C_Expr_R.Conclusion_T := C_Expr_R.Creer
         (
            Nom        => Facilites_P.Creer_Nom,
            Expression => V
         );
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Div_Par_Zero_E,
            Message   => Encode
               (
                  Item => "Le code d'erreur doit indiquer div par zéro " &
                     "et pas [" & Visiteur.Code_Erreur'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
   end Test_Rate_Concl_Expr_Div_Zero;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Fait_Entier_Inconnu
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant C_Fait_Entier_R.Conclusion_T := C_Fait_Entier_R.Creer
         (
            Nom      => Nom,
            Nom_Fait => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Fait_Entier_Inconnu_E,
            Message   => "Le code d'erreur doit indiquer un fait " &
               "inconnu et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (Item => "le message d'erreur ne doit pas être vide")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => Encode
               (
                  Item => "L'autre fait entier " &
                     "[" & String (E.Lire_Nom_Fait) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
   end Test_Rate_Concl_Fait_Entier_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Fait_Non_Entier
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant C_Fait_Entier_R.Conclusion_T := C_Fait_Entier_R.Creer
         (
            Nom      => Nom,
            Nom_Fait => Nom
         );

      F : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
         Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => E.Lire_Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Ajouter_Un_Fait (Fait => F);
      Visiteur.Conclusion_A_Ete_Declenchee := False;
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Incoherence_Fait_E,
            Message   => Encode
               (
                  Item => "Le code d'erreur doit " &
                     "indiquer une incohérence " &
                     "et pas [" & Visiteur.Code_Erreur'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et pas " &
                     "[" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait entier " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Rate_Concl_Fait_Non_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Fait_Sym_Inconnu
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant C_Sym_Fait_R.Conclusion_T := C_Sym_Fait_R.Creer
         (
            Nom      => Nom,
            Nom_Fait => Facilites_P.Creer_Nom_Different (Nom => Nom)
         );

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Fait_Symbolique_Inconnu_E,
            Message   => "Le code d'erreur doit indiquer un fait inconnu " &
               "et pas [" & Visiteur.Code_Erreur'Image & "]"
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (Item => "le message d'erreur ne doit pas être vide")
         );
      AUnit.Assertions.Assert
         (
            Condition =>
               not Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Base.all.Contient
               (Nom_Fait => E.Lire_Nom_Fait),
            Message   => Encode
               (
                  Item => "L'autre fait symbolique " &
                     "[" & String (E.Lire_Nom_Fait) & "] " &
                     "ne devrait pas être dans la base"
               )
         );
   end Test_Rate_Concl_Fait_Sym_Inconnu;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Test_Rate_Concl_Fait_Non_Symbolique
      (T : in out Test_Fixt_T)
   is
      pragma Unreferenced (T);

      Nom : constant Sys_Exp_P.Nom_T := Facilites_P.Creer_Nom;

      E : constant C_Sym_Fait_R.Conclusion_T := C_Sym_Fait_R.Creer
         (
            Nom      => Nom,
            Nom_Fait => Nom
         );

      F : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
         Facilites_P.Fait_P.Creer_Fait_Entier (Nom => E.Lire_Nom);

      Visiteur : Visiteur_T := Creer (Base => Base'Access);
   begin
      Visiteur.Ajouter_Un_Fait (Fait => F);
      Visiteur.Conclusion_A_Ete_Declenchee := False;
      E.Accepte (Visiteur => Visiteur);
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Premisse_A_Ete_Verifiee,
            Message   => Encode
               (Item => "Aucune prémisse ne doit être vérifiée")
         );
      AUnit.Assertions.Assert
         (
            Condition => not Visiteur.Conclusion_A_Ete_Declenchee,
            Message   => Encode
               (Item => "Aucune conclusion ne doit être déclenchée")
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Code_Erreur = Incoherence_Fait_E,
            Message   => Encode
               (
                  Item => "Le code d'erreur doit " &
                     "indiquer une incohérence " &
                     "et pas [" & Visiteur.Code_Erreur'Image & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Message_D_Erreur /= Message_Vide,
            Message   => Encode
               (
                  Item => "le message d'erreur doit être vide et " &
                     "pas [" & Visiteur.Message_D_Erreur & "]"
               )
         );
      AUnit.Assertions.Assert
         (
            Condition => Visiteur.Base.all.Contient (Nom_Fait => E.Lire_Nom),
            Message   => Encode
               (
                  Item => "Le fait symbolique " &
                     "[" & String (E.Lire_Nom) & "] " &
                     "devrait être dans la base"
               )
         );
   end Test_Rate_Concl_Fait_Non_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P;
