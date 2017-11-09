
%------------STATE MACHINE-------------

%initial nodes: initial(nodename).
%final nodes: final(nodename).
%edges: arc(from-node, label, to-node).
:- dynamic matrixList/1.
:- dynamic analiseList/1.
%f(+State, +Input, -NextState)

% for Black Team Player
arcX(_,emptyCell, 1).

arcX(1,'O ',2).
arcX(2,'X ',1).
arcX(2,'O ',3).
arcX(3,'O ',3).
arcX(3,'X ',4).
arcX(4,'O ',1).
arcX(4,'X ',5).
arcX(5,'O ',2).
arcX(5,'X ',6).

arcX(1,'X ',6).
arcX(6,'X ',7).
arcX(7,'X ',7).
arcX(7,'O ',8).
arcX(8,'O ',9).
arcX(9,'O ',9).
arcX(9,'X ',6).

arcX(6,'O ',10).
arcX(10,'X ', 1).
arcX(10,'O ',11).
arcX(11,'O ',11).
arcX(11,'X ',12).
arcX(12,'X ', 6).
arcX(12,'O ', 2).

% for White Team Player
arcO(_,emptyCell, 1).

arcO(1,'X ',2).
arcO(2,'O ',1).
arcO(2,'X ',3).
arcO(3,'X ',3).
arcO(3,'O ',4).
arcO(4,'X ',1).
arcO(4,'O ',5).
arcO(5,'X ',2).
arcO(5,'O ',6).

arcO(1,'O ',6).
arcO(6,'O ',7).
arcO(7,'O ',7).
arcO(7,'X ',8).
arcO(8,'X ',9).
arcO(9,'X ',9).
arcO(9,'O ',6).

arcO(6,'X ',10).
arcO(10,'O ', 1).
arcO(10,'X ',11).
arcO(11,'X ',11).
arcO(11,'O ',12).
arcO(12,'O ', 6).
arcO(12,'X ', 2).


final(5).
final(9).
final(12).

%SO PARA CONCLUSOES:

%Para peça X e inimigo O :
	% Caso X OOO X e semelhantes funcional (Caso A);
	% Caso XX OOOO(tudo O's) funcional(Caso B);
	% Caso OOO XX -> CONFIRM


testState(List, NewList, CurrPlayer):- assert(matrixList(List)), assert(analiseList([])),
		finite_state(1, List, Result, 0, CurrPlayer), retract(matrixList(NewList)), emptyList, write('NewListFinal: '), write(NewList), nl.


finite_state(Start, [], Start, _, _).
finite_state(done, _, done, _, _) :- !.
finite_state(Start, [Input | Inputs], Finish, Index, Player) :-
		 %write('Index: '),  write(Index), nl,
		 ite(Player == 'X ',  arcX(Start, Input, Next), arcO(Start, Input, Next)),
		% it( checkCaseB(Start, Input,Player, Index), capturePiecesOnList(Player)),
		 analiseList(AuxList),
		 length(AuxList, Length),
		 write('Next: '), write(Next), nl,
	 	 write('AuxList before: '), write(AuxList), nl,
		 (
		 		Length > 0 -> verifyState(AuxList, Next, Index);
				Length == 0 -> addToEmptyList(AuxList, Input, Index)
		 ),
		 it( checkCaseB(Start, Input,Player, Index), capturePiecesOnList(Player)),
		 processNext(Next, Player),
		 Ind is Index+1,
     finite_state(Next, Inputs, Finish, Ind, Player).

addToEmptyList(AuxList, Input, Index):-
		(
			Input \= emptyCell -> addToList(AuxList, Index);
			Input == emptyCell -> emptyList
		).

checkCaseB(State, Input,Player, Index):-
	  ite(Player == 'X ',  checkCaseBX(State, Input, Index), checkCaseBO(State, Input, Index)).

checkCaseBX(State, Input, Index):-
	  State == 9, (Input \= 'O ' ; Index == 7).

checkCaseBO(State, Input, Index):-
	  State == 9, (Input \= 'X '; Index == 7).


verifyState(AuxList, Next, Index):-
	addToList(AuxList, Index),
	it(Next == 1, emptyList).

emptyList:-
		asserta(analiseList([])).

addToList(AuxList, Index):-
		append(AuxList, [Index], NewAuxList),
		asserta(analiseList(NewAuxList)).


processNext(Next,Player):-
		 Next == 5, capturePiecesOnList(Player).
processNext(Next,Player):-
		 Next == 12, capturePiecesOnList(Player).
processNext(Next, Player).


capturePiecesOnList(Player):-
	retract(matrixList(MatrixList)),
	retract(analiseList(CurrentList)),
	write('On capture: '), nl,
	write('CurrentList: '), write(CurrentList), nl,
	write('MatrixList: '), write(MatrixList), nl,
	capturePieces(CurrentList, MatrixList,Player),
	emptyList.


capturePieces([], MatrixList, _) :-
	write('NewMatrixList: '), write(MatrixList), nl, asserta(matrixList(MatrixList)).
capturePieces([H|T], MatrixList, Player):-
	%ite(Player == 'X ', replace(MatrixList, H, 'X ', TheMatrixList ), replace(MatrixList, H, 'O ', TheMatrixList) ),
	replace(MatrixList, H, Player, TheMatrixList ),
	capturePieces(T, TheMatrixList,Player).


replace([_|T], 0, PlayerPiece, [PlayerPiece|T]).
replace([H|T], I, PlayerPiece, [H|R]):-
		I > -1,
		NI is I-1,
		replace(T, NI, PlayerPiece, R), !.
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
