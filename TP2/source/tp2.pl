:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(sets)).
:- use_module(library(aggregate)).
:- use_module(library(random)).
:- use_module(library(system)).


matrixLength(N, Rows) :-
        length(Rows, N),
        maplist(length_list(N), Rows).

length_list(L, Ls) :- length(Ls, L).

checkLine([], _, _, false).
checkLine([], [Hs], Acc, true):- %write(Acc), write(Hs), nl.
                                  !, sum(Acc, #=, Hs).
checkLine(['X' | T], Sums, _, false):-
	checkLine(T, Sums, [], false).

checkLine(['X' | T], [Hs | Ts], Acc, true):-
  %write(Acc), write(Hs), nl,
  !, sum(Acc, #=, Hs),
	checkLine(T, Ts, [], false).

%-----------State indica se o último elemento analisado foi um número (true) ou um X/célula vazia (false). O valor inicial é false
checkLine([H | T], [Hs | Ts], Acc, _):-
	checkLine(T, [Hs | Ts], [H | Acc], true).

japanese_sums(Board, NumSet, ColSums, LineSums, Size):-
	matrixLength(Size, Board),
  checkLine(['X', 'X', 4, 5, 1, 'X', 'X', 1, 3, 'X', 9, 'X', 'X', 'X'], [10, 4, 9], [], false).
