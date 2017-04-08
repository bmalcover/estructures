with pboggle,pdiccionari, Ada.Command_Line;
use pdiccionari, Ada.Command_Line;

procedure Main is
   package m_pboggle is new pboggle(4); -- la mida del tauler es generica
   use m_pboggle;
   tauler : ttauler;
   d: diccionari;
begin
   crear(d, Argument(1)); --llegim totes les paraules del fitxer (i de moment les mostram per pantalla)
   tnou(tauler); --cream un tauler nou
   imprimeix_tauler(tauler); --mostram el tauler
end Main;
