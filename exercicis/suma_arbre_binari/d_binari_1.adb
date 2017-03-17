with ada.text_io;
use ada.text_io;
package body d_binari_1 is

   procedure inserir(a: in out arbre; x: in item) is
   begin
      a.m(a.free) := x;
      a.free := rang'Succ(a.free);

   end inserir;

   function preorder(a: in arbre; idx: in rang; suma: in  item; x:in item) return boolean
   is
      ok1, ok2 : boolean;
      s : item;
   begin

      if idx < a.free then

         s := suma + a.m(idx);
         put_line(Image(s));
         ok1:= preorder(a, idx*2, s, x);

         ok2:= preorder(a, (idx*2)+1,  s, x);

         return ok1 or ok2;
      else
         return suma = x;
      end if;

   end preorder;

   function is_path_sum(a: in arbre; x: in item) return boolean is

   begin
      return preorder(a, rang'First, first_item, x);
   end is_path_sum;





end d_binari_1;
