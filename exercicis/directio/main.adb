with ada.Direct_IO;
with ada.Text_IO; use Ada.Text_IO;
with pparaula; --Dependencia del package paraula.
use pparaula;

  --Crea un fitxer d'acces directe ('mascotes') a partir dels noms de mascotes introduits
  --Aquests han d'estar separats per espai i acabats en punt
  procedure Main is

     package fitxer_paraules is new ada.Direct_IO(Element_Type => tparaula);
     use fitxer_paraules;
     origen : OrigenParaules;
     p : tparaula;
     f : fitxer_paraules.File_Type;
     linia, columna : integer;
 
  begin
     open(origen);
     fitxer_paraules.Create(File => f, Mode => Out_File, Name => "mascotes");
     
     get(origen, p, linia, columna);
     while not buida(p) loop

        fitxer_paraules.Write(File => f,
                              Item => p);


        get(origen, p, linia, columna);
     end loop;

  end Main;
