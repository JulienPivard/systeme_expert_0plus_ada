with AUnit.Assertions;

with Facilites_P;
--  with Facilites_P.Fait_P;

--  with Sys_Exp_P.Fait_P.Symbolique_P;

package body Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P.Test_P
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
      Nom      : constant Nom_T := Facilites_P.Creer_Nom;
      Nom_Fait : constant Nom_T :=
         Facilites_P.Creer_Nom_Different (Nom => Nom);

      --  Fait : constant Sys_Exp_P.Fait_P.Symbolique_P.Fait_Symbolique_T :=
      --     Facilites_P.Fait_P.Creer_Fait_Symbolique (Nom => Nom_Fait);
   begin
      T.Conclusion := Creer
         (
            Nom      => Nom,
            Nom_Fait => Nom_Fait
         );
      AUnit.Assertions.Assert
         (
            Condition => T.Conclusion.Lire_Nom = Nom,
            Message   => "[" & String (T.Conclusion.Lire_Nom) & "] " &
               "devrait valoir [" & String (Nom) & "]"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Forme_P.Conclusion_P.Symbole_Fait_P.Test_P;
