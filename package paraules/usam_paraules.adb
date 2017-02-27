with pparaula;


procedure usam_paraules is


  package meva_paraula is new pparaula(contingut=> character, MAXIM=>30); --Especificam un package generic
  use meva_paraula;

  paraula :tparaula;
  origen  : OrigenParaules;
  l,c : integer := 0;

begin

  open(origen);
  get(origen,paraula, l, c);
  put(paraula);


end usam_paraules;
