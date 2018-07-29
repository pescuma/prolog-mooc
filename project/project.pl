?- use_module(talespin).

create_story(S) :-
    initial_state(I),
    talespin(I, As),
    to_story(As, "", S).


initial_state([at(home), country(home),
               goal(at(granny)), goal(country(far_far_away)),
               avoid_goal(bored), avoid_goal(dirty(_))]).


to_story([], Story, Story).
to_story([A|Actions], Prev, Story) :-
    description(A, D),
    string_concat(D, " ", D2),
    string_concat(Prev, D2, Actual),
    to_story(Actions, Actual, Story).

description(Action-Params, Description) :-
    !,
    format(string(Description), Action, Params).
description(Action, Action).



