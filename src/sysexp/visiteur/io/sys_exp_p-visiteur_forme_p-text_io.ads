--  @summary
--  Affiche un visiteur.
--  @description
--  Affiche un visiteur.
--  @group Fait
package Sys_Exp_P.Visiteur_Forme_P.Text_IO
   with
      Pure           => False,
      Preelaborate   => False,
      Elaborate_Body => True,
      Spark_Mode     => Off
is

   procedure Put_Line
      (Item : in     Visiteur_Forme_Abstrait_T'Class);
   --  Affiche le contenu commun d'un visiteur.
   --  @param Item
   --  Le visiteur de forme à afficher.

end Sys_Exp_P.Visiteur_Forme_P.Text_IO;
