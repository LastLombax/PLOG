


printBoard([]).
printBoard([Head|Tail]) :- 
        printRow(Head),
        printBoard(Tail).

printRow([]) :- nl.
printRow([Head|Tail]) :-
        write(Head),
        write('  '),
        printRow(Tail).


printInitialBoard([]).
printInitialBoard([Head|Tail]) :- 
        printInitialRow(Head),
        printInitialBoard(Tail).

printInitialRow([]) :- nl.
printInitialRow([Head|Tail]) :-
        write('  '),
        write('|'),
        printInitialRow(Tail).



 

