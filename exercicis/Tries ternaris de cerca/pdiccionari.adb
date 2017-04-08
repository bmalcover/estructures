package body pdiccionari is

   --llegim cada paraula del fitxer, vosaltres heu de fer insert a la estructura
   procedure crear(d:out diccionari; fitxer: in string) is
      origen: origenParaules; -- mirar pparaula, ens serveix per llegir de fitxer
      paraula: tparaula;
      l, c : integer;

   begin
      open(origen, fitxer);
      get(origen, paraula, l, c);
      while not buida(paraula) loop
         put(paraula); -- Aquest put l'heu de llevar, nomes serveix per la primera vegada
         get(origen, paraula, l, c);
      end loop;

   close(origen);

   end crear;

   --heu d implementar la funcio de cerca
   function cercar(d: in diccionari; p: in tparaula) return boolean is
   begin
      return True;
   end cercar;


end pdiccionari;
