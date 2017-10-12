level(empty, 0).
level(n1h, 1).
level(n2h, 2).
level(n3h, 3).
level(n1p, 1).
level(n2p, 2).
level(n3p, 3).

type(empty, none).
type(n1h, hole).
type(n2h, hole).
type(n3h, hole).
type(n1p, plain).
type(n2p, plain).
type(n3p, plain).

combine(empty, Piece, Piece).
combine(n1h, n1h, n2h).
combine(n1h, n2h, n3h).
combine(n1h, n1p, n2p).
combine(n1h, n2p, n3p).
combine(n1p, n1h, n2h).
combine(n1p, n2h, n3h).
combine(n1p, n1p, n2p).
combine(n1p, n2p, n3p).


movePiece(Piece, Row, Col, Board, NewBoard) :-
				getMatrixElemAt(Row, Col, Board, CurrentPiece),
				level(CurrentPiece, CurPieceHeight),
				CurPieceHeight < 2,
				combine(CurrentPiece, Piece, NewPiece),
				setMatrixElemAtWith(Row, Col, NewPiece, Board, NewBoard).

movePiece(Piece, Row, Col, Board, Board) :-
				getMatrixElemAt(Row, Col, Board, CurrentPiece),
				level(CurrentPiece, CurPieceHeight),
				\+ CurPieceHeight < 2,
				write('nao da para jogar a peca').






% Board preset

initialBoard([
			[empty, empty, empty, empty],
			[empty, empty, empty, empty],
			[empty, empty, empty, empty],
			[empty, empty, empty, empty]]).












%%%%%%% Test Winning the game %%%%%%%%

gameWin(Board) :- getMatrixElemAt(0,0,Board, Elem1), getMatrixElemAt(0,1,Board, Elem2), getMatrixElemAt(0,2,Board, Elem3), getMatrixElemAt(0,3,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(1,0,Board, Elem1), getMatrixElemAt(1,1,Board, Elem2), getMatrixElemAt(1,2,Board, Elem3), getMatrixElemAt(1,3,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(2,0,Board, Elem1), getMatrixElemAt(0,1,Board, Elem2), getMatrixElemAt(2,2,Board, Elem3), getMatrixElemAt(2,3,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(3,0,Board, Elem1), getMatrixElemAt(3,1,Board, Elem2), getMatrixElemAt(3,2,Board, Elem3), getMatrixElemAt(3,3,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(0,0,Board, Elem1), getMatrixElemAt(1,0,Board, Elem2), getMatrixElemAt(2,0,Board, Elem3), getMatrixElemAt(3,0,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(0,1,Board, Elem1), getMatrixElemAt(1,1,Board, Elem2), getMatrixElemAt(2,1,Board, Elem3), getMatrixElemAt(3,1,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(0,2,Board, Elem1), getMatrixElemAt(1,2,Board, Elem2), getMatrixElemAt(2,2,Board, Elem3), getMatrixElemAt(3,2,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(0,3,Board, Elem1), getMatrixElemAt(1,3,Board, Elem2), getMatrixElemAt(2,3,Board, Elem3), getMatrixElemAt(3,3,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(0,0,Board, Elem1), getMatrixElemAt(1,1,Board, Elem2), getMatrixElemAt(2,2,Board, Elem3), getMatrixElemAt(3,3,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).

gameWin(Board) :- getMatrixElemAt(0,3,Board, Elem1), getMatrixElemAt(1,2,Board, Elem2), getMatrixElemAt(2,1,Board, Elem3), getMatrixElemAt(3,0,Board, Elem4),
									test4Line(Elem1, Elem2, Elem3, Elem4).




test4Line(Elem1, Elem2, Elem3, Elem4) :- level(Elem1, ElemLv),
																				 level(Elem2, ElemLv),
																				 level(Elem3, ElemLv),
																				 level(Elem4, ElemLv).

test4Line(Elem1, Elem2, Elem3, Elem4) :- type(Elem1, ElemType),
																				 type(Elem2, ElemType),
																				 type(Elem3, ElemType),
																				 type(Elem4, ElemType).

checkStairs(Row, Col, Board, x, y) :- \+ x == 0;
																			\+ y == 0,
																			NewX is Row + x,
																			NewY is Col + y,
																			getMatrixElemAt(NewX, NewY, Board, Elem),
																			level(Elem, ElemLv),
																			ElemLv == 2 -> checkStairsNext();
																			callStairs(Row, Col, Board, x, y).


checkStairsNext(Row, Col, )


callStairs(Row, Col, Board, x, y) :- x == 1,
																		 y == 1.

callStairs(Row, Col, Board, x, y) :- x \== 1,
																		 NewX is x + 1,
																		 checkStairs(Row, Col, Board, NewX, y).

callStairs(Row, Col, Board, x, y) :- x == 1,
																		 y \== 1,
																		 NewY is y + 1,
																		 checkStairs(Row, Col, Board, -1, NewY).




startGame :-
					initialBoard(Board),



player1turn(Board) :-
					printBoard(Board),
					write('Player one: choose piece').







%%%%%%%%% Print Board %%%%%%%%%%%


print :- initialBoard(Board), movePiece(n2h, 1, 1, Board, NewBoard),
			movePiece(n2p, 0, 1, NewBoard, NewBoard1),
			movePiece(n1h, 2, 2, NewBoard1, NewBoard2),
			movePiece(n1h, 3, 1, NewBoard2, NewBoard3),
			movePiece(n2p, 3, 1, NewBoard3, NewBoard4),
			movePiece(n1p, 3, 3, NewBoard4, NewBoard5),
			movePiece(n2h, 1, 2, NewBoard5, NewBoard6),printBoard(NewBoard6).



printBoard(Board) :-
					put_code(201),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(203),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(203),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(203),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(187), nl,
					getListElemAt(0, Board, Array0),
					printLine(Array0), nl,
					put_code(204),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(185), nl,
					getListElemAt(1, Board, Array1),
					printLine(Array1), nl,
					put_code(204),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(185), nl,
					getListElemAt(2, Board, Array2),
					printLine(Array2), nl,
					put_code(204),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(206),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(185), nl,
					getListElemAt(3, Board, Array3),
					printLine(Array3), nl,
					put_code(200),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(202),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(202),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(202),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(205),put_code(188).


printLine(Array) :- printLine(1, Array).

printLine(Line, Array) :-
					Line == 1,
					put_code(186), write('           '), put_code(186), write('           '), put_code(186), write('           '), put_code(186), write('           '), put_code(186), nl,
					printLine(2, Array).

printLine(Line, Array) :-
					Line == 2,
					getListElemAt(0, Array, Elem1),
					getListElemAt(1, Array, Elem2),
					getListElemAt(2, Array, Elem3),
					getListElemAt(3, Array, Elem4),
					put_code(186), printCelTop(Elem1), put_code(186), printCelTop(Elem2), put_code(186), printCelTop(Elem3), put_code(186), printCelTop(Elem4), put_code(186), nl,
					printLine(3,Array).

printLine(Line, Array) :-
					Line == 3,
					getListElemAt(0, Array, Elem1),
					getListElemAt(1, Array, Elem2),
					getListElemAt(2, Array, Elem3),
					getListElemAt(3, Array, Elem4),
					put_code(186), printCelInt(Elem1), put_code(186), printCelInt(Elem2), put_code(186), printCelInt(Elem3), put_code(186), printCelInt(Elem4), put_code(186), nl,
					printLine(4,Array).

printLine(Line, Array) :-
					Line == 4,
					getListElemAt(0, Array, Elem1),
					getListElemAt(1, Array, Elem2),
					getListElemAt(2, Array, Elem3),
					getListElemAt(3, Array, Elem4),
					put_code(186), printCelBot(Elem1), put_code(186), printCelBot(Elem2), put_code(186), printCelBot(Elem3), put_code(186), printCelBot(Elem4), put_code(186), nl,
					printLine(5,Array).

printLine(Line, Array) :-
					Line == 5,
					getListElemAt(0, Array, Elem1),
					getListElemAt(1, Array, Elem2),
					getListElemAt(2, Array, Elem3),
					getListElemAt(3, Array, Elem4),
					put_code(186), write(' '), level(Elem1, Elem1Lv), write(Elem1Lv), write('         '), put_code(186), write(' '), level(Elem2, Elem2Lv), write(Elem2Lv), write('         '), put_code(186), write(' '), level(Elem3, Elem3Lv), write(Elem3Lv), write('         '), put_code(186), write(' '), level(Elem4, Elem4Lv), write(Elem4Lv), write('         '), put_code(186).


printCelTop(Elem) :- Elem == empty,
					write('           ').

printCelTop(Elem) :- Elem \== empty,
					write('   '), put_code(218), put_code(196), put_code(196), put_code(196), put_code(191), write('   ').

printCelBot(Elem) :- Elem == empty,
					write('           ').

printCelBot(Elem) :- Elem \== empty,
					write('   '), put_code(192), put_code(196), put_code(196), put_code(196), put_code(217), write('   ').

printCelInt(Elem) :- Elem == empty,
					write('           ').

printCelInt(Elem) :- Elem \== empty,
					type(Elem, ElemType),
					ElemType == hole,
					write('   '), put_code(179), write(' O '), put_code(179), write('   ').

printCelInt(Elem) :- Elem \== empty,
					type(Elem, ElemType),
					ElemType == plain,
					write('   '), put_code(179), write('   '), put_code(179), write('   ').
