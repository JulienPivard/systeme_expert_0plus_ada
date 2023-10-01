with Ada.Strings.Hash;

package body Sys_Exp_P.Base_Faits_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Appartient
      (
         This     : in     Base_De_Faits_T;
         Nom_Fait : in     Nom_T
      )
      return Boolean
   is
   begin
      return This.Map_Faits.Contains (Key => Nom_Fait);
   end Appartient;
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
      if This.Appartient (Nom_Fait => Nom_Fait) then
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
      if not This.Appartient (Nom_Fait => Nouvel_Item.Lire_Nom) then
         This.Map_Faits.Insert
            (
               Key      => Nouvel_Item.Lire_Nom,
               New_Item => Nouvel_Item
            );
      else
         Bloc_Detail_Erreur :
         declare
            use type Fait_P.Type_De_Fait_T;

            Fait : constant Fait_P.Fait_Abstrait_T'Class :=
               This.Trouver (Nom_Fait => Nouvel_Item.Lire_Nom);
         begin
            if Fait.Lire_Type = Nouvel_Item.Lire_Type then
               raise E_Fait_Deja_Present with
                  "Le fait [" & String (Nouvel_Item.Lire_Nom) & "] " &
                  "est déjà présent de type [" & Fait.Lire_Type'Image & "]";
            else
               raise E_Fait_Deja_Present with
                  "Le fait [" & String (Nouvel_Item.Lire_Nom) & "] " &
                  "est déjà présent";
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
