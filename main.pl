
eval(E, E):- integer(E).
eval(E + Y, V) :- eval(E, EV), eval(Y, YV), V is EV + YV.