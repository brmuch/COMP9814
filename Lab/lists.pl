insert(X, L1, [X|L1]).
insert(X, [Y|T], [Y|L2]):-insert(X, T, L2).
memb(X, [X|T]).
memb(X, [H|T]):-memb(X, T).
del(X, [X|T], T).
del(X, [A|T], [A|L2]) :- del(X, T, L2).
dup([], []).
dup([F|R], [F, F|L2]):-dup(R, L2).
conc([], X, X).
conc([F|R], T, [F|L]):-conc(R, T, L).
last_elem([X], X).
last_elem([F|R], L):-last_elem(R, L).
divide([], [], []).
divide([X], [X|L1], L2):-divide([], L1, L2).
divide([H1, H2|R], [H1|L1], [H2|L2]):- divide(R, L1, L2).
permute([], []).
permute([H1|R], L1):- permute(R, L),
                    insert(H1, L, L1).