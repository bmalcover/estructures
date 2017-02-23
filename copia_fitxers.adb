-- Realitzar un programa que còpia el contingut d'un fitxer 
--anomenat «entrada.txt» a un anomenat «sortida.txt». 
--Es demana que el tractament de la informació es faci 
--caràcter a caràcter.

with Text_Io;
use Text_Io;
procedure copia_fitxers is
 F_Entrada, F_Sortida: File_Type;
 c : character;
begin
 --apertura fitxers
 Open(F_Entrada, Mode => In_File, Name => "original.txt");
 Create(F_Sortida, Mode =>Out_File, Name => "copia.txt");
 while not End_Of_File(F_Entrada) loop
 get(F_Entrada, c);
 Put(F_sortida, c);
 end loop;
 --es tanquen els fitxers
 Close(F_Entrada);
 Close(F_Sortida);
end copia_fitxers;
