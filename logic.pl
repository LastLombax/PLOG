

%------------GAME STATE-------------

move(Board) :-
	write('Type Board Coordinates (Line. <enter> Column.)'), nl,
	read(NLine), nl, read(NCol),
	check(Board, NLine, NCol, Next),
	move(Next).

check(Board, NLine, NCol, Next) :-
	getPiece(Board, NLine, NCol, X),
	write(X), nl,
	(
		X == emptyCell -> setPiece(Board, NLine, NCol, 'X', Next), printBoard(Next);
		X \= emptyCell -> write('You CANT put it'), nl
	).
	
% ( condition -> then_condition; else_condition)