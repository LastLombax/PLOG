



printBoard(Board):-printRowSeparator, printBoardAux(Board).

printBoardAux([]).
printBoardAux([Head|Tail]) :-
		write('|'),
        printRow(Head),
        printBoard(Tail).

printRow([]) :- nl.
printRow([emptyCell|Tail]) :-
        write('  '),
        write('|'),
        printRow(Tail).

printRow([Head|Tail]) :-
		Head \= emptyCell,
        write(Head),
        write('|'),
        printRow(Tail).


printLineSeparator(1):- write('|'), nl.
printLineSeparator(NLines):-
		write('|'),
		nl,
		Next is NLines-1,
		printLineSeparator(Next).


printRowSeparator:-
		write('------------------------'), nl.
