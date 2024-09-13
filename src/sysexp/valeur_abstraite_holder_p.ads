with Ada.Containers.Indefinite_Holders;

with Sys_Exp_P.Valeur_P;

package Valeur_Abstraite_Holder_P is new Ada.Containers.Indefinite_Holders
   (
      Element_Type => Sys_Exp_P.Valeur_P.Valeur_Abstraite_T'Class,
      "="          => Sys_Exp_P.Valeur_P."="
   );
--  @private Package interne.
