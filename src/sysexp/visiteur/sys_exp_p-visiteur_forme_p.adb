with Ada.Exceptions;
with Ada.Strings.Fixed;

package body Sys_Exp_P.Visiteur_Forme_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   procedure Ajouter_Un_Fait
      (
         This : in out Visiteur_Forme_Abstrait_T'Class;
         Fait : in     Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class
      )
   is
   begin
      This.Base.Ajouter (Nouvel_Item => Fait);
   exception
      when E : Sys_Exp_P.Base_Faits_P.E_Fait_Deja_Present =>
         This.Code_Erreur := Incoherence_Fait_E;
         Ada.Strings.Fixed.Move
            (
               Source => Ada.Exceptions.Exception_Message (X => E),
               Target => This.Message_D_Erreur,
               Drop   => Ada.Strings.Right
            );
   end Ajouter_Un_Fait;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Visiteur_Forme_P;
