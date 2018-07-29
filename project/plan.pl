?- module(plan,
          [ faster_plan/2,
            take_action/3,
            update_state/6
          ]).

?- use_module(queue).
?- use_module(actions).

faster_plan(Initial, Story) :-
    plan(Initial, Story),
    !.


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
    findall((C2, NewPast), step(C1, Past, C2, NewPast), As),
    queue:push_all(Q2, As, Q3),
    plan_(Q3, Story).


plan_depth(Initial, Story2) :-
    plan_depth_(Initial, [], Story1),
    reverse(Story1, Story2).

plan_depth_(Initial, Story, Story) :-
    at_goal(Initial).

plan_depth_(C1, Past, Story) :-
    step(C1, Past, C2, NewPast),
    plan_depth_(C2, NewPast, Story).


step(State, Past, NewState, NewPast) :-
   take_action(Action, State, NewState),
   \+ member(Action, Past),
   NewPast = [Action|Past].


at_goal(T) :-
    convlist([X,Y]>>(X = goal(Y)), T, Prereqs),
    convlist([X,Y]>>(X = avoid_goal(Y)), T, NonPrereqs),
    subset(Prereqs, T),
    intersection(T, NonPrereqs, []).


take_action(Action, State, NewState) :-
    action(Action, Prereqs, NegPrereqs, Add, Remove),
    update_state(Prereqs, NegPrereqs, Add, Remove, State, NewState).


update_state(Prereqs, NegPrereqs, Add, Remove, State, NewState) :-
    subset(Prereqs, State),
    intersection(NegPrereqs, State, []),
    intersection(Add, State, []),
    subtract(State, Remove, S2),
    remove_singletons(Add, S2, S3),
    append(Add, S3, NewState).


remove_singletons([], State, State).

remove_singletons([A|Add], State, NewState) :-
    singleton_state(S),
    copy_term(S, S1),
    apply((=), [A, S1]),
    !,
    subtract(State, [S], State2),
    remove_singletons(Add, State2, NewState).

remove_singletons([_|Add], State, NewState) :-
    remove_singletons(Add, State, NewState).













