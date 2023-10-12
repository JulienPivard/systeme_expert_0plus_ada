package body Sys_Exp_P.Valeur_P.Operateur_P.Addition_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   overriding
   function Creer
      (
         Valeur_Gauche : in     Valeur_Abstraite_T'Class;
         Valeur_Droite : in     Valeur_Abstraite_T'Class
      )
      return Operateur_Plus_T
   is
   begin
      return Operateur_Plus_T'
         (
            Gauche => Holder_P.To_Holder (New_Item => Valeur_Gauche),
            Droite => Holder_P.To_Holder (New_Item => Valeur_Droite)
         );
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Interpreter
      (
         This : in     Operateur_Plus_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T
   is
   begin
      return
         This.Lire_Element_Gauche.Interpreter (Base => Base)
         +
         This.Lire_Element_Droite.Interpreter (Base => Base);
   end Interpreter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Lire_Symbole
      (This : in     Operateur_Plus_T)
      return Symbole_T
   is
      pragma Unreferenced (This);
   begin
      return '+';
   end Lire_Symbole;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Operateur_P.Addition_P;
