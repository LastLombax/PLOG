%=================%
%= @@ game menus =%
%=================%
mainMenuLear:-
	printMainMenu,
	getChar(Input),
	(
		Input = '1' -> gameModeMenu;
		Input = '2';

		nl,
		write('Invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenuLear
	).

printMainMenu:-
	clearTheConsole,
	write(' -------------------------------'), nl,
	write('|             LEAR              |'), nl,
	write('|                               |'), nl,
	write('|   1. Play a match             |'), nl,
	write('|   2. Exit                     |'), nl,
	write('|                               |'), nl,
	write(' -------------------------------'), nl,
	write('Choose an option(without the dot):'), nl.


gameModeMenu:-
	printgameModeMenu,
	getChar(Input),
	(
		Input = '1' -> startPvPGame;
		Input = '2' -> startPvBGame;
		Input = '3' -> startBvBGame;
		Input = '4' -> mainMenuLear;

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		gameModeMenu
	).

printgameModeMenu:-
	clearTheConsole,
	write(' -------------------------------'), nl,
	write('|           Game Mode           |'), nl,
	write('|                               |'), nl,
	write('|   1. Player vs. Player        |'), nl,
	write('|   2. Player vs. Computer      |'), nl,
	write('|   3. Computer vs. Computer    |'), nl,
	write('|   4. Back                     |'), nl,
	write('|                               |'), nl,
	write(' -------------------------------'), nl,
	write('Choose an option(without the dot):'), nl.

startPvPGame:-
	startGame.

startPvBGame:-
	createPvBGame(Game),
	playGame(Game).
startBvBGame:-
	createBvBGame(Game),
	playGame(Game).
