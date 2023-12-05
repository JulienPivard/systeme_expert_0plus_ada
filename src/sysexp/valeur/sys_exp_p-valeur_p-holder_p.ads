private with Ada.Containers.Indefinite_Holders;

private

--  @private Package interne.
package Sys_Exp_P.Valeur_P.Holder_P is new Ada.Containers.Indefinite_Holders
   (Element_Type => Valeur_Abstraite_T'Class);
