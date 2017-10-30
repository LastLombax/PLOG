:- include('prints.pl').
:- include('logic.pl').

:- dynamic state/3.

initialBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, '2', emptyCell, emptyCell, '5', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).


%lear:- initialBoard(Board), startGame(Board).


startGame(Board):-
	 assert(state(Board, 64, 'X ')),
	 play.

lear:- initialBoard(Board), printBoard(Board), getCoordsFromUser(NLine, NCol), getSubList(Board, NLine, NCol).

% I is the NthRow and H is the Row
rowN([H|_],1,H).
rowN([_|T],I,X) :-
    I1 is I-1,
    rowN(T,I1,X).


% getSubList(Board, NLine, NCol) :-


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
