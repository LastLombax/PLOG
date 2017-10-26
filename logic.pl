

%------------GAME STATE-------------

checkMove(Board, NLine, NCol, Next) :-
getPiece(Board, NLine, NCol, Piece),
Piece = emptyCell,
setPiece(Board, NLine, NCol, 'X', Next).

move(Board) :-
write('Introduza jogada (Linha. <enter> Coluna.)'), nl,
read(NLine), nl, read(NCol),
format("Linha: ~p , Coluna: ~p", [NLine, NCol]), nl,
(checkMove(Board, NLine, NCol, Next);
(write('Posição invalida (ja ocupada)'), nl, printBoard(Board))),
printBoard(Next),
move(Next).
