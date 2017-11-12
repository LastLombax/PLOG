bestMove(Board, CurrPlayer, 0, First, FirstLine, FirstCol):-
	retract(bestMoveScore(Player, BestScore, BestLine, BestCol)),
	countScore(Board, Player, Score),
	(
		Score > BestScore -> assert(bestMoveScore(Player, Score, FirstLine, FirstCol));
		Score =< BestScore -> assert(bestMoveScore(Player, BestScore, BestLine, BestCol))
	).

bestMove(Board, CurrPlayer, MovesForward, First, FirstLine, FirstCol) :-
	MovesForward > 0,
	forall((between(1, 8, NLine), between(1, 8, NCol)), \+ project(Board, CurrPlayer, MovesForward, NLine, NCol, First, FirstLine, FirstCol)).
		
	
	

project(Board, CurrPlayer, MovesForward, NLine, NCol, First, FirstLine, FirstCol) :-
	check(Board, NLine, NCol, NextBoard, CurrPlayer),
	verifyRule(NextBoard, NLine, NCol, CurrPlayer, FinalBoard),
	changePlayer(CurrPlayer, NextPlayer),
	NextMoves is MovesForward - 1,
	First -> FirstLine is NLine, FirstCol is NCol,
	bestMove(FinalBoard, NextPlayer, NextMoves, false, FirstLine, FirstCol), fail.

predict(Board, Player, Difficulty, Line, Col) :-
	assert(bestMoveScore(Player, 0, -1, -1)),
	bestMove(Board, Player, Difficulty, true, FirstLine, FirstCol),
	retract(bestMoveScore(Player, BestScore, Line, Col)).
	