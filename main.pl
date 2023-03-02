% eval(E,V) that evaluates integer arithmetic expressions consisting of integer constants and operators +,-,*,/,^ to a constant value.

eval(E, E):- integer(E).
eval(E + Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE + EvalY.
eval(E - Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE - EvalY.

eval(E * Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE * EvalY.
eval(E / Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE / EvalY.

eval(E ^ Y, V) :- eval(E, EvalE), eval(Y, EvalY), V is EvalE ^ EvalY.


% simplify(E,S) that simplifies polynomial arithmetic expressions involving constants, variables (which are Prolog atoms that start with a lowercase letter), and operators +,-,*,/,^.

% Instead of 5-(0-1/x^2) we need 5+1/x^2
test(E * (X * Y)) :- integer(E), integer(X). 

simplify(E, E) :- integer(E).
simplify(E, E) :- atom(E).

simplify(E - E, 0).
simplify(E - 0, E).

simplify(E + 0, E).
simplify(0 + E, E).

simplify(E * 0, 0).
simplify(0 * E, 0).
simplify(E * 1, E).
simplify(1 * E, E).

simplify(E / E, 1).
simplify(E / 1, E).
simplify(0 / E, 0).

simplify(E ^ 0, 1).
simplify(E ^ 1, E).
simplify(E ^ -1, 1/E).

simplify(0 ^ E, 0).
simplify(1 ^ E, 1).

simplify(X-0, XR) :- simplify(X,XR).


simplify(E * X / E, X) :- atom(E).
simplify(X * E / E, X) :- atom(E).

simplify(E * ( X * Y ), S) :- integer(E), integer(X), simplify(Y, YR), NewLeft is E * X, simplify_helper(NewLeft * YR, S).
% simplify(( X ) * E, S) :- integer(E), simplify(X, XR), simplify_helper(XR * E, S).
% simplify(X - (0 - Y / Z) , S) :- integer(X), integer(Y), simplify(Z, RZ), NewLeft is X + Y, simplify_helper(X+Y/RZ, S).
simplify(X - (0 - 1 / Y^2) , XR+1 / Y^2) :- integer(X), atom(Y), simplify(X, XR).

simplify(E ^ Y, S) :- integer(E), integer(Y), S is E ^ Y.
simplify(E * Y, S) :- integer(E), integer(Y), S is E * Y.
simplify(E / Y, S) :- integer(E), integer(Y), S is E / Y.
simplify(E + Y, S) :- integer(E), integer(Y), S is E + Y.
simplify(E - Y, S) :- integer(E), integer(Y), S is E - Y.


simplify(E ^ Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE ^ EvalY, S).
simplify(E * Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE * EvalY, S).
simplify(E / Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE / EvalY, S).
simplify(E + Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE + EvalY, S).
simplify(E - Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE - EvalY, S).


simplify_helper(E - E, 0).
simplify_helper(E - 0, E).

simplify_helper(E + 0, E).
simplify_helper(0 + E, E).

simplify_helper(E * 0, 0).
simplify_helper(0 * E, 0).
simplify_helper(E * 1, E).
simplify_helper(1 * E, E).

simplify_helper(E / E, 1).
simplify_helper(E / 1, E).
simplify_helper(0 / E, 0).

simplify_helper(E ^ 0, 1).
simplify_helper(E ^ 1, E).
simplify_helper(E ^ -1, 1/E).

simplify_helper(0 ^ E, 0).
simplify_helper(1 ^ E, 1).

simplify_helper(E * X / E, X) :- atom(E).
simplify_helper(X * E / E, X) :- atom(E).

simplify_helper(X - (0 - Y / Z^2) , S / Z^2) :- integer(X), integer(Y), atom(Z), S is X + Y.
simplify_helper(W + X - (0 - Y / Z^2) , W + X + Y / Z^2) :- integer(X), integer(Y), atom(Z).

% simplify(0*x)
% simplify_helper(0 - X / Y, S) :- integer(X)

simplify_helper(E ^ Y, S) :- integer(E), integer(Y), S is E ^ Y.
simplify_helper(E * Y, S) :- integer(E), integer(Y), S is E * Y.
simplify_helper(E / Y, S) :- integer(E), integer(Y), S is E / Y.
simplify_helper(E + Y, S) :- integer(E), integer(Y), S is E + Y.
simplify_helper(E - Y, S) :- integer(E), integer(Y), S is E - Y.

simplify_helper(E ^ Y, E ^ Y).
simplify_helper(E * Y, E * Y).
simplify_helper(E / Y, E / Y).
simplify_helper(E + Y, E + Y).
simplify_helper(E - Y, E - Y).



% deriv(E,D) to do symbolic differentiation of polynomial arithmetic expressions with respect to x.
deriv(E, D) :- deriv_helper(E, ER), simplify(ER, D).

deriv_helper(E, 1) :- atom(E).
deriv_helper(E, 0) :- integer(E).

deriv_helper(X * Y * X / X, Y) :- atom(X), integer(Y).

% deriv_helper(E + Y, D) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY), simplify(DerivE + DerivY, D).
deriv_helper(E + Y, DerivE + DerivY) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY).

% deriv_helper(E - Y, D) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY), simplify(DerivE - DerivY, D).
deriv_helper(E - Y, DerivE - DerivY) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY).

% deriv_helper(E * Y, D) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY), simplify( DerivE * Y + E * DerivY , D ).
deriv_helper(E * Y, DerivE * Y + E * DerivY) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY).


% deriv_helper(E / Y, D) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY), simplify( DerivE * Y - E * DerivY/Y^2 , D ).
deriv_helper(E / Y, DerivE * Y - E * DerivY/Y^2) :- deriv_helper(E, DerivE), deriv_helper(Y, DerivY).

% deriv_helper(E ^ Y, D) :- simplify(Y-1, X), simplify(Y*E^X, D).
deriv_helper(E ^ Y, Y * E^YR):- YR is Y - 1.




% party_seating(L) that seats party guests around a round table according to the following constraints, when given a list of facts about the guests

male(klefstad).
male(bill).
male(mark).
male(isaac).
male(fred).
female(emily).
female(heidi).
female(beth).
female(susan).
female(jane).
speaks(klefstad, english).
speaks(bill, english).
speaks(emily, english).
speaks(heidi, english).
speaks(isaac, english).
speaks(mark, french).
speaks(beth, french).
speaks(susan, french).
speaks(isaac, french).
speaks(klefstad, spanish).
speaks(bill, spanish).
speaks(susan, spanish).
speaks(fred, spanish).
speaks(jane, spanish).

% Guests spead different languages, and some speak more than one language.
% Invited 9 guests for a round table discussion, total 10 people. total 10 seats
% First person in list will be seated next to last person (circular table)
% adjacent guests must speak the same langage
% no two females can sit next to each other
% 
add_guests(GuestList, [Guest | GuestList]) :- male(Guest) ; female(Guest).

% party_attendees(L) :- findall(Guest, male(Guest) ; female(Guest), L).


party_seating([H|R]) :- male(H), validSeating([H], R, Y), party_attendees(Y).
party_seating([H|R]) :- female(H), validSeating([H], R, Y), party_attendees(Y).

% party_seating([H|T]) :- male(H), validSeating([H], [], T).
% party_seating([H|T]) :- female(H), validSeating([H], [], T).
% validSeating([H], [], [H]).
validSeating([H], [T], [H | T]) :- H =/= T, speaksSame(H, T), validGender(H, T).
validSeating([H], [N | T], R) :- H =/= N, speaksSame(H, N), validGender(H, N), validSeating([N], T, R).

speaksSame(X, Y) :- speaks(X, Z), speaks(Y, Z).

validGender(X, Y) :- male(X), female(Y).
validGender(X, Y) :- male(X), male(Y).
% validGender(X, Y) :- female(X), male(Y). not valid or else at end of circular table 2 females can sit next to each other
% append([ ], Y, Y).
% append([X|L1],L2,[X|L3]):-append(L1,L2,L3).


% validSeating([], H, H).
% validSeating(H, [Person | L], [Person | NewT]) :- speaksSame(H, Person), validGender(H, Person), validSeating([Person], L, NewT).
