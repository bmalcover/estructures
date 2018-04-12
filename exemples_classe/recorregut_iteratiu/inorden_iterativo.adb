procedure inordre_iteratiu( a: in arbre) is

type item_pila is
record
    x: pnode;
    b: boolean;
end record;

package a_pila is new dpila(item_pila);
use a_pila;

p: stack;

begin
--Antes: x:=raiz(t);
pvacia(p);
x_es_izq:= false;
x:= raiz(t);

while ex_izq(x) loop --Primero
    --Antes: x:= izq(x);
    push(p, (x, x_es_izq);
    x:=izq(x);
    x_es_izq:=true;
end loop;

u:= raiz(t); while ex_der(u) loop u:=der(u); end loop; --Ultimo

while x/= u loop
    visita(x);

    if ex_der(x) then --Sucesor
        --Antes: x:=der(x);
        push(p, (x, x_es_izq);
        x:=der(x);
        x_es_izq:=false;
        while ex_izq(x) loop
           --Antes: x:= izq(x);
           push(p, (x, x_es_izq);
           x:=izq(x);
           x_es_izq:=true;
        end loop;
    else
        while not x_es_izq loop
            -- Antes: x:= padre(x)
            (x, x_es_izq):=cima(p)
            pop(p);
        end loop;
        (x, x_es_izq):=cima(p)
        pop(p);
    end if;
end loop;
visita(x); --visita el último
