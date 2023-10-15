with AUnit.Assertions;

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

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P.Declencheur_P.Test_P;
