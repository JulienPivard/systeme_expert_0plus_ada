with Sys_Exp_P.Monteur_P.Lorraine_P.Lexical_P;
with Sys_Exp_P.Regles_P;

private with Ada.Containers.Indefinite_Holders;

--  @summary
--  Un analyseur syntaxique de la grammaire Lorraine.
--  @description
--  Un analyseur syntaxique de la grammaire Lorraine.
--  L'analyseur syntaxique va utiliser le parseur lexical
--  pour lire le contenu et va lui donner un sens.
--  @group Monteur
package Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_P
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   type Syntaxique_T is tagged limited private;
   --  Le parseur syntaxique.

   function Parser
      (
         This    : in out Syntaxique_T;
         Lexical : in out Lexical_P.Lexical_T
      )
      return Base_De_Regles_T;
   --  Construit la base de règles à partir d'un parseur lexical.
   --  @param This
   --  Le parseur syntaxique.
   --  @param Lexical
   --  Le parseur lexical.
   --  @return La base de règles.

private

   package Base_De_Regles_P is new Ada.Containers.Indefinite_Holders
      (
         Element_Type => Base_De_Regles_T,
         "="          => Sys_Exp_P.Regles_P."="
      );

   type Syntaxique_T is tagged limited
      record
         null;
      end record;

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_P;
