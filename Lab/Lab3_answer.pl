% Lab3 answer
% some support rules here
conc([], X, X).
conc([F|R], T, [F|L]) :- conc(R, T, L).

remove_duplicates([],[]).
remove_duplicates([H|T], List) :-    
     member(H, T),
     remove_duplicates(T, List), !.
remove_duplicates([H|T], [H|T1]) :- 
      \+member(H, T),
      remove_duplicates(T, T1).

% question 1: Find the last element of	a list.	
my_last(X, [X]) :- !.
my_last(R, [_|T]) :- my_last(R, T).

% question 2 : Reverse	a	list.	
reverse([], []) :- !.
reverse([H|T], R1) :- reverse(T, R), conc(R, [H], R1).

% question 3 : Eliminate	consecutive	duplicates	of	list	elements.	
compress([], []) :- !.
compress([X], [X]) :- !.
compress([H1, H2|T], R) :- H1 = H2, compress([H2|T], R), !.
compress([H1, H2|T], [H1|R]) :- compress([H2|T], R).

% question 4 : 	Pack	consecutive	duplicates	of	list	elements	into	sublists.	
pack([], []) :- !.
pack([X], [[X]]) :- !.
pack([H1, H2|T], [H3|T1]) :- H1 = H2, pack([H2|T], [H|T1]), conc([H1], H, H3), !.
pack([H1, H2|T], R1) :- H1 \= H2, pack([H2|T], R), conc([[H1]], R, R1).

% question 5 : Duplicate	the	elements	of	a	list.	
dupli([], []).
dupli([H|T], [H, H|R]) :- dupli(T, R).

% question 6 : Split	a	list	into	two	parts;	the	length	of	the	Virst	part	is	given.	
split([], _, [], []) :- !.
split([H|T], X, [H|L1], L2) :- Y is X - 1, Y >= 0, split(T, Y, L1, L2), !.
split([H|T], X, L1, [H|L2]) :- Y is X - 1, split(T, Y, L1, L2).

% question 7 : 	Calculate		a	the	sum	of	the	elements	of	a	given	list	L.	
sum([], 0).
sum([H|T], R1) :- sum(T, R), R1 is R + H.

% question 8 :  Check	whether	a	given	term	represents	a	binary	tree	
istree(nil).
istree(t(_, X, Y)) :- istree(X), istree(Y).

% question 9 : Count	the	leaves	of	a	binary	tree
count_leaves(nil, 0) :- !.
count_leaves(t(_, nil, nil), 1) :- !.
count_leaves(t(_, L, R), N) :- count_leaves(L, NL), count_leaves(R, NR), N is NR + NL.

% question 10 : 	Collect	the	internal	nodes	of	a	binary	tree	in	a	list	(62)
count_all_nodes(nil, 0).
count_all_nodes(t(_, L, R), N) :- count_all_nodes(L, NL), count_all_nodes(R, NR), N is NR + NL + 1.
internals(T,S) :- count_leaves(T, NL), count_all_nodes(T, NA), S is NA - NL.

% question 11 : 11.	Write	in	prolog	programs	for	the	set	operations	like	union,	intersection	and	difference.
% union(S1,	S2,	U).	U	is	union	of	the	sets	S1	and	S2.
union(S1, S2, U) :- conc(S1, S2, Temp), remove_duplicates(Temp, U).
    
% intersect(S1,	S2,	I)	intersection	of	the	sets	S1	in	S2.
intersect([], _, []).
intersect(_, [], []).
intersect(S1, S2, [H|R]) :- conc(L1, [H|T1], S1), conc(L2, [H|T2], S2), conc(L1, T1, R1), conc(L2, T2, R2), intersect(R1, R2, R).   

% diff(S1, S2, D)	difference	of	sets S1	and	S2	(is	in	S1	and	not	in	S2)	
diff([], _, []).
diff([H|T], S2, [H|D]) :- diff(T, S2, D), \+member(H, S2), !.
diff([_|T], S2, D) :- diff(T, S2, D).
    