with pparaula, pdiccionari;
use pparaula, pdiccionari;
generic
   mida: natural := 4;

package pboggle is

   type ttauler is private;
   --genera un tauler nou de forma aleatoria
   procedure tnou(t:in out ttauler);
   --mostra el tauler, així podeu fer debug visual
   procedure imprimeix_tauler(t: in ttauler);
   --TODO: implementar
   procedure cerca_paraules(t: in ttauler; dicc: in diccionari);



private
   subtype mida_tauler is natural range 1..mida;
   type ttauler is array(mida_tauler, mida_tauler) of character;
end pboggle;
