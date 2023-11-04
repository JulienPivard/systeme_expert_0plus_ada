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

with Sys_Exp_P.Regles_P.Avec_Premisse_P;
with Sys_Exp_P.Regles_P.Sans_Premisse_P;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_P
   with Spark_Mode => Off
is

   package Conclusion_R renames Sys_Exp_P.Forme_P.Conclusion_P;
   package Premisse_R   renames Sys_Exp_P.Forme_P.Premisse_P;
   package Valeur_R     renames Sys_Exp_P.Valeur_P;

   ---------------------------------------------------------------------------
   function Parser
      (
         This    : in out Syntaxique_T;
         Lexical : in out Lexical_P.Lexical_T
      )
      return Base_De_Regles_T
   is
      G : constant Conclusion_R.Bool_True_P.Conclusion_True_T :=
         Conclusion_R.Bool_True_P.Creer (Nom => "izeib");

      Regles : Base_De_Regles_T := Sys_Exp_P.Regles_P.Sans_Premisse_P.Creer
         (
            ID_Regle   => 1,
            Conclusion => G
         );
   begin
      return Regles;
   end Parser;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_P;
