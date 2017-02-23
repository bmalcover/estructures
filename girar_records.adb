--Programa que rep com entrada una sequencia de caràcters acabada en punt i
--imprimeix cada paraula girada.  L'estructura de dades, ha de ser
--un record format per un array i un enter quemarca la longitud.

with Ada.Text_IO; use Ada.Text_IO;

procedure girar_records is
   -- els tipus i variables son locals els passam per parametre
   type paraula is array (0..20) of character;
   type tparaula is record
      p : paraula;
      l : natural;
   end record;

   c : character;

   --declaracions de procediments dins un altre procediment.
   --la visibilitat es local
   procedure llegir_paraula( tp: out tparaula)  is
   begin
      tp.l := 0;
      while c/= ' ' and not End_of_line loop
         tp.p(tp.l) := c;
         tp.l := tp.l + 1;
         get(c);
      end loop;

      if End_Of_Line then
         tp.p(tp.l) := c;
         tp.l := tp.l + 1;
      end if;

   end llegir_paraula;

   procedure imprimir_paraula( tp: in tparaula) is

   begin

      for s in Integer range 0..tp.l-1 loop

         put(tp.p(s));
      end loop;

      New_Line;

   end imprimir_paraula;

   procedure girar_paraula( tp: in out tparaula) is

      i   : integer := 0;
      len : integer;
      aux : character;
   begin

      len := tp.l-1;

      for i in Integer range 0..(tp.l-1)/2 loop
         aux      := tp.p(i);
         tp.p(i)  := tp.p(len);
         tp.p(len):= aux;

         len    := len - 1;
      end loop;

   end girar_paraula;

   par : tparaula;
   final: Boolean := false;

begin
   c := ' ';

   while not End_of_line loop
      get(c);
      llegir_paraula(par);
      girar_paraula(par);
      imprimir_paraula(par);
   end loop;


end girar_records;
