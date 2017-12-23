:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- include('prints.pl').

% ----------Returns the Solution with Left sums(lines) and Up sums(columns)--------------
japaneseSum(Left, Up, Solution) :-
  length(Left, Length),
  length(Solution, Length),
  maplist(same_length(Up), Solution),
  append(Solution, FlatSolution),
  domain(FlatSolution, 0, 9),
  getLines(Solution, Left),
  transpose(Solution, TransposedSolution),
  getLines(TransposedSolution, Up),
  transpose(TransposedSolution, FinalSolution),
  labeling([], FlatSolution),
  printBoard(FinalSolution, Length).


% ----------Restrains each Line of the Board, using the getLine predicate--------------
getLines([], []).
getLines([HLines | TLines], [HSums | TSums]) :-
  getLine(HLines, HSums),
  getLines(TLines, TSums).

% ------Generates a line and restrains each element to be between 0 and, at max, the maximum number of the Sums list and calls restrictBySums--------------
getLine(_, []).
getLine(Line, Sums) :-
  maximum(Max, Sums),
  domain(Line, 0, Max),
  restrictBySums(Line, Sums).

% -------Restrains each Line sum to be equal to the value(Number) from the Sums list--------------
restrictBySums(Line, [Number]) :-
  sum(Line, #=, Number),
  restrictConsecutive(Line).

restrictBySums(Line, Sums) :-
  length(Sums, Length),
  length(LineParts, Length),
  append(LineParts, Line),
  restrictMultipleSums(LineParts, Sums).

% ----------Restrains the line so it has one division. Called if the Sums List length is less than 2--------------
restrictConsecutive(Line) :-
  restrictConsecutiveAux(Line, 0, 0).

restrictConsecutiveAux([], _, NewCount) :- NewCount #=< 2.
restrictConsecutiveAux([H | T], Before, Count) :-
  (Before #= 0 #/\ H #> 0) #<=> Begin,
  (Before #> 0 #/\ H #= 0) #<=> End,
  NewCount #= Count + Begin + End,
  restrictConsecutiveAux(T, H, NewCount).

% ----------Restrains the line if the Sums List length is bigger than 1--------------
restrictMultipleSums([HLine], [HSum]) :-
  sum(HLine, #=, HSum),
  restrictConsecutive(HLine),
  length(HLine, Length),
  Length #> 0.

restrictMultipleSums([HLine | TLine], [HSum | TSum]) :-
  sum(HLine, #=, HSum),
  restrictConsecutive(HLine),
  length(HLine, Length),
  Length #> 0,
  element(Length, HLine, 0),
  restrictMultipleSums(TLine, TSum).


% ----------An example test--------------
test1(Solution):-
  Left = [_, [3, 1], [5], [4]],
  Up = [[4], [1, 4], [2], [4]],
  japaneseSum(Left, Up, Solution).
