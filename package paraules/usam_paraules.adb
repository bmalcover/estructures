with ada.Direct_IO;
with ada.Text_IO; use Ada.Text_IO;
with pparaula;
use pparaula;

procedure Main is
   
 
   origen : OrigenParaules(teclat);
   origen_d : OrigenParaules(f_directe);
   p : tparaula;
   linia, columna : integer;
 
begin
   put("hi!");
   open(origen => origen_d,
        nom    => "mascotes");
   open(origen);
   
   get(origen_d, p, 1);
   put(p);
   get(origen, p,linia, columna);
   put(p);
   get(origen_d, p, 3);
   put(p);
   
   put(Size(origen_d)'img);

end Main;



--   while not buida(p) loop
--  
--        fitxer_paraules.Write(File => f,
--                              Item => p);
--  
--  
--        get(origen, p, linia, columna);
--     end loop;



