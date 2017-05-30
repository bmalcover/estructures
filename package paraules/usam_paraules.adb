with ada.Direct_IO;
with ada.Text_IO; use Ada.Text_IO;
with pparaula;
use pparaula;

procedure usam_paraules is
   
 
   origen : OrigenParaules(teclat);
   origen_d : OrigenParaules(f_directe);
   p : tparaula;
   linia, columna : integer;
 
begin
  
   open(origen => origen_d,
        nom    => "mascotes");
   open(origen);
   
   get(origen_d, p, 1);
   put(p);
   get(origen_d, p, 2);
   put(p);
   put_line("Llegim paraules del teclat mentre no escrivim: exit");
   get(origen, p,linia, columna);
   
   while toString(p) /= "exit" loop
      put(p);
      get(origen, p, linia, columna);
   end loop;
  

   put(Size(origen_d)'img);

end usam_paraules;

