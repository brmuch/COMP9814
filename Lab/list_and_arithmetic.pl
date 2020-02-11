shiftleft([], []).
shiftleft([H|T], R):- conc(T, [H], R).
del_last_elem([X], []).
del_last_elem([H|T], [H|R]):- del_last_elem(T, R).

shiftright(L, [E|L1]):- last_elem(L, E), del_last_elem(L, L1).
rev([], []).
rev([H|T], R):- rev(T, X), conc(X, [H], R).
del_last_elem([X], []).
del_last_elem([H|T], [H|R]):- del_last_elem(T, R).

palindrome([]).
palindrome([X]).

palindrome([H|T]):- del_last_elem(T, T1), palindrome(T1), last_elem(T, X), X = H.
oddlen([X]).
evenlen([]).

oddlen([H1, H2|T]):- oddlen(T).
evenlen([H1, H2|T]):- evenlen(T).
len([], 0).
len([H|T], Len):- len(T, X), Len is X + 1.
sum([], 0).
sum([H|T], Sum):- sum(T, R), Sum is R + H.
min([X], X).
min([H|T], R):- min(T, R), R =< H.
min([H|T], H):- min(T, R), R > H.
max([X], X).
max([H|T], R):- max(T, R), R >= H.
max([H|T], H):- max(T, R), R < H.
sublist(L, SL) :- conc(L1, L2, L), conc(SL, L3, L2).