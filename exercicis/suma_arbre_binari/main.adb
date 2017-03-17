with d_binari_1;
with ada.text_io; use Ada.Text_IO;
procedure Main is

   package binari is new d_binari_1(Integer, 0, 200,"+", Integer'Image);
   use binari;
   a : binari.arbre;
begin
   inserir(a, 3);
   inserir(a, 4);
   inserir(a, 8);

   put(is_path_sum(a, 11)'img);
end Main;
