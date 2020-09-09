villain(joker).
villain(penguin).
villain(catwoman).
villain(scarecrow).
kills_people(joker).
kills_people(penguin).
power(scarecrow, fear).
romantic_interest(catwoman).
romantic_interest(talia).

scary(V) :- villain(V),
kills_people(V).
scary(V) :- villain(V),
power(V,_).

mortal(helen).
mortal(shuang).