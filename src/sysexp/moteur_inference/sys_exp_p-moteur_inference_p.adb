package body Sys_Exp_P.Moteur_Inference_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (Base_De_Regles : in     Regles_P.Regle_Abstraite_T'Class)
      return Moteur_Inference_T
   is
   begin
      Base.Vider;
      return Moteur_Inference_T'
         (
            Regles => Regle_Holder_P.To_Holder (New_Item => Base_De_Regles),
            Base   => Base'Access
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Analyser_Base_Regles
      (This : in out Moteur_Inference_T)
   is
      Continuer : Boolean;
   begin
      Boucle_Analyser :
      loop
         Continuer := This.Regles.Reference.Iterer (Base => This.Base);
         exit Boucle_Analyser when not Continuer;
      end loop Boucle_Analyser;
   end Analyser_Base_Regles;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Moteur_Inference_P;
