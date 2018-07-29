:- module(queue,
          [ push_all/3,
            push/3,
            pop/3,
            empty/1,
            finish/2
          ]).

push_all(Q1, [], Q1).
push_all(Q1, [El|T], Q3) :-
    push(Q1, El, Q2),
    push_all(Q2, T, Q3).

push(Queue-[El|Hole], El, Queue-Hole) :-
    var(Hole).

pop([El|T]-Hole, El, T-Hole) :-
    var(Hole).

empty(Hole-Hole) :-
    var(Hole).

finish(Queue-[], Queue).
