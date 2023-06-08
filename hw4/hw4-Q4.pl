alpha(0,[]).
alpha(N,[X|Xs]):- N>0, N1 is N-1, alpha(N1,Xs),member(X,[a,b,c,d,e,f,g,h,j]).
alphaHelper(N,X) :- alpha(N,X),is_set(X).
slist(N, L) :- setof(X, alphaHelper(N,X), L).

indexOf([X|_], X, 0):- !.
indexOf([_|Y], X, N):- indexOf(Y, X, N1),!,N is N1+1.

oneCommon([],X,Y,N) :-  N == 0 -> !; fail.
oneCommon([B|Bs],X,Y,N) :- member(B,Y) -> indexOf(Y,B,I),\+(nth0(I,X,B)), N1 is N-1,oneCommon(Bs,X,Y,N1);oneCommon(Bs,X,Y,N).
oneCommon([B|Bs],X,Y,N) :- member(B,Y) ->indexOf(Y,B,I),nth0(I,X,B),oneCommon(Bs,X,Y,N);oneCommon(Bs,X,Y,N).


check1([],X,X) :- !.
check1([Y|Ys],Z,X) :- (oneCommon(Y,Y,[i, j, f, b],2),oneCommon(Y,Y,[c, b, g, j],1), 
					oneCommon(Y,Y,[d, g, j, e],1),oneCommon(Y,Y,[e, h, c, b],1),
					oneCommon(Y,Y,[b, c, d, h],3)) -> check1(Ys,[Y|Z],X); check1(Ys,Z,X).


samePlace([],X,Y,N) :- N == 0 -> !; fail.
samePlace([Z|Zs],X,Y,N) :- member(Z,Y) -> indexOf(Y,Z,I),nth0(I,X,Z), N1 is N-1,samePlace(Zs,X,Y,N1);samePlace(Zs,X,Y,N).
samePlace([Z|Zs],X,Y,N) :- member(Z,Y) ->indexOf(Y,Z,I),\+(nth0(I,X,Z)), samePlace(Zs,X,Y,N);samePlace(Zs,X,Y,N).


check2([],X,X) :- !.
check2([Y|Ys],Z,X) :- (samePlace(Y,Y,[c, b, g, j],1),samePlace(Y,Y,[d, g, j, e],1),samePlace(Y,Y,[e, h, c, b],1)) 
						-> check2(Ys,[Y|Z],X); check2(Ys,Z,X).


solution([A,B,C,D]) :- slist(4,L),check1(L,[],X),check2(X,[],Y), member([A,B,C,D],Y).
