-- Ada ens proporciona un package anomenat Command_Line
with Ada.Command_Line,Ada.Text_IO;
use Ada.Command_Line, Ada.Text_IO;

procedure command_line is

begin
   if Argument_Count = 0 then -- Ens diu el nombre d'arguments
    Put_Line("Error - No arguments given.");
  else
    -- Imprimim els arguments
    for Arg in 1 .. Argument_Count loop
      Put_line(Argument(Arg)); --Els arguments son strings

    end loop;
  end if;
end command_line;
