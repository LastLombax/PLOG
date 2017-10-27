

%------------GAME STATE-------------

	
play :-
	repeat, 
		retract(state(Board, Count, Player)),
		format('Count = ~p', [Count]), nl,
		once(move(Board, Player, NextBoard)),
		changePlayer(Player, NextPlayer),
		Counter is Count - 1,
		assert(state(NextBoard, Counter, NextPlayer)),
		endGame(Count).
	
	

move(Board, Player, NextBoard):-
		repeat,
			write('Type Board Coordinates (Line. <enter> Column.)'), nl,
			read(NLine), nl, read(NCol),
			check(Board, NLine, NCol, NextBoard, Player).
			
check(Board, NLine, NCol, NextBoard, Player) :-
	getPiece(Board, NLine, NCol, X),
	write(X), nl,
	(
		X == emptyCell -> setPiece(Board, NLine, NCol, Player, NextBoard), printBoard(NextBoard);
		X \= emptyCell -> write('You CANT put it'), nl, fail
	).

changePlayer('O ', 'X ').
changePlayer('X ', 'O ').
	
% ( condition -> then_condition; else_condition)

endGame(Count) :-
	Count == 0,
	write('Acabou'), nl, fail.
