% eval(E,V) that evaluates integer arithmetic expressions consisting of integer constants and operators +,-,*,/,^ to a constant value.

eval(E, E):- integer(E).
eval(E + Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE + EvalY.
eval(E - Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE - EvalY.

eval(E * Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE * EvalY.
eval(E / Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE / EvalY.

eval(E ^ Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE ^ EvalY.


% simplify(E,S) that simplifies polynomial arithmetic expressions involving constants, variables (which are Prolog atoms that start with a lowercase letter), and operators +,-,*,/,^.
simplify(E, E) :- integer(E).
simplify(E, E) :- atom(E).

simplify(E + Y, E + Y) :- integer(E), atom(Y).
simplify(E + Y, E + Y) :- integer(Y), atom(E).

simplify(E - Y, E - Y) :- integer(E), atom(Y).
simplify(E - Y, E - Y) :- integer(Y), atom(E).

simplify(E * Y, E * Y) :- integer(E), atom(Y).
simplify(E * Y, E * Y) :- integer(Y), atom(E).

simplify(E / Y, E / Y) :- integer(E), atom(Y).
simplify(E / Y, E / Y) :- integer(Y), atom(E).

simplify(E ^ Y, E ^ Y) :- integer(E), atom(Y).
simplify(E ^ Y, E ^ Y) :- integer(Y), atom(E).

simplify(E - E, 0) :- atom(E).
simplify(E / E, 1) :- atom(E).
simplify(E ^ 0, 1) :- atom(E).
simplify(E ^ 1, E) :- atom(E).

simplify(E + Y, EvalE + EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
simplify(E - Y, EvalE - EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
simplify(E * Y, EvalE * EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
simplify(E / Y, EvalE / EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
simplify(E ^ Y, EvalE ^ EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).



% simplify(E + Y, S) :- integer(E), atom(Y), eval(E, EvalE), S is (EvalE + Y).


% deriv(E,D) to do symbolic differentiation of polynomial arithmetic expressions with respect to x.

