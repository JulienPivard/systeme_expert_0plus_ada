with AUnit.Assertions;

package body Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G is

   pragma Spark_Mode (Off);

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
   begin
      AUnit.Assertions.Assert
         (
            Condition => False,
            Message   => "Creation du parseur lexical"
         );
   end Test_Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Monteur_P.Lorraine_P.Syntaxique_G.Test_G;
