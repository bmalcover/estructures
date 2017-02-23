--Programa que rep com entrada una seqüència de caràcters acabada en punt i 
--imprimeix cada paraula girada. 
with Ada.Text_IO; use Ada.Text_IO;
procedure girar_paraules is
   -- els tipus i variables son locals els passam per parametre
   type paraula is array (0..20) of character; 
   c : Character;
    
   --declaracions de procediments dins un altre procediment.
   --la visibilitat es local
   procedure llegir_paraula( p: out paraula; l: out natural)  is
   begin
      l := 0;
      while c/= ' ' and not End_of_line loop
         p(l) := c;
         l := l + 1;
         get(c);
      end loop;
   end llegir_paraula;

   procedure imprimir_paraula( p: in paraula; length: in natural) is

   begin

      for s in Integer range 0..length-1 loop

         put(p(s));
      end loop;

      New_Line;

   end imprimir_paraula;

   procedure girar_paraula( p: in out paraula; length: in natural) is

      i   : integer := 0;
      len : integer;
      aux : character;
   begin

      len := length-1;

      for i in Integer range 0..(length-1)/2 loop
         aux    := p(i);
         p(i)   := p(len);
         p(len) := aux;

         len    := len - 1;
      end loop;

   end girar_paraula;

   par : paraula;
   final: Boolean := false;
   l : natural;

begin
   c := ' ';

   while not End_of_line loop
      get(c);
      llegir_paraula(par, l);
      girar_paraula(par, l);
      imprimir_paraula(par, l);
   end loop;


end girar_paraules;
