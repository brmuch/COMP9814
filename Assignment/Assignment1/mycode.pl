%==========================================================================================================================================
% question 1 : sumsq_even(Numbers, Sum)
sumsq_even([], 0) :- !.                                                                		% base case
sumsq_even([Head|Tail], Result) :- sumsq_even(Tail, Result),                      		% recursive, determine head is odd or even when the List is not empty
								   1 =:= Head mod 2, !.
sumsq_even([Head|Tail], Result) :- sumsq_even(Tail, Return),
								   0 =:= Head mod 2,
								   Result is Return + Head * Head.

%==========================================================================================================================================
% question 2 :  family relationships
same_name(Person1, Person2) :- Person1 == Person2, !.                                          % base case
same_name(Person1, Person2) :-                                                                 % recursive, when they are not the same person
                  (parent(Person, Person1), same_name(Person, Person2), male(Person));
		  (parent(Person3, Person2), same_name(Person1, Person3), male(Person3)).

%==========================================================================================================================================
% question 3 : log_table(NumberList, ResultList)
log_table([], []) :- !.                                                                        % base case, when NumberList is empty
log_table([Head|Tail], [[Head, Log]|Result]) :- log_table(Tail, Result), Log is log(Head).     % recursive, caculate the log of number in NumerList

%==========================================================================================================================================
% question 4 :  paruns(List, RunList)
conc([], X, X).                                                                                % conc(L1, L2, L) the list L is obtained by appending the elements of L2 to L1.
conc([F|R], T, [F|L]) :- conc(R, T, L).

add_into_list(Item, [], [[Item]]) :- !.
add_into_list(Item, [[Head|Tail1]|Tail2], Result) :- Head mod 2 =:= Item mod 2,                % both even or odd
						     conc([Item], [Head|Tail1], Item1),
						     conc([Item1], Tail2, Result), !.
add_into_list(Item, [[Head|Tail1]|Tail2], Result) :- Head mod 2 =\= Item mod 2,                % Parity diff
                                                     conc([[Head|Tail1]], Tail2, List),
						     conc([[Item]], List, Result).

paruns([], []) :- !.
paruns([Head|Tail], Result) :- paruns(Tail, Return), add_into_list(Head, Return, Result).

%==========================================================================================================================================
% question 5 : tree_eval(Value, Tree, Eval)
tree_eval(_, null, 0) :- !.									% base case, when in the leaf of tree
tree_eval(Value, tree(empty, z, empty), Value) :- !.
tree_eval(_, tree(empty, Num, empty), Num) :- !.

tree_eval(Value, tree(L, Op, R), Eval) :- tree_eval(Value, L, EvalL),                           % recursive, when not in leaf node
tree_eval(Value, R, EvalR),
Eq =.. [Op, EvalL, EvalR], Eval is Eq.
%==========================================================================================================================================
