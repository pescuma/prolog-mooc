annies_female(annie_ogborn).
annies_female(rosie_ogborn).
annies_female(esther_boger).
annies_female(mildred_ogborn).
annies_male(don_ogborn).
annies_male(randy_ogborn).
annies_male(mike_ogborn).
annies_male(dicky_boger).
annies_male(george_ogborn).
annies_male(elmer_ogborn).
annies_male(karl_boger).

annies_parent_of(rosie_ogborn, annie_ogborn).
annies_parent_of(rosie_ogborn, randy_ogborn).
annies_parent_of(rosie_ogborn, mike_ogborn).
annies_parent_of(don_ogborn, annie_ogborn).
annies_parent_of(don_ogborn, randy_ogborn).
annies_parent_of(don_ogborn, mike_ogborn).
annies_parent_of(george_ogborn, rosie_ogborn).
annies_parent_of(esther_boger, rosie_ogborn).
annies_parent_of(esther_boger, dicky_boger).
annies_parent_of(karl_boger, dicky_boger).


female(beatrice).
female(helen).
female(mary).
female(nancy).
female(julie).
female(laura).
female(christina).
female(lyla).
female(god).
female(X) :- annies_female(X).

male(jason).
male(james).
male(eugene).
male(joseph).
male(roger).
male(gordon).
male(matt).
male(sam).
male(god).
male(X) :- annies_male(X).

% parent_of(X, Y) X is parent of Y
parent_of(jason, helen).
parent_of(beatrice, helen).
parent_of(jason, eugene).
parent_of(beatrice, eugene).
parent_of(james, joseph).
parent_of(helen, joseph).
parent_of(eugene, julie).
parent_of(mary, julie).
parent_of(nancy, gordon).
parent_of(joseph, gordon).
parent_of(julie, matt).
parent_of(roger, matt).
parent_of(gordon, sam).
parent_of(laura, sam).
parent_of(christina, lyla).
parent_of(matt, lyla).
parent_of(god, _).
parent_of(X, Y) :- annies_parent_of(X, Y).

% Entities that are not real persons
not_a_person(god).

% person(X) X is a real person
person(X) :-
    male(X),
    \+ not_a_person(X).
person(X) :-
    female(X),
    \+ not_a_person(X).


% mother_of(M, C) M is mother of C
mother_of(M, C) :-
    parent_of(M, C),
    female(M),
    person(C).

% father_of(F, C) F is father of C
father_of(F, C) :-
    parent_of(F, C),
    male(F),
    person(C).

% son_of(S, P) S is son of P
son_of(S, P) :-
    parent_of(P, S),
    male(S),
    person(S).

% daughter_of(D, P) D is daughter of P
daughter_of(D, P) :-
    parent_of(P, D),
    female(D),
    person(D).

% sibiling(X, Y) X is sibiling of Y (and vice versa)
sibiling(X, Y) :-
    mother_of(M, X),
    mother_of(M, Y),
    father_of(F, X),
    father_of(F, Y),
    X \== Y,
    person(M),
    person(F).

% brother_of(B, X) B is brother of X
brother_of(B, X) :-
    male(B),
    sibiling(B, X).

% sister_of(S, X) S is sister of X
sister_of(S, X) :-
    female(S),
    sibiling(S, X).

% uncle_of(U, X) U is uncle of X
uncle_of(U, X) :-
    brother_of(U, P),
    parent_of(P, X).

% cousin(X, Y) X is cousing of Y (and vice versa)
cousin(X, Y) :-
    parent_of(PX, X),
    parent_of(PY, Y),
    sibiling(PX, PY).

% second_cousin(X, Y) X is second cousin of Y (and vice versa)
second_cousin(X, Y) :-
    parent_of(PX, X),
    cousin(PX, PY),
    parent_of(PY, Y).

% second_cousin_once_removed(X, Y) X is second cousin once removed of Y (and vice versa)
second_cousin_once_removed(X, Y) :-
    parent_of(PX, X),
    second_cousin(PX, Y).
second_cousin_once_removed(X, Y) :-
    second_cousin(X, PY),
    parent_of(PY, Y).

% ancestor_of(A, X) A is an ancestor of X
ancestor_of(A, X) :-
    parent_of(A, X),
    person(X).
ancestor_of(A, X) :-
    person(X),
    person(A),
    parent_of(PX, X),
    ancestor_of(A, PX).

% descendant_of(A, X) A is a descendant of X
descendant_of(D, X) :-
    ancestor_of(X, D).

/*
 * Pick two brothers. Use your program to demonstrate that they *are* brothers. How many answers does your query give?  Explain.
 *
 * ?- brother_of(randy_ogborn, mike_ogborn).
 * true ;
 * false.
 *
 * The first true happens when the goals inside brother_of matches. At
 * that point, a marker is done in the database. When I pressed ; it
 * has tried to search for another group of facts that satisfied the
 * goal, but cound not find any others.
 *
 *
 * In step 4 you added God. What problems did that cause?  How did you fix them?
 *
 * A lot of predicates started to give repetitive answers or entered in
 * what seemed to be an infinite loop. To avoid that I have created the
 * person predicate, to assert that some relations only propagate
 * throught real persons. ancestor_of still gives a lot of repetitive
 * answers, but for other reasons. Those I could not find a way to
 * avoid.
 *
 *
 * Step 4 might not accord to some student's religious beliefs. What does that say about the nature of truth in a Prolog knowledgebase?
 *
 * The truth in the knoledgebase is only based on the facts it have, and
 * has no relationship with real facts or beliefs.
 *
 */














