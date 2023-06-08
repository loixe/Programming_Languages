% This is Question 2 Prolog Rules.
% Question 2.1
remove_one(_,[],[]).
remove_one(X,[X|Ys],O) :- remove_one(X,Ys,O),!.
remove_one(X,[Y|Ys],[Y|O]) :- X\=Y -> remove_one(X,Ys,O).
remove_items([],O,O).
remove_items([X|Xs],Y,O) :- remove_one(X,Y,Z), remove_items(Xs,Z,O).

% Question 2.2
my_flatten([],[]) :- !.
my_flatten([X|Xs],F) :- !, my_flatten(X,F1), my_flatten(Xs,F2), append(F1,F2,F).
my_flatten(X,[X]).

% Question 2.3
compress([],[]).
compress([X],[X]).
compress([X,X|Xs],Z) :- compress([X|Xs],Z).
compress([X,Y|Xs],[X|Z]) :- X\=Y -> compress([Y|Xs],Z).

% Question 2.4
% number([X],N,Z) :- append([N+1],[X],P), append(Z,P,Z1).
% number([X,Y|Xs],N,Z) :- X\=Y -> append([N+1],[X],P), number([Y|Xs],0,Z1), append(Z,P,Z1).
% number([X,X|Xs],N,Z) = append([N+1],[X],Z), number([X|Xs],N+1,Y).
% number([X,Y|Xs],[[N,X]|Zs]) :- len([X|Xs],N).

separate([],[]).
separate([X|Xs],[Y|Ys]):- separateHelper(X,Xs,A,Y), separate(A,Ys).

separateHelper(X,[],[],[X]).
separateHelper(X,[Y|Ys],[Y|Ys],[X]):- X\=Y.
separateHelper(X,[X|Xs],Y,[X|Zs]):- separateHelper(X,Xs,Y,Zs).

len([],0).
len([X|Xs],L1) :- len(Xs,L2), L1 is L2+1.

encodeHelper([],[]).
encodeHelper([[X|Xs]|Y],[[N,X]|Z]) :- len([X|Xs],N), encodeHelper(Y,Z).
encode(L1,L2) :- separate(L1,A), encodeHelper(A,L2).


% Question 2.5
encodeMod([],[]).
encodeMod([[N,X]|Xs],[[N,X]|L2]):- N\=1 -> encodeMod(Xs,L2).
encodeMod([[1,X]|Xs],[X|L2]):- encodeMod(Xs,L2).
encode_modified(L1,L2) :- separate(L1,A),encodeHelper(A,B),encodeMod(B,L2).


% Question 2.6
% function len is written above in Question 2.4.
rotate(L2,0,L2).
rotate([X|Xs],N,L2) :- N>0 -> append(Xs,[X],L1),N1 is N-1, rotate(L1, N1,L2), !.
rotate(X,N,L2):- N<0 -> len(X,L), N2 is L+N, rotate(X,N2,L2), !.
% rotate([X|Xs],N,L2) :- N<0 -> len([X|Xs],L), N2 is L+ N-1, append(Xs,[X],L1), rotate(L1,N2,L2),!.