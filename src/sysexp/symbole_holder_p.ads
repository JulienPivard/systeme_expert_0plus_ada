with Ada.Containers.Indefinite_Holders;

with Sys_Exp_P;

package Symbole_Holder_P is new Ada.Containers.Indefinite_Holders
   (
      Element_Type => Sys_Exp_P.Nom_Symbole_T,
      "="          => Sys_Exp_P."="
   );
--  @private Package interne.
