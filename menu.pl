
%------------MAIN MENU---------------

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


%------------MAIN MENU PRINT---------------

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

%----------GAME MODE MENU-------------

gameModeMenu:-
	printgameModeMenu,
	getChar(Input),
	(
		Input = '1' -> startPvPGame;
		Input = '2' -> chooseAILevelMenu;
		Input = '3' -> chooseAILevelMenu;
		Input = '4' -> mainMenuLear;

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		gameModeMenu
	).

%------------GAME MODE MENU PRINT---------------

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


%------------AI LEVEL MENU PRINT---------------

printAILevelMenu:-
	clearTheConsole,
	write(' -------------------------------'), nl,
	write('|           AI LEVEL            |'), nl,
	write('|                               |'), nl,
	write('|   1. Random Plays             |'), nl,
	write('|   2. Checks 2 plays ahead     |'), nl,
	write('|   3. Back                     |'), nl,
	write('|                               |'), nl,
	write(' -------------------------------'), nl,
	write('Choose an option(without the dot):'), nl.


%------------AI LEVEL MENU---------------

chooseAILevelMenu:-
	printAILevelMenu,
	getChar(Input),
	(
		Input = '1' -> startPvBGame;
		Input = '2' -> startPvBGame;
		Input = '3' -> mainMenuLear;

		nl,
		write('Error: invalid input.'), nl,
		pressEnterToContinue, nl,
		gameModeMenu
	).


%------------STARTS PLAYER VS PLAYER------------

startPvPGame:-
	startGame.


%------------STARTS PLAYER VS AI---------------

startPvBGame:-
	createPvBGame(Game),
	playGame(Game).


%------------STARTS AI VS AI---------------

startBvBGame:-
	createBvBGame(Game),
	playGame(Game).
