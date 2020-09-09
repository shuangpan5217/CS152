victim(mr_boddy).
victim(cook).
victim(motorist).
victim(police_officer).
victim(yvette).
victim(singing_telegram).

suspect(professor_plum).
suspect(mrs_peacock).
suspect(mrs_white).
suspect(miss_scarlet).
suspect(colonel_mustard).
suspect(mr_green).
suspect(wadsworth).

weapon(wrench).
weapon(candlestick).
weapon(lead_pipe).
weapon(knife).
weapon(revolver).
weapon(rope).

room(hall).
room(kitchen).
room(lounge).
room(library).
room(billiard_room).

murder(mr_boddy,candlestick,hall).
murder(cook,knife,kitchen).
murder(motorist,wrench,lounge).
murder(police_officer,lead_pipe,library).
murder(singing_telegram,revolver,hall).
murder(yvette,rope,billiard_room).

% All Motives.
motive(S, mr_boddy) :- not(S = wadsworth).
motive(mrs_peacock, cook).
motive(colonel_mustard, motorist).
motive(miss_scarlet, yvette).
motive(colonel_mustard, yvette).
motive(mrs_white, yvette).
motive(miss_scarlet, police_officer).
motive(professor_plum, singing_telegram).
motive(wadsworth, singing_telegram).

% Dont' use.
dont(colonel_mustard, W) :- W = rope.
dont(professor_plum, W) :- W = revolver.
dont(mrs_peacock, W) :- W = candlestick.

% Have never been.
havent(miss_scarlet, R) :- R = billiard_room.
havent(professor_plum, R) :- R = kitchen.
havent(colonel_mustard, R) :- murder(mr_boddy, _, R).

% Alibi
alibi(mrs_white, mr_boddy).
alibi(mr_green, _).
alibi(miss_scarlet, V) :- murder(_, revolver, R), murder(V, _, R).

% Update accuse to solve the murders.
% Add more facts and rules as needed.
accuse(V,S) :- murder(V,W,R), suspect(S), motive(S, V), not(dont(S,W)), not(havent(S, R)), not(alibi(S, V)).