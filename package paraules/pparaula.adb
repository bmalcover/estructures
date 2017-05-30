
-- Implementacio del package que defineix el tipus tparaula i les
-- operacions que es poden realitzar amb ell.

package body pparaula is

   separadors : constant array (1..12) of character := ('.',',',';',' ','[',']','!','?','-','(',')','&');

   function Is_Separador(c: in character) return boolean is

   begin

      for i in separadors'Range loop
         if separadors(i) = c then return true; end if;
      end loop;

      return false;

   end Is_Separador;


   -- Procediment 'local' del package.
   procedure botar_blancs(c : in out character) is
   begin
      while c = ' ' loop
         get(c);
      end loop;
   end botar_blancs;



   -- Procediment per poder llegir del teclat
   procedure get(p : out tparaula; lletra : in out character; l, c: in out integer) is
      i : tllargaria := tllargaria'FIRST;
   begin

      while Is_Separador(lletra) loop
         -- Nomes s'ha de llegir si hi ha qualque cosa
         get(lletra);
         c := c + 1;
      end loop;
      -- llegir les lletres de la paraula
      while not Is_Separador(lletra) and i < tllargaria'LAST loop
         i := i+1;
         p.lletres(i) := lletra;
         if End_Of_Line then
            lletra := ' ';
         else

            get(lletra);
            c := c +1;
         end if;

      end loop;
      p.llargaria := i;
   end get;

   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula) is
      i : rang_lletres:= rang_lletres'FIRST;
   begin
      if not buida(p) then
         while i < p.llargaria loop
            put(p.lletres(i));
            i := i+1;
         end loop;
         put(p.lletres(i));
      end if;
      New_Line;
   end put;

   -- Procediment per escriure a un fitxer de text
   procedure put(f : in out Ada.Text_IO.File_Type; p : in tparaula) is
      i : rang_lletres:= rang_lletres'FIRST;
   begin
      if not buida(p) then
         while i < p.llargaria loop
            put(f, p.lletres(i));
            i := i+1;
         end loop;
         put(f, p.lletres(i));
      end if;
   end put;

   -- Funcio per comparar dues paraules i determinar si són iguals
   function "=" (a, b : in tparaula) return boolean is
      resultat : boolean;
      i : rang_lletres;
   begin
      if a.llargaria /= b.llargaria then
         resultat := false;
      else
         i := rang_lletres'FIRST;
         while i < a.llargaria and a.lletres(i) = b.lletres(i) and i < MAXIM loop
            i := i + 1;
         end loop;
         resultat := a.lletres(i) = b.lletres(i);
      end if;
      return resultat;
   end "=";
   -- Funcio per saber la llargaria d'una paraula.
   function llargaria(p : in tparaula) return tllargaria is
   begin
      return p.llargaria;
   end llargaria;

   -- Funcio que indica si la paraula està buida
   function buida(p : in tparaula) return boolean is
   begin

      return p.llargaria = tllargaria'FIRST;
   end buida;

   -- Funcio que torna la lletra que es troba a una posicio determinada
   -- d'una paraula.
   function caracter(p : in tparaula; posicio : in rang_lletres) return character is
   begin
      if posicio <= p.llargaria then
         return p.lletres(posicio);
      else
         return ' ';
      end if;
   end caracter;

   -- Procediment que copia una paraula. Es un procediment util per
   -- utilitzar aquest package PParaules i genrrics.
   procedure copiar(desti : out tparaula; origen : in tparaula) is
   begin
      desti := origen;
   end copiar;


   function toString(p: in tparaula) return  String is
      str: string(1..p.llargaria);
   begin

      for i in Integer range 1..p.llargaria loop
         str(i) := p.lletres(i);
      end loop;
      return str;
   end toString;

   ----------------------------------------------------------------------
   -- Implementacio de les definicions relacionades amb OrigenParaules --
   ----------------------------------------------------------------------

   -- Procediment per tractar amb les paraules llegides del teclat
   procedure open(origen : out OrigenParaules) is
   begin

      origen.lletra := ' ';
      origen.l := 0;
      origen.c := 0;
      --botar_blancs(origen.lletra);
   end open;

   -- Procediment per tractar amb les paraules llegides del fitxer nom
   procedure open(origen : out OrigenParaules; nom : in String) is
   begin
      if origen.to = f_seq then
         open(origen.fitxer, In_File, nom);

         -- botar_blancs 'ad hoc' pel cas de llegir de fitxer
         origen.lletra := ' ';
         while not End_Of_File(origen.fitxer) and origen.lletra = ' ' loop
            get(origen.fitxer, origen.lletra);
         end loop;

         -- Si s'ha arribat a fi de fitxer i no s'ha llegit res interessant
         -- s'ha acabat i es posa '.' a origen.lletra
         if End_Of_File(origen.fitxer) and origen.lletra = ' ' then
            origen.lletra := '.';
         end if;
      elsif origen.to = f_directe then
         fitxer_paraules.Open(File => origen.fitxer_d, Mode => in_File, Name => nom);
      end if;
      origen.l := 0;
      origen.c := 0;

--     exception
--        when Name_Error => create(origen.fitxer, In_File, nom);
   end open;

   -- Procediment per tancar l'origen de les paraules
   procedure close(origen : in out OrigenParaules) is
   begin
      -- Si es tractar de llegir de fitxer, tancar el fitxer
      if origen.to = f_seq then
         close(origen.fitxer);
      elsif origen.to = f_directe then
        close(origen.fitxer_d);
      end if;
   end close;

   -- Procediment per llegir una paraula des d'un origen de paraules
   -- Si es llegeix de teclat es fa ús del procediment get definit abans
   procedure get(origen : in out OrigenParaules;
                 p: out tparaula;
                 l,c : out integer) is

      i : tllargaria := tllargaria'FIRST;
      eof : boolean := False;
   begin
      l := origen.l;
      c := origen.c;

      if origen.to = teclat then
         -- llegir de teclat
         get(p, origen.lletra, origen.l, origen.c);
      else
         -- llegir de fitxer
         -- botar_blancs
         while Is_Separador(origen.lletra) and (not eof) loop
            -- Nomes s'ha de llegir si hi ha qualque cosa al fitxer
            if End_Of_File(origen.fitxer) then
               origen.lletra := '.';
               eof := True;
            else
               get(origen.fitxer, origen.lletra);
               origen.c := origen.c +1;
            end if;
         end loop;

         -- llegir les lletres de la paraula
         while (not Is_Separador(origen.lletra)) and
           i < tllargaria'LAST and
           not eof loop--origen.lletra /= '.' and origen.lletra /= ' ' and i < tllargaria'LAST loop
            i := i+1;
            p.lletres(i) := origen.lletra;
            -- Situar-se sobre el següent element implica determinar
            -- si hi ha següent element o no. Si no n'hi ha aleshores
            -- origen.lletra ha de valer '.'
            if End_Of_File(origen.fitxer) then
               origen.lletra := '.';
               eof := true;
            elsif End_of_Line(origen.fitxer) then
               origen.lletra := ' ';
               origen.l := origen.l + 1;
               origen.c := 0;
            else

               get(origen.fitxer, origen.lletra);
               origen.c := origen.c +1;
            end if;
         end loop;

         p.llargaria := i;


      end if;
   end get;

    procedure get(origen : in out OrigenParaules; p: out tparaula; idx: in Positive) is
   begin
      fitxer_paraules.Read(File => origen.fitxer_d,
                           Item => p,
                           From => fitxer_paraules.Positive_Count(idx));
   end get;

   function size(origen: in OrigenParaules) return Positive is
   begin
    if origen.to = f_directe then
         return Positive(fitxer_paraules.Size(origen.fitxer_d));
    end if;

    raise bad_use;



   end size;



   procedure first(it: out iterator) is
   begin
      it.idx:= rang_lletres'First;
   end first;


   procedure next (p: in tparaula; it: in out iterator) is
   begin
      if it.idx <= p.llargaria then
         it.idx := tllargaria'Succ(it.idx);
      end if;
      end next;

   function is_valid(p: in tparaula; it: in out iterator) return boolean is
   begin
      return it.idx >= rang_lletres'First and it.idx <= p.llargaria;
   end is_valid;

   procedure get (p: in tparaula; it: in iterator; c: out character) is
   begin
      c := p.lletres(it.idx);
   end get;


end pparaula;
