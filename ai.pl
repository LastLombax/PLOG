bestMove(Board, CurrPlayer, MovesForward, NLine, NCol) :-


project(Board, CurrPlayer, 0, NLine, NCol)
project(Board, CurrPlayer, MovesForward, NLine, NCol) :-
	check(Board, NLine, Ncol, NextBoard, CurrPlayer),
	verifyRule(NextBoard, NLine, NCol),
