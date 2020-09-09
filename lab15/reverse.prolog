
% Base case
myappend([], L2, L2).
% Recursive case
myappend([H|T1],L2,[H|T2]) :-
myappend(T1, L2, T2).

myreverse([], []).
myreverse([H|T], L) :-
myreverse(T, RT),
append(RT, [H], L).

