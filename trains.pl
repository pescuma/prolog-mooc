train(vancouver, seattle).
train(seattle, portland).
train(spokane, minneapolis).
train(minneapolis, milwaukee).
train(chicago, milwaukee).
train(dubuque, chicago).
train(chicago, omaha).
train(omaha, denver).
train(salt_lake_city, denver).
train(salt_lake_city, sacramento).
train(sacramento, oakland).
train(sacramento, portland).
train(portland, spokane).
train(oakland, san_jose).
train(san_jose, los_angeles).
train(los_angeles, albuquerque).
train(albuquerque, kansas_city).
train(kansas_city, chicago).

direct_route(A, B) :- train(A, B).
direct_route(A, B) :- train(B, A).

route_length(Start, End, Len) :-
    route_path(Start, End, [], Path),
    length(Path, Len).

route_path(Start, End, _, PathAfter) :-
    direct_route(Start, End),
    PathAfter = [End].
route_path(Start, End, PathBefore, [Next|PathAfter]) :-
    direct_route(Start, Next),
    End \== Next,
    \+ member(Next, PathBefore),
    route_path(Next, End, [Start | PathBefore], PathAfter).

