:- module(actions,
          [ location/1,
            action/5
          ]).

location(home).
location(airport).
location(bank).

% action(Description, Prereqs, NegPrereqs, Add, Remove)
action('Go to ~w'-[Location], [], [at(Location)], [at(Location)], [at(_)]) :-
    location(Location).
action('Fly', [has(plane_ticket), at(airport)], [], [at(plane)], [has(plane_ticked), at(_)]).
action('Buy plane ticket', [has(money)], [], [has(plane_ticket)], [has(money)]).
action('Get money', [at(bank)], [], [has(money)], []).
