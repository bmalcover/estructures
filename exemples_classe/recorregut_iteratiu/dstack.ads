with ada.text_io; use ada.text_io;
with ada.integer_text_io; use ada.integer_text_io;

generic

type item is private;

package dstack is
type stack is limited private;
bad_use: exception;
space_overflow :exception;

   procedure empty (s: out stack);
   procedure push(s: in out stack; x: in item);
   procedure pop (s: in out stack);
   function  top (s: in stack) return item;
   function  is_empty(s: in stack) return boolean;

private
   --depende de la implementación. Compacta: array y un entero

   -- punteros
   type cell; -- declaración forward
   type pcell is access cell;
   type cell is record
      x: item;
      next:pcell;
   end record;
   type stack is record
      top: pcell;
   end record;

   --cursores
end dstack;



