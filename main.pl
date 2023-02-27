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
simplify(0 - E, E).
simplify(0 + E, E).
simplify(0 / E, 0).
simplify(E * 0, 0).
simplify(0 * E, 0).
simplify(E * 1, E).
simplify(1 * E, E).
simplify(E / E, 1).
simplify(E / 1, E).
simplify(E ^ 0, 1).
simplify(E ^ 1, E).
simplify(0 ^ E, 0).

simplify(E + Y, S) :- integer(E), integer(Y), S is E + Y.
simplify(E - Y, S) :- integer(E), integer(Y), S is E - Y.
simplify(E * Y, S) :- integer(E), integer(Y), S is E * Y.
simplify(E / Y, S) :- integer(E), integer(Y), S is E / Y.
simplify(E ^ Y, S) :- integer(E), integer(Y), S is E ^ Y.

simplify(E + Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE + EvalY, S).
simplify(E - Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE - EvalY, S).
simplify(E * Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE * EvalY, S).
simplify(E / Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE / EvalY, S).
simplify(E ^ Y, S) :- simplify(E, EvalE), simplify(Y, EvalY), simplify_helper(EvalE ^ EvalY, S).


simplify_helper(E - E, 0).
simplify_helper(E - 0, E).
simplify_helper(E + 0, E).
simplify_helper(0 - E, E).
simplify_helper(0 + E, E).
simplify_helper(0 / E, 0).
simplify_helper(E * 0, 0).
simplify_helper(0 * E, 0).
simplify_helper(E * 1, E).
simplify_helper(1 * E, E).
simplify_helper(E / E, 1).
simplify_helper(E / 1, E).
simplify_helper(E ^ 0, 1).
simplify_helper(E ^ 1, E).
simplify_helper(0 ^ E, 0).

simplify_helper(E + Y, S) :- integer(E), integer(Y), S is E + Y.
simplify_helper(E - Y, S) :- integer(E), integer(Y), S is E - Y.
simplify_helper(E * Y, S) :- integer(E), integer(Y), S is E * Y.
simplify_helper(E / Y, S) :- integer(E), integer(Y), S is E / Y.
simplify_helper(E ^ Y, S) :- integer(E), integer(Y), S is E ^ Y.

simplify_helper(E + Y, E + Y).
simplify_helper(E - Y, E - Y).
simplify_helper(E * Y, E * Y).
simplify_helper(E / Y, E / Y).
simplify_helper(E ^ Y, E ^ Y).



% deriv(E,D) to do symbolic differentiation of polynomial arithmetic expressions with respect to x.



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
% add_guests(GuestList, [Guest | GuestList]) :- male(Guest) ; female(Guest).

% party_seating(L) :- findall(Guest, male(Guest) ; female(Guest), L).


ps([H|T]) :- male(H), validSeating([H], T).
ps([H|T]) :- female(H), validSeating([H], T).

validSeating(H, [Person | L]) :- speaksSame(H, Person), validGender(H, Person), validSeating(Person, L) .

speaksSame(X, Y) :- speaks(X, english), speaks(Y, english).
speaksSame(X, Y) :- speaks(X, french), speaks(Y, french).
speaksSame(X, Y) :- speaks(X, spanish), speaks(Y, spanish).

validGender(X, Y) :- male(X), female(Y).
validGender(X, Y) :- female(X), male(Y).
% party_seating_helper(L, N) :-