with Ada.Strings.Hash;

package body Sys_Exp_P
   with Spark_Mode => Off
is

   ---------------------------------------------------------------------------
   function Hash
      (Nom : in     Nom_T)
      return Ada.Containers.Hash_Type
   is
   begin
      return Ada.Strings.Hash (Key => String (Nom));
   end Hash;
   ---------------------------------------------------------------------------

   ---------------------------------------------------------------------------
   --                             Partie privée                             --
   ---------------------------------------------------------------------------

end Sys_Exp_P;
