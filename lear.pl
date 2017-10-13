

:- include('prints.pl').


initialBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).



	
lear:-initialBoard(Board), printInitialBoard(Board).



getPiece(Board, NLine, NColumn, Piece):- getElemPos(NLine, Board, Line), getElemPos(NColumn, Board, Piece).

setPiece(PrevBoard, NLine, NColumn, Piece, Board):- setNLine(NLine, PrevBoard, NColumn, Piece, Board).

%-----------------------------------

getElemPos(1,[Element|_], Element).
getElemPos(Pos,[_|Tail], Element):- Pos > 1, Next is Pos-1, getElemPos(Next, Tail, Element).

%-----------------------------------

setNLine(1, [Line|Tail], NColumn, Piece, [NewLine| Tail]):- setNColumn(NColumn, Line, Piece, NewLine).
setNLine(Pos, [Line|Tail], NColumn, Piece, [Line| NewTail]):- Pos > 1, Next is Pos-1, setNLine(Next, Line, NColumn, Piece, NewTail).

setNColumn(1, [_|Tail], Piece, [Piece| Tail]).
setNColumn(Pos, [X|Tail], Pos, [X|NewTail]):- Pos > 1, Next is Pos-1, setNColumn(Next, Tail, Piece, NewTail).

%-----------------------------------