with pparaula;
use pparaula;
package pdiccionari is

   type diccionari is private;
   --llegeix cada paraula del fitxer i l'afegeix al vostre trie
   procedure crear(d:out diccionari; fitxer: in string);
   --TODO: implementar
   function cercar(d: in diccionari; p: in tparaula) return boolean;


private

   --Heu de definir com sera el vostre Trie de cerca ternari
   type diccionari is
      record
         null; --TODO by the students
      end record;



end pdiccionari;
