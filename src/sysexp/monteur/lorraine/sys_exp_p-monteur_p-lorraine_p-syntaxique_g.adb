with Sys_Exp_P.Valeur_P.Constante_P;
with Sys_Exp_P.Valeur_P.Fait_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Addition_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Division_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Multiplication_P;
with Sys_Exp_P.Valeur_P.Operateur_P.Soustraction_P;

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

with Sys_Exp_P.Comparateurs_P.Instance_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G is

   package Operateur_R renames Sys_Exp_P.Valeur_P.Operateur_P;

   ---------------------------------------------------------------------------
   function Creer
      (Nom_Fichier : in     String)
      return Syntaxique_T
   is
   begin
      return S : Syntaxique_T := Syntaxique_T'
         (
            Parseur_Lexical => Lexical_P.Creer (Nom_Fichier => Nom_Fichier),
            Jeton_Precharge => <>,
            Noms_Faits      => <>
         )
      do
         S.Suivant;
      end return;
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Parser
      (This : in out Syntaxique_T)
      return Base_De_Regles_T
   is
   begin
      This.Faire_Declaration;
      return This.Faire_Base_De_Regles;
   end Parser;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Creer_Exception
      (
         This    : in out Syntaxique_T;
         Message : in     String
      )
   is
      Ligne    : constant String  := This.Parseur_Lexical.Lire_Ligne;
      Position : constant Integer := This.Parseur_Lexical.Lire_Position;
      Ancienne : constant Integer :=
         This.Parseur_Lexical.Lire_Ancienne_Position;
   begin
      raise E_Parse with "Erreur " &
         "[" & Ligne (Ancienne .. Position) & "] ligne " &
         This.Parseur_Lexical.Lire_Numero_Ligne'Image &
         " [" & Message & "] position " & Ancienne'Image;
   end Creer_Exception;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Suivant
      (This : in out Syntaxique_T)
   is
   begin
      This.Jeton_Precharge := This.Parseur_Lexical.Suivant;
   end Suivant;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Faire_Declaration
      (This : in out Syntaxique_T)
   is

   begin
      This.Faire_Declaration_Booleen;
      This.Faire_Declaration_Symbolique;
      This.Faire_Declaration_Entier;
      --  La grammaire Lorraine impose cette ordre dans les déclarations.
   end Faire_Declaration;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Faire_Declaration_Entier
      (This : in out Syntaxique_T)
   is
   begin
      if This.Jeton_Precharge.Est_Fait_Entier then
         This.Suivant;
         This.Faire_Liste_Faits (Race => Entier_E);
      else
         This.Creer_Exception (Message => "attendu: 'faits_entiers'");
      end if;
   end Faire_Declaration_Entier;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Faire_Declaration_Symbolique
      (This : in out Syntaxique_T)
   is
   begin
      if This.Jeton_Precharge.Est_Fait_Symbolique then
         This.Suivant;
         This.Faire_Liste_Faits (Race => Symbolique_E);
      else
         This.Creer_Exception (Message => "attendu: 'faits_symboliques'");
      end if;
   end Faire_Declaration_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Faire_Declaration_Booleen
      (This : in out Syntaxique_T)
   is
   begin
      if This.Jeton_Precharge.Est_Fait_Booleen then
         This.Suivant;
         This.Faire_Liste_Faits (Race => Booleen_E);
      else
         This.Creer_Exception (Message => "attendu: 'faits_booleens'");
      end if;
   end Faire_Declaration_Booleen;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Faire_Liste_Faits
      (
         This : in out Syntaxique_T;
         Race : in     Race_Fait_T
      )
   is
   begin
      if not This.Jeton_Precharge.Est_Egal then
         This.Creer_Exception (Message => "attendu: '='");
      end if;
      This.Suivant;

      B_Parcours_Faits :
      loop
         exit B_Parcours_Faits when This.Jeton_Precharge.Est_Fin_Expression;

         if not This.Jeton_Precharge.Est_Identificateur then
            This.Creer_Exception
               (Message => "attendu: un identificateur ou un '_'");
         end if;
         if This.Noms_Faits.Contains
            (Key => This.Jeton_Precharge.Lire_Representation)
         then
            This.Creer_Exception
               (Message => "un fait doit être déclaré une seule fois");
         end if;

         This.Noms_Faits.Insert
            (
               Key      => This.Jeton_Precharge.Lire_Representation,
               New_Item => Race
            );
         This.Suivant;
         exit B_Parcours_Faits when This.Jeton_Precharge.Est_Fin_Expression;
         if not This.Jeton_Precharge.Est_Separateur then
            This.Creer_Exception (Message => "attendu: ','");
         end if;
         This.Suivant;
      end loop B_Parcours_Faits;
      This.Suivant;
   end Faire_Liste_Faits;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Base_De_Regles
      (This : in out Syntaxique_T)
      return Base_De_Regles_T
   is
      use type Sys_Exp_P.Regles_P.ID_Regle_T;

      Base_De_Regles : Base_De_Regles_P.Holder;

      ID : Sys_Exp_P.Regles_P.ID_Regle_T := Sys_Exp_P.Regles_P.ID_Regle_T'First;
   begin
      Base_De_Regles := Base_De_Regles_P.To_Holder
         (New_Item => This.Faire_Regle (ID => ID));

      B_Faire_Base :
      loop
         exit B_Faire_Base when This.Jeton_Precharge.Est_Fin_Fichier;

         ID := ID + 1;
         if not This.Jeton_Precharge.Est_Fin_Expression then
            This.Creer_Exception (Message => "attendu: ';'");
         end if;
         This.Suivant;

         Bloc_Faire_Base :
         declare
            R : Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class :=
               This.Faire_Regle (ID => ID);
         begin
            R.Ajouter (Successeur => Base_De_Regles.Element);
            Base_De_Regles := Base_De_Regles_P.To_Holder (New_Item => R);
         end Bloc_Faire_Base;
      end loop B_Faire_Base;

      return Base_De_Regles.Element;
   end Faire_Base_De_Regles;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Regle
      (
         This : in out Syntaxique_T;
         ID   : in     Sys_Exp_P.Regles_P.ID_Regle_T
      )
      return Sys_Exp_P.Regles_P.Regle_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      return
         (
            if Jeton.Est_Si then
               This.Faire_Regle_Avec_Premisse (ID => ID)
            else
               This.Faire_Regle_Sans_Premisse (ID => ID)
         );
   end Faire_Regle;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Regle_Sans_Premisse
      (
         This : in out Syntaxique_T;
         ID   : in     Sys_Exp_P.Regles_P.ID_Regle_T
      )
      return Sans_Premisse_R.Regle_T
   is
   begin
      return Sans_Premisse_R.Creer
         (
            ID_Regle   => ID,
            Conclusion => This.Faire_Conclusion
         );
   end Faire_Regle_Sans_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Conclusion
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      if Jeton.Est_Identificateur then
         if This.Noms_Faits.Contains (Key => Jeton.Lire_Representation) then
            case This.Noms_Faits.Element (Key => Jeton.Lire_Representation) is
               when Entier_E     =>
                  return This.Faire_Conclusion_Entiere;
               when Symbolique_E =>
                  return This.Faire_Conclusion_Symbolique;
               when Booleen_E =>
                  return This.Faire_Conclusion_Booleenne;
            end case;
         else
            This.Creer_Exception (Message => "le fait n'a pas été déclare");
         end if;
      elsif Jeton.Est_Non then
         return This.Faire_Conclusion_Booleenne;
      else
         This.Creer_Exception (Message => "attendu : identificateur ou 'non'");
      end if;
   end Faire_Conclusion;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Conclusion_Booleenne
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      This.Suivant;

      if Jeton.Est_Non then
         Bloc_Lire_Nom_Bool :
         declare
            Jeton_ID : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
         begin
         if    This.Jeton_Precharge.Est_Identificateur then
            This.Creer_Exception (Message => "attendu: un fait booléen");
         elsif This.Noms_Faits.Contains
            (Key => This.Jeton_Precharge.Lire_Representation)
         then
            if not (This.Noms_Faits.Element
               (Key => This.Jeton_Precharge.Lire_Representation) = Booleen_E)
            then
               This.Creer_Exception (Message => "le fait n'est pas booléen");
            end if;
         else
            This.Creer_Exception (Message => "le fait n'a pas été declare");
         end if;

         return Conclusion_R.Bool_False_P.Creer
            (Nom => Nom_T (This.Jeton_Precharge.Lire_Representation));
         end Bloc_Lire_Nom_Bool;
      else
         return Conclusion_R.Bool_True_P.Creer
            (Nom => Nom_T (Jeton.Lire_Representation));
      end if;
   end Faire_Conclusion_Booleenne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Conclusion_Symbolique
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      This.Suivant;

      if This.Jeton_Precharge.Est_Egal then
         This.Suivant;
         Bloc_Lire_Nom_Symb :
         declare
            Jeton_ID : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
         begin
         if not This.Jeton_Precharge.Est_Identificateur then
            This.Creer_Exception (Message => "attendu : identificateur");
         end if;

         if This.Noms_Faits.Contains
            (Key => This.Jeton_Precharge.Lire_Representation)
         then
            if This.Noms_Faits.Element
               (Key => This.Jeton_Precharge.Lire_Representation) = Symbolique_E
            then
               return Conclusion_R.Symbole_Fait_P.Creer
                  (
                     Nom      => Nom_T (Jeton.Lire_Representation),
                     Nom_Fait => Nom_T (This.Jeton_Precharge.Lire_Representation)
                  );
            else
               This.Creer_Exception
                  (Message => "le fait n'est pas symbolique");
            end if;
         else
            return Conclusion_R.Symbole_Constant_P.Creer
               (
                  Nom         => Nom_T (Jeton.Lire_Representation),
                  Nom_Symbole => Nom_Symbole_T (This.Jeton_Precharge.Lire_Representation)
               );
         end if;
         end Bloc_Lire_Nom_Symb;
      else
         This.Creer_Exception (Message => "attendu '='");
      end if;
   end Faire_Conclusion_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Conclusion_Entiere
      (This : in out Syntaxique_T)
      return Conclusion_R.Conclusion_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      This.Suivant;
      if This.Jeton_Precharge.Est_Egal then
         This.Suivant;
         return Conclusion_R.Expression_Entiere_P.Creer
            (
               Nom        => Nom_T (Jeton.Lire_Representation),
               Expression => This.Faire_Expression_Entiere
            );
      else
         This.Creer_Exception (Message => "attendu: '='");
      end if;
   end Faire_Conclusion_Entiere;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Regle_Avec_Premisse
      (
         This : in out Syntaxique_T;
         ID   : in     Sys_Exp_P.Regles_P.ID_Regle_T
      )
      return Avec_Premisse_R.Regle_T
   is
      Premisses : Liste_Premisses_T := This.Faire_Condition;

      Regle : Avec_Premisse_R.Regle_T;
   begin
      if not This.Jeton_Precharge.Est_Alors then
         This.Creer_Exception (Message => "attendu: 'alors'");
      end if;
      This.Suivant;

      Regle := Avec_Premisse_R.Creer
         (
            ID_Regle   => ID,
            Premisse   => Premisses.First_Element,
            Conclusion => This.Faire_Conclusion
         );
      Premisses.Delete_First;

      Boucle_Ajouter_Premisses :
      for P : Premisse_R.Premisse_Abstraite_T'Class of Premisses loop
         Regle.Ajouter (Premisse => P);
      end loop Boucle_Ajouter_Premisses;

      return Regle;
   end Faire_Regle_Avec_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Condition
      (This : in out Syntaxique_T)
      return Liste_Premisses_T
   is
      Liste : Liste_Premisses_T;
   begin
      Boucle_Ajouter_Premisse :
      loop
         Liste.Append (New_Item => This.Faire_Premisse);
         This.Suivant;
         exit Boucle_Ajouter_Premisse when not This.Jeton_Precharge.Est_Et;
      end loop Boucle_Ajouter_Premisse;

      return Liste;
   end Faire_Condition;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Premisse
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      if Jeton.Est_Identificateur then
         if This.Noms_Faits.Contains (Key => Jeton.Lire_Representation) then
            case This.Noms_Faits.Element (Key => Jeton.Lire_Representation) is
               when Entier_E     =>
                  return This.Faire_Premisse_Entiere;
               when Symbolique_E =>
                  return This.Faire_Premisse_Symbolique;
               when Booleen_E =>
                  return This.Faire_Premisse_Booleenne;
            end case;
         else
            This.Creer_Exception (Message => "le fait n'a pas été déclare");
         end if;
      elsif Jeton.Est_Non then
         return This.Faire_Premisse_Booleenne;
      else
         This.Creer_Exception (Message => "attendu : identificateur ou 'non'");
      end if;
   end Faire_Premisse;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Premisse_Booleenne
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      This.Suivant;

      if Jeton.Est_Non then
         if    This.Jeton_Precharge.Est_Identificateur then
            This.Creer_Exception (Message => "attendu: un fait booléen");
         elsif This.Noms_Faits.Contains
            (Key => This.Jeton_Precharge.Lire_Representation)
         then
            if not (This.Noms_Faits.Element
               (Key => This.Jeton_Precharge.Lire_Representation) = Booleen_E)
            then
               This.Creer_Exception (Message => "le fait n'est pas booléen");
            end if;
         else
            This.Creer_Exception (Message => "le fait n'a pas été declare");
         end if;

         return Premisse_R.Bool_False_P.Creer
            (Nom => Nom_T (This.Jeton_Precharge.Lire_Representation));
      else
         return Premisse_R.Bool_True_P.Creer
            (Nom => Nom_T (Jeton.Lire_Representation));
      end if;
   end Faire_Premisse_Booleenne;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Premisse_Symbolique
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class
   is
      Jeton_Sym : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      This.Suivant;
      --  la structure d'une prémisse symbolique est :
      --  fait_symbolique (=|/=) (fait_symbolique | constante_symbolique)

      Bloc_Analyse_Comparateur :
      declare
         Jeton_Signe : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
      begin
         if not Jeton_Signe.Est_Un_Signe_De_Comparaison_Symbolique then
            This.Creer_Exception (Message => "attendu : '=' ou '/='");
         end if;
         This.Suivant;

         Bloc_Analyse_Identifier :
         declare
            Jeton_ID : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
         begin
            if not Jeton_ID.Est_Identificateur then
               This.Creer_Exception (Message => "attendu : identificateur");
            end if;

            if This.Noms_Faits.Contains
               (Key => Jeton_ID.Lire_Representation)
            then
               Bloc_Faire_Fait_Symbolique :
               declare
                  Race : constant Race_Fait_T := This.Noms_Faits.Element
                     (Key => Jeton_ID.Lire_Representation);
               begin
                  if Race = Symbolique_E then
                     return Premisse_R.Symbole_Fait_P.Creer
                        (
                           Nom         => Nom_T
                              (Jeton_Sym.Lire_Representation),
                           Comparateur =>
                              (
                                 if    Jeton_Signe.Est_Egal           then
                                    Comparateurs_P.Instance_P.Egale'Access
                                 elsif Jeton_Signe.Est_Different      then
                                    Comparateurs_P.Instance_P.Different'Access
                                 else
                                    null
                              ),
                           Nom_Fait    => Nom_T (Jeton_ID.Lire_Representation)
                        );
                  else
                     This.Creer_Exception ("le fait n'est pas symbolique");
                  end if;
               end Bloc_Faire_Fait_Symbolique;
            else
               return Premisse_R.Symbole_Constant_P.Creer
                  (
                     Nom         => Nom_T (Jeton_Sym.Lire_Representation),
                     Comparateur =>
                        (
                           if    Jeton_Signe.Est_Egal           then
                              Comparateurs_P.Instance_P.Egale'Access
                           elsif Jeton_Signe.Est_Different      then
                              Comparateurs_P.Instance_P.Different'Access
                           else
                              null
                        ),
                     Nom_Symbole => Nom_Symbole_T
                        (Jeton_ID.Lire_Representation)
                  );
            end if;
         end Bloc_Analyse_Identifier;
      end Bloc_Analyse_Comparateur;
   end Faire_Premisse_Symbolique;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Premisse_Entiere
      (This : in out Syntaxique_T)
      return Premisse_R.Premisse_Abstraite_T'Class
   is
      Jeton_Entier : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
   begin
      This.Suivant;

      Bloc_Analyse_Comparateur :
      declare
         Jeton_Signe : constant Jeton_P.Jeton_T := This.Jeton_Precharge;
      begin
         if not Jeton_Signe.Est_Un_Signe_De_Comparaison_Entiere then
            This.Creer_Exception
               (
                  Message => "attendu : " &
                     "'=' ou '/=' ou '<' ou " &
                     "'>' ou '<=' ou '>='"
               );
         end if;
         This.Suivant;

         return Premisse_R.Expression_Entiere_P.Creer
            (
               Nom         => Nom_T (Jeton_Entier.Lire_Representation),
               Comparateur =>
                  (
                     if    Jeton_Signe.Est_Egal           then
                        Comparateurs_P.Instance_P.Egale'Access
                     elsif Jeton_Signe.Est_Different      then
                        Comparateurs_P.Instance_P.Different'Access
                     elsif Jeton_Signe.Est_Superieur      then
                        Comparateurs_P.Instance_P.Superieur'Access
                     elsif Jeton_Signe.Est_Inferieur      then
                        Comparateurs_P.Instance_P.Inferieur'Access
                     elsif Jeton_Signe.Est_Superieur_Egal then
                        Comparateurs_P.Instance_P.Superieur_Egale'Access
                     elsif Jeton_Signe.Est_Inferieur_Egal then
                        Comparateurs_P.Instance_P.Inferieur_Egale'Access
                     else
                        null
                  ),
               Expression  => This.Faire_Expression_Entiere
            );
      end Bloc_Analyse_Comparateur;
   end Faire_Premisse_Entiere;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Expression_Entiere
      (This : in out Syntaxique_T)
      return Valeur_R.Valeur_Abstraite_T'Class
   is
      Jeton : Jeton_P.Jeton_T := This.Jeton_Precharge;

      Partie_Gauche : Valeur_Holder_P.Holder;

      Ni_Plus_Ni_Moins : Boolean;
   begin
      --  Une expression entière commence obligatoirement
      --  par une valeur ou +valeur ou -valeur;
      --  Début d'expression : {+|-}valeur {(+|-)terme}
      if    Jeton.Est_Operateur_Plus  then
         This.Suivant;
         --  On ignore simplement l'opérateur +
         Partie_Gauche := Valeur_Holder_P.To_Holder
            (New_Item => This.Faire_Terme);

      elsif Jeton.Est_Operateur_Moins then
         This.Suivant;
         --  Si il y a un - devant, on transforme en 0 - valeur;
         Bloc_Valeur_Negative :
         declare
            Operation_Moins : constant Valeur_R.Valeur_Abstraite_T'Class :=
               Operateur_R.Soustraction_P.Creer
                  (
                     Valeur_Gauche => Valeur_R.Constante_P.Creer (Valeur => 0),
                     Valeur_Droite => This.Faire_Terme
                  );
         begin
            Partie_Gauche := Valeur_Holder_P.To_Holder
               (New_Item => Operation_Moins);
         end Bloc_Valeur_Negative;

      else
         Partie_Gauche := Valeur_Holder_P.To_Holder
            (New_Item => This.Faire_Terme);
      end if;

      Boucle_Ope_Plus_Moins :
      loop
         Jeton := This.Jeton_Precharge;

         Ni_Plus_Ni_Moins :=
            not Jeton.Est_Operateur_Plus and then
            not Jeton.Est_Operateur_Moins;
         exit Boucle_Ope_Plus_Moins when Ni_Plus_Ni_Moins;

         This.Suivant;
         if    Jeton.Est_Operateur_Plus  then
            Bloc_Operateur_Plus :
            declare
               Operation_Plus : constant Valeur_R.Valeur_Abstraite_T'Class :=
                  Operateur_R.Addition_P.Creer
                     (
                        Valeur_Gauche => Partie_Gauche.Element,
                        Valeur_Droite => This.Faire_Terme
                     );
            begin
               Partie_Gauche := Valeur_Holder_P.To_Holder
                  (New_Item => Operation_Plus);
            end Bloc_Operateur_Plus;

         elsif Jeton.Est_Operateur_Moins then
            Bloc_Operateur_Moins :
            declare
               Operation_Moins : constant Valeur_R.Valeur_Abstraite_T'Class :=
                  Operateur_R.Soustraction_P.Creer
                     (
                        Valeur_Gauche => Partie_Gauche.Element,
                        Valeur_Droite => This.Faire_Terme
                     );
            begin
               Partie_Gauche := Valeur_Holder_P.To_Holder
                  (New_Item => Operation_Moins);
            end Bloc_Operateur_Moins;
         end if;
      end loop Boucle_Ope_Plus_Moins;

      return Partie_Gauche.Element;
   end Faire_Expression_Entiere;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Terme
      (This : in out Syntaxique_T)
      return Valeur_R.Valeur_Abstraite_T'Class
   is
      Facteur_Gauche : Valeur_Holder_P.Holder :=
         Valeur_Holder_P.To_Holder (New_Item => This.Faire_Facteur);

      Jeton : Jeton_P.Jeton_T;

      Ni_Mult_Ni_Div : Boolean;
   begin
      --  la structure d'un terme est : facteur {(x|/) facteur}
      Boucle_Ope_Mult_Div :
      loop
         Jeton := This.Jeton_Precharge;

         Ni_Mult_Ni_Div :=
            not Jeton.Est_Operateur_Multiplier and then
            not Jeton.Est_Operateur_Diviser;
         exit Boucle_Ope_Mult_Div when Ni_Mult_Ni_Div;

         This.Suivant;
         if    Jeton.Est_Operateur_Multiplier then
            Bloc_Operateur_Multiplier :
            declare
               Operation_Mult : constant Valeur_R.Valeur_Abstraite_T'Class :=
                  Operateur_R.Multiplication_P.Creer
                     (
                        Valeur_Gauche => Facteur_Gauche.Element,
                        Valeur_Droite => This.Faire_Facteur
                     );
            begin
               Facteur_Gauche := Valeur_Holder_P.To_Holder
                  (New_Item => Operation_Mult);
            end Bloc_Operateur_Multiplier;

         elsif Jeton.Est_Operateur_Diviser    then
            Bloc_Operateur_Diviser :
            declare
               Operation_Div : constant Valeur_R.Valeur_Abstraite_T'Class :=
                  Operateur_R.Division_P.Creer
                     (
                        Valeur_Gauche => Facteur_Gauche.Element,
                        Valeur_Droite => This.Faire_Facteur
                     );
            begin
               Facteur_Gauche := Valeur_Holder_P.To_Holder
                  (New_Item => Operation_Div);
            end Bloc_Operateur_Diviser;
         end if;
      end loop Boucle_Ope_Mult_Div;

      return Facteur_Gauche.Element;
   end Faire_Terme;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Faire_Facteur
      (This : in out Syntaxique_T)
      return Valeur_R.Valeur_Abstraite_T'Class
   is
      Jeton : constant Jeton_P.Jeton_T := This.Jeton_Precharge;

      Facteur : Valeur_Holder_P.Holder;
   begin
      --  un facteur est composé d'une constante entière,
      --  d'un fait entier ou d'une expression entière entre parenthèse.
      if    Jeton.Est_Entier then
         Facteur := Valeur_Holder_P.To_Holder
            (
               New_Item => Valeur_R.Constante_P.Creer
                  (Valeur => Entier_T'Value (Jeton.Lire_Representation))
            );

      elsif Jeton.Est_Parenthese_Ouvrante then
         This.Suivant;
         Facteur := Valeur_Holder_P.To_Holder
            (New_Item => This.Faire_Expression_Entiere);
         if not This.Jeton_Precharge.Est_Parenthese_Fermante then
            This.Creer_Exception (Message => "Attendu : ')'");
         end if;

      elsif This.Noms_Faits.Contains (Key => Jeton.Lire_Representation) then
         Bloc_Faire_Fait_Symbolique :
         declare
            Race : constant Race_Fait_T := This.Noms_Faits.Element
               (Key => Jeton.Lire_Representation);
         begin
            if Race = Entier_E then
               Facteur := Valeur_Holder_P.To_Holder
                  (
                     New_Item => Valeur_R.Fait_P.Creer
                        (Nom => Nom_T (Jeton.Lire_Representation))
                  );
            else
               This.Creer_Exception ("Le fait n'est pas entier");
            end if;
         end Bloc_Faire_Fait_Symbolique;

      else
         This.Creer_Exception (Message => "Attendu : entier ou '('");
      end if;
      This.Suivant;

      return Facteur.Element;
   end Faire_Facteur;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G;
