with Ada.Containers.Indefinite_Holders;

with Sys_Exp_P;

package Nom_Holder_P is new Ada.Containers.Indefinite_Holders
   (
      Element_Type => Sys_Exp_P.Nom_T,
      "="          => Sys_Exp_P."="
   );
--  @private Package interne.
