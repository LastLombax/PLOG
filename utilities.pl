
%------------NOT PREDICATE--------

not(X) :- X, !, fail.
not(_).

%------------IF ELSE---------------

it(If, Then):- If, !, Then.
it(_,_).
%------------IF THEN ELSE---------------


ite(If, Then, _):- If, !, Then.
ite(_, _, Else):- Else.


%------------GET LINE-------------

getLine([H|_],1,H).
getLine([_|T],I,X) :-
    I1 is I-1,
    getLine(T,I1,X).


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


%--------COUNT NUM OF OCCURRENCES IN LIST----------

countPieces([_], [], 0).
countPieces([Word], [Word|Tail], Count):-
   countPieces([Word], Tail, X),
   Count is X + 1.
countPieces([Word], [Z|Tail], Count):-
   Word \= Z,
   countPieces([Word], Tail, Count).
