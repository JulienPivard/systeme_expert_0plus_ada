--  with GNAT.Source_Info;
with Sys_Exp_P.Fait_P.Symbolique_P;
with Sys_Exp_P.Fait_P.Symbolique_P.Text_IO;
with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Booleen_P.Text_IO;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Entier_P.Text_IO;

with Sys_Exp_P.Base_Faits_P;
with Sys_Exp_P.Base_Faits_P.Text_IO;

separate (Executeur_G)
procedure Executer
   --  (Arguments)
is
   Fait_S : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
      Sys_Exp_P.Fait_P.Symbolique_P.Creer
      (
         Nom    => "je suis symbolique",
         Valeur => "je suis la"
      );
   Fait_B : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
      Sys_Exp_P.Fait_P.Booleen_P.Creer
      (
         Nom    => "se suis booléen",
         Valeur => False
      );
   Fait_E : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
      Sys_Exp_P.Fait_P.Entier_P.Creer
      (
         Nom    => "je suis entier",
         Valeur => 586
      );

   Base : Sys_Exp_P.Base_Faits_P.Base_De_Faits_T;
begin
   Sys_Exp_P.Fait_P.Symbolique_P.Text_IO.Put_Line (Item => Fait_S);
   Sys_Exp_P.Fait_P.Booleen_P.Text_IO.Put_Line (Item => Fait_B);
   Sys_Exp_P.Fait_P.Entier_P.Text_IO.Put_Line (Item => Fait_E);

   Ada.Text_IO.New_Line (Spacing => 1);

   Base.Ajouter (Nouvel_Item => Fait_S);
   Base.Ajouter (Nouvel_Item => Fait_E);
   Base.Ajouter (Nouvel_Item => Fait_B);

   if Base.Contient (Nom_Fait => Fait_S.Lire_Nom) then
      Bloc_Afficher_Fait :
      declare
         Fait : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
            Base.Trouver (Nom_Fait => Fait_S.Lire_Nom);
      begin
         Ada.Text_IO.Put_Line
            (
               Item => "Le fait [" & String (Fait.Lire_Nom) & "] " &
                  "est de type [" & Fait.Lire_Type'Image & "]"
            );
         case Fait.Lire_Type is
            when Sys_Exp_P.Fait_P.Booleen_E =>
               Bloc_Afficher_Booleen :
               declare
                  F_B : constant Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T :=
                     Sys_Exp_P.Fait_P.Booleen_P.Fait_Booleen_T (Fait);
               begin
                  Ada.Text_IO.Put_Line
                     (Item => "Valeur [" & F_B.Lire_Valeur'Image & "]");
               end Bloc_Afficher_Booleen;
            when Sys_Exp_P.Fait_P.Entier_E =>
               Bloc_Afficher_Entier :
               declare
                  F_E : constant Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T :=
                     Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T (Fait);
               begin
                  Ada.Text_IO.Put_Line
                     (Item => "Valeur [" & F_E.Lire_Valeur'Image & "]");
               end Bloc_Afficher_Entier;
            when Sys_Exp_P.Fait_P.Symbole_E =>
               Bloc_Afficher_Symbole :
               declare
                  F_S : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
                     Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T (Fait);
               begin
                  Ada.Text_IO.Put_Line
                     (Item => "Valeur [" & String (F_S.Lire_Valeur) & "]");
               end Bloc_Afficher_Symbole;
         end case;
      end Bloc_Afficher_Fait;
   else
      Ada.Text_IO.Put_Line
         (Item => "Le fait [" & String (Fait_S.Lire_Nom) & "] n'existe pas");
   end if;

   Ada.Text_IO.New_Line (Spacing => 1);

   Sys_Exp_P.Base_Faits_P.Text_IO.Put_Line (Item => Base);
end Executer;
