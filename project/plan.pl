?- module(plan,
          [ plan/2,
            plan_depth/2
          ]).

?- use_module(queue).
?- use_module(actions).


plan(Initial, Story2) :-
    queue:empty(Q1),
    queue:push(Q1, (Initial, []), Q2),
    plan_(Q2, Story1),
    reverse(Story1, Story2).

plan_(Q, Story) :-
    queue:pop(Q, (Goal, Story), _),
    at_goal(Goal).

plan_(Q1, Story) :-
    queue:pop(Q1, (C1, Past), Q2),
    findall((C2, [A|Past]), take_action(C1, Past, A, C2), As),
    queue:push_all(Q2, As, Q3),
    plan_(Q3, Story).


plan_depth(Initial, Story2) :-
    plan_depth_(Initial, [], Story1),
    reverse(Story1, Story2).

plan_depth_(Initial, Story, Story) :-
    at_goal(Initial).

plan_depth_(C1, Past, Story) :-
    take_action(C1, Past, D, C2),
    plan_depth_(C2, [D|Past], Story).



at_goal(T) :-
    convlist([X,Y]>>(X = goal(Y)), T, Prereqs),
    convlist([X,Y]>>(X = avoid_goal(Y)), T, NonPrereqs),
    subset(Prereqs, T),
    intersection(T, NonPrereqs, []).


take_action(CurrentConditions, Past, Action, NextConditions) :-
    take_action(CurrentConditions, Action, NextConditions),
    \+ member(Action, Past).

take_action(CurrentConditions, Action, NextConditions) :-
    action(Action, Prerecs, NegPrerecs, Add, Remove),
    subset(Prerecs, CurrentConditions),
    intersection(NegPrerecs, CurrentConditions, []),
    subtract(CurrentConditions, Remove, C2),
    append(Add, C2, NextConditions).












