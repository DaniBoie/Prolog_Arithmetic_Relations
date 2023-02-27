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

simplify(E - E, 0).
simplify(E - 0, E).
simplify(E + 0, E).
simplify(0 / E, 0).
simplify(E * 0, 0).
simplify(E * 1, E).
simplify(E / E, 1).
simplify(E / 1, E).
simplify(E ^ 0, 1).
simplify(E ^ 1, E).


simplify(E + Y, V) :- simplify(E, EvalE), simplify(Y, EvalY), V is EvalE + EvalY.
simplify(E - Y, V) :- simplify(E, EvalE), simplify(Y, EvalY), V is EvalE - EvalY.
simplify(E * Y, V) :- simplify(E, EvalE), simplify(Y, EvalY), V is EvalE * EvalY.
simplify(E / Y, V) :- simplify(E, EvalE), simplify(Y, EvalY), V is EvalE / EvalY.
simplify(E ^ Y, V) :- simplify(E, EvalE), simplify(Y, EvalY), V is EvalE ^ EvalY.

% simplify(E + Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify(EvalE + EvalY, S).
% simplify(E - Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify(EvalE - EvalY, S).
% simplify(E * Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify(EvalE * EvalY, S).
% simplify(E / Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify(EvalE / EvalY, S).
% simplify(E ^ Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify(EvalE ^ EvalY, S).

% simplify(E ^ Y, EvalE ^ EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
% simplify(E * Y, EvalE * EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
% simplify(E / Y, EvalE / EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
% simplify(E + Y, EvalE + EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).
% simplify(E - Y, EvalE - EvalY) :- simplify(E, EvalE), simplify(Y, EvalY).



% deriv(E,D) to do symbolic differentiation of polynomial arithmetic expressions with respect to x.

