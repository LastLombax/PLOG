
%------------GAME STATE-------------

play :-
	repeat,
		retract(state(Board, Count, Player)),
			printCurrentInfo(Board, Player),
			format('Count = ~p', [Count]), nl,
			once(move(Board, Player, NextBoard)),
			changePlayer(Player, NextPlayer),
			Counter is Count - 1,
		assert(state(NextBoard, Counter, NextPlayer)),
		endGame(Counter).


move(Board, Player, NextBoard):-
		repeat,
			getCoordsFromUser(NLine, NCol),
			check(Board, NLine, NCol, NextBoard, Player).


getCoordsFromUser(NLine, NCol):-
		write('Type Board Coordinates: (Line. <enter> Column.)'), nl,
		read(NLine), nl, read(NCol).


check(Board, NLine, NCol, NextBoard, Player) :-
	getPiece(Board, NLine, NCol, X),
	(
		X == emptyCell -> setPiece(Board, NLine, NCol, Player, NextBoard);
		X \= emptyCell -> write('There is already a piece there! Try again!'), nl, fail
	).


changePlayer('O ', 'X ').
changePlayer('X ', 'O ').


endGame(Count) :-
	Count == 0,
	write('Acabou'), nl.


% ( condition -> then_condition; else_condition)
