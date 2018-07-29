:- module(talespin,
          [ talespin/2
          ]).

?- use_module(plan).
?- use_module(actions).
?- use_module(events).


talespin(Initial, Story) :-
    faster_plan(Initial, Plan),
    execute(Initial, Plan, [], Story),
    !.


execute(_, [], Past, Story) :-
    !,
    reverse(Past, Story).

execute(State, Plan, Past, Story) :-
    step(State, Plan, Past, NewState, NewPlan, NewPast),
    execute(NewState, NewPlan, NewPast, Story).


step(State, [Action|_], Past, NewState, NewPlan, NewPast) :-
    event_on_action(Event, Chance, Action, Add, Remove),
    \+ member(Event, Past),
    update_state([], [], Add, Remove, State, NewState),
    Roll is random(100),
    Roll < Chance,
    !,
    faster_plan(NewState, NewPlan),
    NewPast = [Event|Past].

step(State, _, Past, NewState, NewPlan, NewPast) :-
    event_on_state(Event, Chance, Prereqs, NegPrereqs, Add, Remove),
    \+ member(Event, Past),
    update_state(Prereqs, NegPrereqs, Add, Remove, State, NewState),
    Roll is random(100),
    Roll < Chance,
    !,
    faster_plan(NewState, NewPlan),
    NewPast = [Event|Past].

step(State, [Action|NewPlan], Past, NewState, NewPlan, NewPast) :-
    take_action(Action, State, NewState),
    NewPast = [Action|Past].







