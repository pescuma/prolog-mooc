:- use_module(library(clpfd)).


% https://swish.swi-prolog.org/p/GVstZLHi.swinb
%
%!     filter(:Goal:callable, +List:list, -Filtered:list) is det
%
%    Succeeds if the last argument is a list of those elements
%    of the second argument for which the first argument
%    succeeds at least once
%
%    @arg Goal  the goal to test with an added arg
%    @arg List  the input list
%    @arg Filtered those elements of List for which Goal succeeds
%

list_sum([], 0).
list_sum([H|T], Sum) :-
    list_sum(T, S),
    Sum #= H + S.


filter(_, [], []).
filter(Goal, [I|TI], [I|TF]) :-
    call(Goal, I),
    filter(Goal, TI, TF).
filter(Goal, [I|TI], TF) :-
    \+ call(Goal, I),
    filter(Goal, TI, TF).




person(X) :- member(X, [
                       alice,
                       bob,
                       charlene,
                       derek,
                       ethyl,
                       faye,
                       gilam,
                       harvey
                       ]).
household(X) :- member(X, [
                          phone,
                          sheet,
                          bed,
                          chair,
                          cup]).
industry(X) :- member(X, [
                         factory,
                         laboratory,
                         machine_shop,
                         foundry
                         ]).
