:- module(events,
          [ event_on_action/5,
            event_on_state/6
          ]).

?- use_module(actions).

% event_on_action(Name, Chance, Action, Add, Remove)

event_on_action('Hurricane! Plane diverted to ~w.'-[C2], 20,
                'Arrive at ~w.'-[C1],
                [at(airport), country(C2)], [flying_to(C1)]) :-
    country(C2),
    \+ C2 = C1.



% event_on_state(Name, Chance, Prereqs, NegPrereqs, Add, Remove)

event_on_state('Found a dog, skinny and in need of a shower.', 20,
               [], [at(home), at(granny), flying_to(_)],
               [has(dog), dirty(dog)], []).

event_on_state('Meet a new friend: ~w!'-[friend], 20,
               [], [],
               [has(friend)], []).

event_on_state('This would be a good time for an ice cream. Let\'s eat some!'-N, 30,
               [], [flying_to(_)],
               [at(ice_cream_shop)], [bored]) :-
    N is random(2).


