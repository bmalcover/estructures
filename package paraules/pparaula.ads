-- Autor: Pere Palmer
with Ada.Text_IO, Ada.Direct_IO, Ada.Characters.Latin_1, Ada.Characters.Handling;
use Ada.Text_IO,  Ada.Characters.Latin_1, Ada.Characters.Handling;

-- Package que defineix el tipus tparaula i les operacions
-- que es poden realitzar amb ell.
--
-- Aquest package tamb� defineix el tipus OrigenParaula per poder
-- fer tractaments des de fitxer i teclat independentment.
package pparaula is
   ---------------------------------------------------------
   -- Definicions p�bliques relacionades amb les paraules --
   ---------------------------------------------------------

   -- Nombre m�xim de lletres que poden formar una paraula
   MAXIM : constant integer:= 30;
   -- Rang de llarg�ries que pot tenir una paraula donada
   subtype tllargaria is  integer range 0..MAXIM;
   subtype rang_lletres is tllargaria range 1..tllargaria'LAST;

   bad_use: exception;


   type torigen is (teclat, f_seq, f_directe);

   -- Definici� del tipus tparaula.
   type tparaula is private;

   -- Procediment per poder llegir del teclat
   --procedure get(p : out tparaula; lletra : in out character;  l, c: in out integer);
   -- Procediment per escriure a la pantalla
   procedure put(p : in tparaula);
   -- Procediment per escriure a un fitxer de text
   procedure put(f : in out File_Type; p : in tparaula);
   -- Funci� per comparar dues paraules i determinar si s�n iguals
   function "=" (a, b : in tparaula) return boolean;
   -- Funci� per saber la llarg�ria d'una paraula. �s a dir, el nombre
   -- de lletres que formen la paraula en q�esti�
   function llargaria(p : in tparaula) return tllargaria;
   -- Funci� que indica si la paraula est� buida
   function buida(p : in tparaula) return boolean;
   -- Funci� que torna la lletra que es troba a una posici� determinada
   -- d'una paraula.
   function caracter(p : in tparaula; posicio : in rang_lletres) return character;

   function toString(p: in tparaula) return  String;

   ---------------------------------------------------------------------
   -- Definicions p�bliques relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------

   -- Procediment que copia una paraula. �s un procediment �til per
   -- utilitzar aquest package PParaules i gen�rics.
   procedure copiar(desti : out tparaula; origen : in tparaula);

   type OrigenParaules(to: torigen) is limited private;

   -- Procediment per tractar amb les paraules llegides del teclat
   procedure open(origen : out OrigenParaules);
   -- Procediment per tractar amb les paraules llegides del fitxer nom
   procedure open(origen : out OrigenParaules; nom : in String);
   -- Procediment per tancar l'origen de les paraules
   procedure close(origen : in out OrigenParaules);
   -- Procediment per llegir una paraula des d'un origen de paraules
   procedure get(origen : in out OrigenParaules; p: out tparaula; l, c: out integer);
   procedure get(origen : in out OrigenParaules; p: out tparaula; idx: in Positive);

   --nomes usable amb direct_io
   function size(origen: in OrigenParaules) return Positive;

   ---------------------------------------------------------------------
   -- Iterador-
   ---------------------------------------------------------------------

   type iterator is limited private;

   procedure first(it: out iterator);
   procedure next (p: in tparaula; it: in out iterator);
   function is_valid(p: in tparaula; it: in out iterator) return boolean;
   procedure get(p: in tparaula; it: in iterator; c: out character);

private
   --------------------------------------------------------------
   -- Declaracions privades relacionades amb el tipus tparaula --
   --------------------------------------------------------------

   -- Declaracions per declara l'array de lletres que formaran la paraula
   type taula_lletres is array (rang_lletres) of character;

   -- Declaraci� privada del tipus tparaula.
   type tparaula is record
      lletres : taula_lletres;
      llargaria : tllargaria;
   end record;

    package fitxer_paraules is new ada.Direct_IO(Element_Type => tparaula);
     use fitxer_paraules;

   type iterator is
      record
         idx : tllargaria;
      end record;


   ---------------------------------------------------------------------
   -- Definicions p�bliques relacionades amb l'origen de les paraules --
   ---------------------------------------------------------------------


   type OrigenParaules(to: torigen) is record
      lletra : character; -- darrer car�cter llegit
      l, c   : integer;   -- linia i columna del darrer caracter llegit
      case to is
         when f_seq => fitxer : Ada.Text_IO.file_type;
         when f_directe => fitxer_d : fitxer_paraules.File_Type;
         when teclat => null;
      end case;


   end record;

end pparaula;
