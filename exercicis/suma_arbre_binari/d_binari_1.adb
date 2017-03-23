with ada.text_io;
use ada.text_io;
package body d_binari_1 is

   procedure inserir(a: in out arbre; x: in item) is
   begin
      a.m(a.free) := x;
      a.free := rang'Succ(a.free);

   end inserir;
   
   --Versio millorada, evitam visitar branques un cop ja hem trobat la suma.
   --Evita l'error on podiem avaluar nodes amb un sol fill.
   
   function preorder(a: in arbre; idx: in rang; suma: in  item; x:in item) return boolean
   is
      ok : boolean := False;
      s : item;
   begin
   
      if idx*2 >= a.free and (idx*2) +1 >= a.free then
         s := suma + a.m(idx);
         return s = x;
      else   
         s := suma + a.m(idx);
         put_line(Image(s));
         
         if idx*2 < a.free then    
            ok := preorder(a, idx*2, s, x);
            
            if (idx*2) +1 < a.free and ok = False then
               ok := preorder(a, (idx*2)+1,  s, x);
            end if;
         end if;
         
         return ok;
 
      end if;

   end preorder;

   function is_path_sum(a: in arbre; x: in item) return boolean is

   begin
      return preorder(a, rang'First, first_item, x);
   end is_path_sum;



end d_binari_1;
