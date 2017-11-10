:- include('prints.pl').
:- include('logic.pl').
:- include('stateMachine.pl').
:- include('utilities.pl').
:- use_module(library(clpfd)).
:- use_module(library(lists)).

:- dynamic state/3.


initialBoardForTesting([
	[emptyCell, emptyCell, emptyCell, emptyCell, 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, 'X ', 'O ', 'O ', 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'X ', 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'O ', 'O ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'O ', 'O ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).

	initialBoard([
	[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell],
		[emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell, emptyCell]]).


startGame(Board):-
	 assert(state(Board, 64, 'X ')),
	 play.

lear:- initialBoard(Board), printBoard(Board), countScore(Board, 'X ', 0, Num), write(Num), nl, getCoordsFromUser(NLine, NCol).


%lear:- initialBoard(Board), startGame(Board).
