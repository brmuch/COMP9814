% 1. Conc(L1, L2, L3)
conc([], L2, L2).
conc([Head|Tail], L2, [Head|Rtn]) :- conc(Tail, L2, Rtn).

% 2. Prolog Query: which months before "June"

% 3. Prolog Query: Delete from List L1 everthing from two 'x' onwards
del_onward_x([], []):- !.
del_onward_x([_], [_]):- !.
del_onward_x([X, Y], [X, Y]):- !.
del_onward_x([_|T], [H2, H3|R]) :- del_onward_x(T, [H2, H3|R]), H2 = x, H3 = x, !.
del_onward_x([H|T], [H, H1|R]) :- del_onward_x(T, [H1|R]).

% 4. del(X, List, NewList)
del(_, [], []).
del(X, [H|T], R) :- del(X, T, R), H = X, !.
del(X, [H|T], [H|R]) :- del(X, T, R).

% 5. Length_List(L, Len)
length_List([], 0).
length_List([_|T], L1) :- length_List(T, L), L1 is L + 1.

% 7. sublist
sublist(L, SL) :- conc(L1, L2, L), conc(SL, L3, L2).

% 8. 8.	What is	the	Prolog answer?
?-	datum(Day,	Month,	2000) =	datum(D1,	jun,	Y1).	 Day = D1, Month = jun, Y1 = 2000.
?-	triangle(t(1,1), A,	t(2, 3)) =	triangle(X,	t(4,Y),	t(2,Y)).	 X = t(1, 1), Y = 3, A = t(4, 3)
?-	[a,	b|X] = [a,	b,	c].		X = c
