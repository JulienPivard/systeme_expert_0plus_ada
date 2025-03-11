with Ada.Strings.UTF_Encoding;

function Encode
   (
      Item       : String;
      Output_BOM : Boolean := False
   )
   return Ada.Strings.UTF_Encoding.UTF_8_String;
