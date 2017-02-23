--Realitzar un programa que donada una sequencia d'entrada ens 
--digui quantes paraules hi ha.
--Realitzar tractament sequencial de l'entrada.

with ada.text_IO;
use Ada.Text_IO;

procedure Main is
  contador: natural := 0;
  c: Character := ' ';
begin

   while not End_of_line loop
     
      if c = ' ' then
         while c = ' ' and not End_of_line loop
            get(c);
         end loop;
         
         if not End_of_line then
            contador := contador + 1;
         end if;    
      else
         get(c);
      end if;
      
   end loop;

   put("Hi ha:"&contador'img&" paraules");
end Main;
