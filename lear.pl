:- include('prints.pl').
:- include('logic.pl').
:- include('stateMachine.pl').
:- use_module(library(clpfd)).

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


verifyRule(Board, NLine, NCol, FinalBoard):-
		getLine(Board, NLine, Line),
		testState(Line, NewLine, 'X '),
		replace(Board, NLine-1, NewLine, NewBoard),
		transpose(NewBoard, TBoard),
		getLine(TBoard, NCol, Col),
		testState(Col, NewCol, 'X '),
		replace(TBoard, NCol-1, NewCol, NewBoard2),
		transpose(NewBoard2, FinalBoard),
		printBoard(FinalBoard), nl.


getLine([H|_],1,H).
getLine([_|T],I,X) :-
    I1 is I-1,
    getLine(T,I1,X).


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



%------------TRANSPOSES A MATRIX-------------

transpose([], []).
transpose([F|Fs], Ts) :-
    transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :-
        lists_firsts_rests(Ms, Ts, Ms1),
        transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
        lists_firsts_rests(Rest, Fs, Oss).
