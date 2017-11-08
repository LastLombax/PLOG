
%------------STATE MACHINE-------------

%initial nodes: initial(nodename).
%final nodes: final(nodename).
%edges: arc(from-node, label, to-node).
:- dynamic matrixList/1.
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

player(Piece).
enemyPlayer(EnemyPiece).


testState(List, NewList, CurrPlayer):- assert(matrixList(List)), assert(analiseList([])),
		setCurrPlayer(CurrPlayer), write('CurrPlayer: '), write(CurrPlayer), nl,
		finite_state(1, List, Result, 0), retract(matrixList(NewList)), write('NewListFinal: '), write(NewList), nl.

setCurrPlayer(CurrPlayer):-
	player(CurrPlayer),
	ite(CurrPlayer == 'X ', enemyPlayer('O '), enemyPlayer('X ')).


finite_state(Start, [], Start, _).
finite_state(done, _, done, _) :- !.
finite_state(Start, [Input | Inputs], Finish, Index) :-
		 arc(Start, Input, Next),
		 it( checkCaseB(Start, Input), capturePiecesOnList),
		 analiseList(AuxList),
		 length(AuxList, Length),
	 	 write('AuxList before: '), write(AuxList), nl,
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
			Input == emptyCell -> emptyList
		).

checkCaseB(State, Input):-
		State == 9, Input \= 'O '.

verifyState(AuxList, Next, Index):-
	addToList(AuxList, Index),
	it(Next == 1, emptyList).

emptyList:-
		asserta(analiseList([])).

addToList(AuxList, Index):-
		append(AuxList, [Index], NewAuxList),
		asserta(analiseList(NewAuxList)).


processNext(Next):-
		 Next == 5, capturePiecesOnList.
processNext(Next):-
		 Next == 12, capturePiecesOnList.
processNext(Next).


capturePiecesOnList:-
	retract(matrixList(MatrixList)),
	retract(analiseList(CurrentList)),
	write('On capture: '), nl,
	write('CurrentList: '), write(CurrentList), nl,
	write('MatrixList: '), write(MatrixList), nl,
	capturePieces(CurrentList, MatrixList),
	emptyList.


capturePieces([], MatrixList) :-
	write('NewMatrixList: '), write(MatrixList), nl, asserta(matrixList(MatrixList)).
capturePieces([H|T], MatrixList):-
	replace(MatrixList, H, 'X ', TheMatrixList),
	capturePieces(T, TheMatrixList).


replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):-
		I > -1,
		NI is I-1,
		replace(T, NI, X, R), !.
replace(L, _, _, L).


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
