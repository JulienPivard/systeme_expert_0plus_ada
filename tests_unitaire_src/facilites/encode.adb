with Ada.Strings.UTF_Encoding.Strings;

---------------------------------------------------------------------------
function Encode
   (
      Item       : String;
      Output_BOM : Boolean := False
   )
   return Ada.Strings.UTF_Encoding.UTF_8_String
is
   package UTF_Str_R renames Ada.Strings.UTF_Encoding.Strings;
begin
   return UTF_Str_R.Encode
      (
         Item       => Item,
         Output_BOM => Output_BOM
      );
end Encode;
---------------------------------------------------------------------------
