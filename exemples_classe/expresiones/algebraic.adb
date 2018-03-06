package body algebraic is

   c : character;
   f : File_Type;
   from_file    : boolean;


   syntax_error : exception;

   procedure read_exp (e:out expression);
   procedure read_term (e:out expression);
   procedure read_factor (e:out expression);
   procedure read_factor1 (e:out expression);
   function scan_id return un_op;
   function scan_num return Integer;


   procedure read_c(c: out character) is
   begin
      if from_file then
         get(f,c);
      else
         get(c);
      end if;
   end read_c;


   procedure read_exp (e:out expression) is
      neg_term: Boolean;
      op: Character;
      e1: expression;
   begin
      neg_term := c = '-';
      if neg_term then
         read_c(c);
      end if;
      read_term(e);
      if neg_term then
         e := b_un_op(neg, e);
      end if;
      while c='+' or c='-' loop
         op:= c;
         read_c(c);
         read_term(e1);
         if op='+' then e:= b_Bin_op(add, e, e1);
         else  e:= b_Bin_op(sub, e, e1);
         end if;
      end loop;
   end read_exp;

   procedure read_term (e:out expression) is
      op: Character;
      e1: expression;
   begin
      read_factor1(e);
      while c='*' or c='/' loop
         op:= c;
         read_c(c);
         read_factor(e1);
         if op='*' then e:= b_bin_op(prod, e, e1);
         else e:= b_bin_op(quot, e, e1);
         end if;
      end loop;
   end read_term;

   procedure read_factor (e:out expression) is
      e1: expression;
   begin
      read_factor1(e);

      if c='^' then
         read_c(c);
         read_factor(e1);
         e:=b_bin_op(power, e, e1);
      end if;
   end read_factor;

   procedure read_factor1 (e:out expression) is
      t: un_op;
      x: Character;
      n: Integer;
   begin
      if c='(' then
         read_c(c);
         read_exp(e);
         if c /= ')' then raise syntax_error; end if;
         read_c(c);
      elsif 'a' <=c and c <='z' then -- if c in subtipus_var
         x:= c;
         t:= scan_id;
         if t = neg then
            if r_rule then
               e := b_varg(x);
            else
               e:= b_var(x);
            end if;
         else
            if c /= '(' then raise syntax_error; end if;
            read_c(c);
            read_exp(e);
            if c /= ')' then raise syntax_error; end if;
            read_c(c);
            e:= b_un_op(t, e);
         end if;
      elsif '0' <= c and c <= '9' then
         n := scan_num;
         e:= b_constant(n);
      else
         raise syntax_error;
      end if;
   end read_factor1;

   function scan_id return un_op is
   begin
      case c is
      when 's' =>
         read_c(c);
         if c = 'i' then
            read_c(c);
            if c = 'n' then
               read_c(c);
               return sin;
            end if;
         else return neg;
         end if;
      when 'c' =>
         read_c(c);
         if c = 'o' then
            read_c(c);
            if c = 's' then
               read_c(c);
               return cos;
            end if;
         else return neg;
         end if;
      when 'l' =>
         read_c(c);
         if c = 'o' then
            read_c(c);
            if c = 'g' then
               read_c(c);
               return log;
            end if;
         else return neg;
         end if;
      when 'e' =>
         read_c(c);
         if c = 'x' then
            read_c(c);
            if c = 'p' then
               return exp;
            end if;
         end if;

      when others => read_c(c);return neg;
      end case;
      raise syntax_error;
   end scan_id;

   function scan_num return integer is
      i, s, aux : integer;
   begin
      s:= 10;
      i:= 0;
      while '0' <= c and c <= '9' loop
         aux:= Character'Pos(c)-48;
         i := (i*s) + aux;
         read_c(c);
      end loop;
      return i;
   end scan_num;

   function read_number(ch: in character) return integer is
   begin
      c:=ch;
      from_file:= false;

      return scan_num;

   end read_number;


   procedure read (n: in string; e: out expression) is
   begin
      from_file := true;

      Open(f,In_File,n);
      read_c(c);
      read_exp(e);
      if c /= ';' then
         raise syntax_error;
      end if;
      Close(f);
   exception
      when syntax_error => put("Syntax error"); raise;
   end read;




   procedure put_bin_op (bop: in bin_op) is
   begin
      case bop is
         when add   => put("+");
         when sub   => put("-");
         when prod  => put("*");
         when quot  => put("/");
         when power => put("^");
      end case;
   end put_bin_op;


   procedure put_un_op (uop: in un_op) is
   begin
      case uop is
         when sin => put("sin(");
         when cos => put("cos(");
         when exp => put("exp(");
         when log => put("log(");
         when neg => put("-");
         when others => null;
      end case;
   end put_un_op;
   
   
   function left_parent_req(e: in expression) return Boolean is
      esb, esb1, esb2: expression;
       bop: bin_op;
   begin
      g_bin(e, bop, esb1, esb2);
      if bop = prod  and then e_type(esb1) = e_bin then
         g_bin(esb1, bop, esb, esb2);
         if bop = add then
            return true;
         end if;
      end if;

      if bop = sub  and then e_type(esb1) = e_bin then
         g_bin(esb1, bop, esb, esb2);
         if bop = add then
            return true;
         end if;
      end if;
      return false;
   end left_parent_req;

   function right_parent_req(e: in expression) return Boolean is
      esb, esb1, esb2: expression;
       bop: bin_op;
   begin
      g_bin(e, bop, esb1, esb2);
      if bop = prod  and then e_type(esb2) = e_bin then
         g_bin(esb2, bop, esb, esb2);
         if bop = add then
            return true;
            end if;
      end if;
      if bop = sub  and then e_type(esb2) = e_bin then
         g_bin(esb2, bop, esb, esb2);
         if bop = add then
            return true;
         end if;
      end if;
      return false;
   end right_parent_req;


   function right_single_req(uop: in un_op) return Boolean is
   begin
      case uop is
         when neg | none => return false;
         when others => return true;
      end case;
   end right_single_req;


   procedure write(e: in expression)is

      procedure write_0(e: in expression) is
         pr: Boolean;
         uop: un_op;
         bop: bin_op;
         esb, esb1, esb2: expression;
      begin
         case e_type(e) is
            when e_null  => null;
            when e_const =>
               put(Integer'Image(g_const(e)));
            when e_var | e_varg =>
               put(g_var(e));
            when e_un =>
               g_un(e, uop, esb);
               put_un_op(uop);
               write_0(esb);
               if right_single_req(uop) then put(")"); end if;
            when e_bin =>
               g_bin(e, bop, esb1, esb2);
               pr:= left_parent_req(e);
               if pr then put('('); end if;
               write_0(esb1);
               if pr then put(')'); end if;
               put_bin_op(bop);
               pr:= right_parent_req(e);
               if pr then put('('); end if;
               write_0(esb2);
               if pr then put(')'); end if;
         end case;
      end write_0;

   begin

      write_0(e);
   end write;

  
end algebraic;
