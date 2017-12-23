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


remove_nth_element(As, N, Bs):-
  same_length(As, [_|Bs]),
  append(Prefix, [_|Suffix] , As),
  length([_|Prefix], N),
  append(Prefix, Suffix, Bs).

set_in(FD, X) :-
  X in_set FD.

restLists(_, []).
restLists(NumSet, [H|T], NewSet):-
  restLists(NumSet, T, NewSet),
  element(N, NumSet, H),
  remove_nth_element(NumSet, N, NewSet).


sumSet(NumSet, Nums):-
  element(N, LineSum, S).

checkLine([], _, _, false).
checkLine([], [Hs], Acc, true):- %write(Acc), write(Hs), nl.
                                  !, sum(Acc, #=, Hs).
checkLine([0 | T], Sums, _, false):-
	checkLine(T, Sums, [], false).

checkLine([0 | T], [Hs | Ts], Acc, true):-
  %write(Acc), write(Hs), nl,
  !, sum(Acc, #=, Hs),
	checkLine(T, Ts, [], false).

%-----------State indica se o último elemento analisado foi um número (true) ou um X/célula vazia (false). O valor inicial é false

checkLine([], _, _, false).
checkLine([], [Hs], Acc, true) :- sum(Acc, #=, Hs).
checkLine([H | T], [Hs | Ts], Acc, State):-
	(H #= 0 #/\ State #= false)#<=> checkLine(T, [Hs | Ts], Acc, false),
	(H #= 0 #/\ State #= true)#<=> (sum(Acc, #=, Hs) #/\ checkLine(T, Ts, [], false)),
	 H #\= 0 #=> checkLine(T, [Hs | Ts], [H | Acc], true).


line_divisions([], []).
%line_divisions([_], []) :- !.
line_divisions([L | Ls] , [D | Ds]):-
	L #\= 0 #<=> D,
	line_divisions(Ls, Ds).
	
	
	
division(Line, Sums):-
	length(Sums, L),
	length(Line, 6),
	domain(Line, 0, 2),
	line_divisions(Line, Types),
	automaton(Types, _, Types, [ source(a), sink(a), sink(b) ],
	[ arc(a, 0, a), arc(a, 1, b, [C + 1]), arc(b, 0, a), arc(b, 1, b) ],
	[C], [0], [L]),
	checkLine(Line, Sums, [], false),
	labeling([], Line).

japanese_sums(Board, NumSet, ColSums, LineSums, Size):-
  matrixLength(Size, Board),
  list_to_fdset(NumSet, FD),
  %maplist(maplist(set_in(FD)), Board).
  maplist(restLists(NumSet), Board).

  %checkLine(['X', 'X', 4, 5, 1, 'X', 'X', 1, 3, 'X', 9, 'X', 'X', 'X'], [10, 4, 9], [], false).
  