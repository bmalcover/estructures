with RandGen;
use RandGen;
with ada.Text_IO;
use Ada.Text_IO;

package body pboggle is

   subtype Capital_Letter is Character range 'A' .. 'Z';

   procedure tnou(t:in out ttauler) is
      idx : Integer;
   begin

      for i in Integer range mida_tauler'RANGE loop
         for j in Integer range mida_tauler'RANGE loop

            idx := generate_random_number (24) + 65; --generam lletres aleatories
            t(i,j):= Capital_Letter'Val(idx);

           end loop;
      end loop;

   end tnou;

   procedure imprimeix_tauler(t: in ttauler) is
   begin
    for i in Integer range mida_tauler'RANGE loop
         for j in Integer range mida_tauler'RANGE loop
            put(t(i,j));

         end loop;
         new_line;
    end loop;

   end imprimeix_tauler;


   --Heu de implementar aquesta funcio cercant totes les paraules possibles
   --en horitzontal i vertical.
   procedure cerca_paraules(t: in ttauler; dicc: in diccionari) is
   begin
      null;
   end cerca_paraules;


end pboggle;
