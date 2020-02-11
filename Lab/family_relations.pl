mother(X, Y):- female(X), parent(X, Y).
father(X,Y):-male(X), parent(X, Y).
grandparent(P, C):-parent(P, X), parent(X, C).
sister(X, Y):-female(X), parent(B, X), parent(B, Y), X\=Y.
brother(X, Y):-male(X), parent(A, X), parent(A, Y), X\=Y.
aunt(X, Y):-female(X), parent(A, Y), sister(X, A).
cousin(X, Y):-parent(A, X), parent(B, Y), 
                sister(A, B);brother(A, B)).
ancestor(X, Y):-parent(X, Y).
ancestor(X, Y):-parent(A, Y), ancestor(X, A).
descendant(X, Y):-parent(Y, X).
descendant(X, Y):-parent(Y, A), descendant(X, A).