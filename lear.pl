:- include('prints.pl').
:- include('logic.pl').
:- include('stateMachine.pl').

:- dynamic state/3.


initialBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, 'X ', 'O ', 'O ', 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'X ', 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'O ', 'O ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'O ', 'O ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).




startGame(Board):-
	 assert(state(Board, 64, 'X ')),
	 play.

lear:- initialBoard(Board), printBoard(Board), getCoordsFromUser(NLine, NCol), verifyRule(Board, NLine, NCol).


% I is the NthRow and H is the Row


verifyRule(Board, NLine, NCol):-
		getLine(Board, NLine, Line),
		testState(Line, NewLine, 'X '),
		write('Old Line: '), write(Line), nl,
		transpose(Board, TBoard),
		write('New Line for Board: '), write(NewLine), nl,
		%transposta da matrix e depois getLine again. Depois das mudanças, voltar a dar transposta.
		getColu(Board, NCol, Colu).


getLine([H|_],1,H).
getLine([_|T],I,X) :-
    I1 is I-1,
    getLine(T,I1,X).

getColu([],_,[]).
getColu([H|T], I, [R|X]):-
   getLine(H, I, R),
	 getColu(T,I,X).


% The Prefix MUST begin with the 1st element(Head) of the list

prefix([ ],L).
prefix([H|T],[H|U]) :- prefix(T,U).

% The Suffix MUST end with the last element of the list

suffix(S,S).
suffix(S,[H|T]) :- suffix(S,T).


% The Sublist will be the intersection between the Prefix and the Suffix

sublist(Sb,L) :- prefix(Sb,L).
sublist(Sb,[H|T]) :- sublist(Sb,T).



%------------GET PIECE-------------

getPiece(Board, NLine, NColumn, Piece):-
		getElemPos(NLine, Board, Line),
		getElemPos(NColumn, Line, Piece).


getElemPos(1,[Element|_], Element).
getElemPos(Pos,[_|Tail], Element):-
		Pos > 1,
		Next is Pos-1,
		getElemPos(Next, Tail, Element).

%------------SET PIECE-------------


setPiece(PrevBoard, NLine, NColumn, Piece, Board):-
		setNLine(NLine, PrevBoard, NColumn, Piece, Board).


setNLine(1, [Line|Tail], NColumn, Piece, [NewLine| Tail]):-
		setNColumn(NColumn, Line, Piece, NewLine).
setNLine(Pos, [Line|Tail], NColumn, Piece, [Line| NewTail]):-
		Pos > 1, Next is Pos-1,
		setNLine(Next, Tail, NColumn, Piece, NewTail).

setNColumn(1, [_|Tail], Piece, [Piece| Tail]).
setNColumn(Pos, [X|Tail], Piece, [X|NewTail]):-
		Pos > 1,
		Next is Pos-1,
		setNColumn(Next, Tail, Piece, NewTail).

