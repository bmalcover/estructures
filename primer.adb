-- Programa que rep un nombre sencer i torna el menor 
--nombre primer major que aquest nombre.  Ha de existir una
--funcio que ens diu si un nombre és primer. 
with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;

procedure primer is
   resultat: float;
   origen,idx : integer;
   esPrimer: boolean := True;
begin

   get(origen);
   idx := origen -1;

   while esPrimer and idx > 1 loop

      if (origen rem idx) = 0 then

         put("No es primer");
         esPrimer := False;
      else
         idx := idx -1;
      end if;

   end loop;

   if esPrimer then

      put("El nombre "&origen'img&" es primer");
   end if;


end primer;
