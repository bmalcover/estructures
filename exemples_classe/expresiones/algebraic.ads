with ada.Text_IO; use ada.Text_IO;
with ada.Integer_Text_IO; use ada.Integer_Text_IO;
with d_expr; use d_expr;

package algebraic is

   procedure read (n: in String; e: out expression);
   function read_number(ch: in character) return integer;
   procedure write(e: in expression);

end algebraic;
