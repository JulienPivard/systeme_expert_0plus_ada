with Sys_Exp_P.Fait_P;
with Sys_Exp_P.Fait_P.Entier_P;

package body Sys_Exp_P.Valeur_P.Fait_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Creer
      (Nom : in     Nom_T)
      return Feuille_Fait_T
   is
   begin
      return Feuille_Fait_T'(Nom => Nom_P.To_Holder (New_Item => Nom));
   end Creer;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   overriding
   function Interpreter
      (
         This : in     Feuille_Fait_T;
         Base : in     Base_Faits_P.Base_De_Faits_T
      )
      return Entier_T
   is
      use type Sys_Exp_P.Fait_P.Type_De_Fait_T;

      Valeur : Entier_T;
   begin
      if Base.Contient (Nom_Fait => This.Nom.Element) then
         Bloc_Lecture_Fait :
         declare
            F : constant Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class :=
               Base.Trouver (Nom_Fait => This.Nom.Element);

            Fait : Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T renames
               Sys_Exp_P.Fait_P.Entier_P.Fait_Entier_T (F);
         begin
            if F.Lire_Type = Sys_Exp_P.Fait_P.Entier_E then
               Valeur := Fait.Lire_Valeur;
            else
               raise E_Fait_Nom_Entier;
            end if;
         end Bloc_Lecture_Fait;
      else
         raise E_Fait_Inconnu;
      end if;

      return Valeur;
   end Interpreter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P.Valeur_P.Fait_P;
