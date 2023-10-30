--  @summary
--  Affiche le contenu du moteur d'inférence.
--  @description
--  Affiche le contenu du moteur d'inférence.
--  @group Moteur Inference
package Sys_Exp_P.Moteur_Inference_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Moteur_Inference_T);
   --  Affiche le contenu.
   --  @param Item
   --  Le moteur d'inférence.

end Sys_Exp_P.Moteur_Inference_P.Text_IO;
