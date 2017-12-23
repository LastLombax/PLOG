
%------------PRINT BOARD-------------

printBoard(Board, Length):-printRowSeparator(Length), printBoardAux(Board, Length).

printBoardAux([], _).
printBoardAux([Head|Tail], Length) :-
		write('|'),
        printRow(Head),
        printBoard(Tail, Length).


%------------PRINTS A ROW-------------

printRow([]) :- nl.
printRow([0|Tail]) :-
        write('X'),
        write('|'),
        printRow(Tail).

printRow([Head|Tail]) :-
		Head \= emptyCell,
        write(Head),
        write('|'),
        printRow(Tail).


%------------PRINTS A LINE SEPARATOR-------------

printLineSeparator(1):- write('|'), nl.
printLineSeparator(NLines):-
		write('|'),
		nl,
		Next is NLines-1,
		printLineSeparator(Next).

printRowSeparator(0):-write('-'),nl.
printRowSeparator(Length):-
	 write(Length), nl,
		write('--'),
		L is Length-1,
		printRowSeparator(L).
