
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
arc(5,'O ',2).
arc(5,'X ',6).

arc(1,'X ',6).
arc(6,'X ',7).
arc(7,'X ',7).
arc(7,'O ',8).
arc(8,'O ',9).
arc(9,'O ',9).
arc(9,'X ',6).

arc(6,'O ',10).
arc(10,'X ', 1).
arc(10,'O ',11).
arc(11,'O ',11).
arc(11,'X ',12).
arc(12,'X ', 6).
arc(12,'O ', 2).

final(5).
final(9).
final(12).

listA([emptyCell, 'X ', 'O ', 'O ', 'X ', emptyCell, emptyCell, 'X ']).

%listA(['X ', 'X ', 'O ', 'O ', 'O ', emptyCell, 'X ', 'X ']).


%listA(['O ', 'O ', 'O ', 'O ', 'O ', 'X ', 'X ', 'X ']).

testState:- listA(List), assert(analiseList([])), finite_state(1, List, Result, 1). % First state and First index(1st element)


finite_state(Start, [], Start, _).
finite_state(done, _, done, _) :- !.
finite_state(Start, [Input | Inputs], Finish, Index) :-
		 arc(Start, Input, Next),
		 length(AuxList, Length),
		 it( checkCaseB(Start, Input), processNextB(Next)),
		 retract(analiseList(AuxList)),
		 (
		 		Length > 0 -> verifyState(AuxList, Next, Index);
				Length == 0 -> addToEmptyList(AuxList, Input, Index)
		 ),
		 processNext(Next),
		 Ind is Index+1,
     finite_state(Next, Inputs, Finish, Ind).

addToEmptyList(AuxList, Input, Index):-
		(
			Input \= emptyCell -> addToList(AuxList, Index);
			Input == emptyCell -> assert(analiseList([]))
		).

checkCaseB(State, Input):-
		State == 9, Input \= 'O '.

verifyState(AuxList, Next, Index):-
	addToList(AuxList, Index),
	it(Next == 1, emptyList(AuxList)).

emptyList(AuxList):-
		assert(analiseList([])).

addToList(AuxList, Index):-
		append(AuxList, [Index], NewAuxList),
		write('List after add: '), write(NewAuxList), nl,
		assert(analiseList(NewAuxList)).


processNext(Next):-
		 Next == 5, captureCaseA.
processNext(Next):-
		 Next == 12, captureCaseC.
processNext(Next).

processNextB(Next):-
	  captureCaseB.


captureCaseA:-
	write('Captura 5: '), nl, retract(analiseList(CurrentList)), write('Lista caralho: '), write(CurrentList), nl, capturePieces(CurrentList), emptyList(CurrentList).


captureCaseB:-
	write('Captura 9: '), nl, retract(analiseList(CurrentList)), write('Lista caralho: '), write(CurrentList), nl, capturePieces(CurrentList), emptyList(CurrentList).


captureCaseC:-
		write('Captura 12: '), nl, retract(analiseList(CurrentList)), write('Lista caralho: '), write(CurrentList), nl, capturePieces(CurrentList), emptyList(CurrentList).

capturePieces(CurrentList):-
	write(' capture pieces here '), nl.

last([Head],X):-
		X = Head.
last([_|Tail],X):-
		last(Tail,X).


not(X) :- X, !, fail.
not(_).

ite(If, Then, _):- If, !, Then.
ite(_, _, Else):- Else.

it(If, Then):- If, !, Then.
it(_,_).




%se o proximo for 5 ou 12 é um caso
%se o proximo for 9, tem de continuar a ler até nao encontrar um O.
