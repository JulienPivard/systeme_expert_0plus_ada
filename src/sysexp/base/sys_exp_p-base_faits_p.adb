with Ada.Strings.Hash;

with Sys_Exp_P.Fait_P.Booleen_P;
with Sys_Exp_P.Fait_P.Entier_P;
with Sys_Exp_P.Fait_P.Symbolique_P;

package body Sys_Exp_P.Base_Faits_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Contient
      (
         This     : in     Base_De_Faits_T;
         Nom_Fait : in     Nom_T
      )
      return Boolean
   is
   begin
      return This.Map_Faits.Contains (Key => Nom_Fait);
   end Contient;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Trouver
      (
         This     : in     Base_De_Faits_T;
         Nom_Fait : in     Nom_T
      )
      return Fait_Abstrait_T'Class
   is
   begin
      if This.Contient (Nom_Fait => Nom_Fait) then
         return This.Map_Faits.Element (Key => Nom_Fait);
      else
         raise E_Fait_Inconnu with
            "Le fait [" & String (Nom_Fait) & "] n'existe pas";
      end if;
   end Trouver;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   procedure Ajouter
      (
         This        : in out Base_De_Faits_T;
         Nouvel_Item : in     Fait_Abstrait_T'Class
      )
   is
   begin
      if not This.Contient (Nom_Fait => Nouvel_Item.Lire_Nom) then
         This.Map_Faits.Insert
            (
               Key      => Nouvel_Item.Lire_Nom,
               New_Item => Nouvel_Item
            );
      else
         Bloc_Detail_Erreur :
         declare
            Fait : constant Fait_P.Fait_Abstrait_T'Class :=
               This.Trouver (Nom_Fait => Nouvel_Item.Lire_Nom);
         begin
            if Fait.Lire_Type = Nouvel_Item.Lire_Type then
               case Fait.Lire_Type is
                  when Booleen_E    =>
                     Bloc_Err_Bool :
                     declare
                        use type Fait_P.Booleen_P.Fait_Booleen_T;

                        Fait_B : Fait_P.Booleen_P.Fait_Booleen_T renames
                           Fait_P.Booleen_P.Fait_Booleen_T (Fait);
                        Nouv_B : Fait_P.Booleen_P.Fait_Booleen_T renames
                           Fait_P.Booleen_P.Fait_Booleen_T (Nouvel_Item);
                     begin
                        if Fait_B /= Nouv_B then
                           raise E_Fait_Deja_Present with
                              "Le fait booleen " &
                              "[" & String (Nouvel_Item.Lire_Nom) & "] " &
                              "est déjà présent avec la valeur " &
                              "[" & Fait_B.Lire_Valeur'Image & "]";
                        end if;
                     end Bloc_Err_Bool;
                  when Entier_E     =>
                     Bloc_Err_Entier :
                     declare
                        use type Fait_P.Entier_P.Fait_Entier_T;

                        Fait_E : Fait_P.Entier_P.Fait_Entier_T renames
                           Fait_P.Entier_P.Fait_Entier_T (Fait);
                        Nouv_E : Fait_P.Entier_P.Fait_Entier_T renames
                           Fait_P.Entier_P.Fait_Entier_T (Nouvel_Item);
                     begin
                        if Fait_E /= Nouv_E then
                           raise E_Fait_Deja_Present with
                              "Le fait entier " &
                              "[" & String (Nouvel_Item.Lire_Nom) & "] " &
                              "est déjà présent avec la valeur " &
                              "[" & Fait_E.Lire_Valeur'Image & "]";
                        end if;
                     end Bloc_Err_Entier;
                  when Symbolique_E =>
                     Bloc_Err_Symbole :
                     declare
                        use type Fait_P.Symbolique_P.Fait_Symbolique_T;

                        Fait_S : Fait_P.Symbolique_P.Fait_Symbolique_T renames
                           Fait_P.Symbolique_P.Fait_Symbolique_T (Fait);
                        Nouv_S : Fait_P.Symbolique_P.Fait_Symbolique_T renames
                           Fait_P.Symbolique_P.Fait_Symbolique_T (Nouvel_Item);
                     begin
                        if Fait_S /= Nouv_S then
                           raise E_Fait_Deja_Present with
                              "Le fait symbolique " &
                              "[" & String (Nouvel_Item.Lire_Nom) & "] " &
                              "est déjà présent avec la valeur " &
                              "[" & String (Fait_S.Lire_Valeur) & "]";
                        end if;
                     end Bloc_Err_Symbole;
               end case;
            else
               raise E_Fait_Deja_Present with
                  "Le fait [" & String (Nouvel_Item.Lire_Nom) & "] " &
                  "est déjà présent de type [" & Fait.Lire_Type'Image & "]";
            end if;
         end Bloc_Detail_Erreur;
      end if;
   end Ajouter;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   function Hash
      (Nom : in     Nom_T)
      return Ada.Containers.Hash_Type
   is
   begin
      return Ada.Strings.Hash (Key => String (Nom));
   end Hash;
   ---------------------------------------------------------------------------

end Sys_Exp_P.Base_Faits_P;
