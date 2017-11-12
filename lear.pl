:- include('prints.pl').
:- include('logic.pl').
:- include('stateMachine.pl').
:- include('utilities.pl').
:- include('ia.pl').
:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(aggregate)).

:- dynamic state/3.
:- dynamic bestMoveScore/4.


initialBoardForTesting([
	[emptyCell, emptyCell, emptyCell, emptyCell, 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, 'X ', 'O ', 'O ', 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'X ', 'X ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'O ', 'O ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, 'O ', 'O ', emptyCell, emptyCell, emptyCell],
	[emptyCell, emptyCell, emptyCell, emptyCell, 'O ', emptyCell, emptyCell, emptyCell],
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

lear:- initialBoardForTesting(Board), printBoard(Board), countScore(Board, 'X ', Num), write(Num), nl, getCoordsFromUser(NLine, NCol).


%lear:- initialBoard(Board), startGame(Board).
