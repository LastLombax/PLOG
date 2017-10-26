

:- include('prints.pl').


initialBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).


lear:- initialBoard(Board), printBoard(Board), startGame(Board).


startGame(Board):- setPiece(Board, 1, 2, 'X', X), printBoard(X), nl, move(Board).


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



%------------GAME STATE-------------



checkMove(Board, NLine, NCol, Next) :-
	getPiece(Board, NLine, NCol, Piece),
	Piece = emptyCell,
	setPiece(Board, NLine, NCol, 'X', Next).

move(Board) :-
	write('Introduza jogada (Linha. <enter> Coluna.)'), nl,
	read(NLine), nl, read(NCol),
	format("Linha: ~p , Coluna: ~p", [NLine, NCol]), nl,
	(checkMove(Board, NLine, NCol, Next);
		(write('Posição invalida (ja ocupada)'), nl, printBoard(Board))),
	printBoard(Next),
	move(Next).
