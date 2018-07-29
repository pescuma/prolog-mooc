:- module(actions,
          [ action/5,
            country/1,
            singleton_state/1,
            take_action/4
          ]).


% action(Description, Prereqs, NegPrereqs, Add, Remove)

action('Go to ~w.'-[Location],
       [country(Country)], [flying_to(_)],
       [at(Location)], []) :-
    go_to_target(Location, Country).

action('Take plane to ~w.'-[C2],
       [has(plane_ticket), at(airport), country(C1)], [dirty(_)],
       [flying_to(C2)], [has(plane_ticket), at(airport), country(C1)]) :-
    country(C1),
    country(C2),
    \+ C1 = C2.

action('Arrive at ~w.'-[C2],
       [flying_to(C2)], [],
       [at(airport), country(C2), bored], [flying_to(C2)]).

action('Buy plane ticket.',
       [has(money)], [flying_to(_)],
       [has(plane_ticket)], []).

action('Go to bank and get some money.',
       [], [flying_to(_)],
       [has(money), at(bank)], []).

action('Go to the pet shop and clean up the dog.',
       [dirty(dog), has(money)], [flying_to(_)],
       [at(pet_shop)], [dirty(dog)]).

action('Kids play for a while.',
       [at(park)], [has(dog)],
       [], [bored]).

action('Kids play with the dog for a while.',
       [at(park), has(dog)], [],
       [], [bored]).





go_to_target(home, home).
go_to_target(granny, far_far_away).
go_to_target(airport, _).
go_to_target(park, _).


country(home).
country(far_away).
country(far_far_away).


singleton_state(at(_)).
singleton_state(country(_)).











