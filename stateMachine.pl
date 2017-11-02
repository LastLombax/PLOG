
%------------STATE MACHINE-------------

%initial nodes: initial(nodename).
%final nodes: final(nodename).
%edges: arc(from-node, label, to-node).
:- dynamic index/1.
:- dynamic analiseList/1.

%f(+State, +Input, -NextState)

arc(_,emptyCell, 1).

arc(1,'O ',2).
arc(2,'X ',1).
arc(2,'O ',3).
arc(3,'O ',3).
arc(3,'X ',4).
arc(4,'O ',1).
arc(4,'X ',5).

arc(1,'X ',6).
arc(6,'X ',7).
arc(7,'X ',7).
arc(7,'O ',8).
arc(8,'O ',9).
arc(9,'O ',9).

arc(6,'O ',10).
arc(10,'X ', 1).
arc(10,'O ',11).
arc(11,'O ',11).
arc(11,'X ',12).

listA([emptyCell, 'X ', 'O ', 'O ', 'X ', emptyCell, emptyCell, emptyCell]).

testState:- listA(List), assert(index(1)), assert(analiseList([])), finite_state(1, List, Result, 1). % First state and First index(1st element)


finite_state(Start, [], Start, _).
finite_state(done, _, done, _) :- !.
finite_state(Start, [Input | Inputs], Finish, Index) :-
		 write('Start: '), write(Start), nl,
		 retract(index(Index)), %may not be needed
		 retract(analiseList(AuxList)),
     arc(Start, Input, Next),
		 length(AuxList, Length),
		 write(Next), nl,
		 (
		 		 Next == 1 , Length > 0 -> emptyList(AuxList);
				 Next > 1 -> addToList(AuxList, Index)
		 ),
		 processNext(Next),
		 Ind is Index+1,
     finite_state(Next, Inputs, Finish, Ind).


processNext(Next):-
		 Next == 5, captureCaseA.
processNext(Next):-
		 Next == 9, captureCaseB.
processNext(Next):-
		 Next == 12, captureCaseC.
processNext(Next):-
		 write('continue'), nl.


captureCaseA:-
	write('5'), nl.

captureCaseB:-
	write('9'), nl.

captureCaseC:-
	write('12'), nl.

%same as just keeping the last item, if it isn't an emptyCell
emptyList(AuxList):-
	last(AuxList, LastElem),
	(
		LastElem == emptyCell -> assert(analiseList([]));
		LastElem \= emptyCell -> assert(analiseList([LastElem]))
	).


last([Head],X):-
		X = Head.
last([_|Tail],X):-
		last(Tail,X).


addToList(AuxList, Index):-
	append(AuxList, Index).


append([], Ys, Ys).
append([X|Xs],Ys, [X|Zs]):-
	 append(Xs,Ys,Zs).

length(List, Length) :-
    (
		var(Length) ->  length(List, 0, Length);
          Length >= 0,
          length1(List, Length)
		).

length([], Length, Length).
length([_|L], N, Length) :-
        N1 is N+1,
        length(L, N1, Length).

length1([], 0) :- !.
length1([_|L], Length) :-
        N1 is Length-1,
        length1(L, N1).



%se o proximo for 5 ou 12 é um caso
%se o proximo for 9, tem de continuar a ler até nao encontrar um O.
