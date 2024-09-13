with Sys_Exp_P.Fait_P;

with Ada.Containers.Indefinite_Hashed_Maps;

package Map_Fait_P is new Ada.Containers.Indefinite_Hashed_Maps
   (
      Key_Type        => Sys_Exp_P.Nom_T,
      Element_Type    => Sys_Exp_P.Fait_P.Fait_Abstrait_T'Class,
      Hash            => Sys_Exp_P.Hash,
      Equivalent_Keys => Sys_Exp_P."=",
      "="             => Sys_Exp_P.Fait_P."="
   );
--  @private Package interne.
