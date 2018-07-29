mother(a, x).
mother(a, y).
father(b, y).
father(b, x).

father(g, a).

female(a).
female(y).

diff(X, Y) :- X \== Y.

is_mother(X) :- mother(X, _).

is_father(X) :- father(X, _).

is_son(X) :- mother(_, X).
is_son(X) :- father(_, X).

parent_of(X, Y) :- mother(X, Y).
parent_of(X, Y) :- father(X, Y).

son_of(X, Y) :- parent_of(Y, X).

sister_of(X, Y) :- father(F, X), father(F, Y), mother(M, X), mother(M, Y), female(X), diff(X, Y).

grandpa_of(X, Y) :- father(X, P), parent_of(P, Y).

sibiling_of(X, Y) :- father(F, X), father(F, Y), mother(M, X), mother(M, Y), diff(X, Y).















