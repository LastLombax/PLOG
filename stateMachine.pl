
%------------STATE MACHINE-------------

%initial nodes: initial(nodename).
%final nodes: final(nodename).
%edges: arc(from-node, label, to-node).
:-dynamic listPieces/1.

initial(1).
final(5).
final(9).
final(12).


%f(+State, +Input, -NextState)


arc(_,emptyCell, 1).

arc(1,'O ',2).
arc(2,'O ',2).
arc(3,'O ',3).
arc(3,'X ',4).
arc(4,'X ',5).

arc(1,'X ',6).
arc(6,'X ',7).
arc(7,'O ',7).
arc(8,'O ',9).
arc(9,'O ',9).

arc(6,'O ',10).
arc(10,'O ',11).
arc(11,'O ',11).
arc(11,'X ',12).

listA([emptyCell, 'X ', 'O ', 'O ', 'X ', emptyCell, emptyCell, emptyCell]).

testState:- listA(List), finite_state(1, List, Result).


finite_state(Start, [], Start).
finite_state(done, _, done) :- !.
finite_state(Start, [Input | Inputs], Finish) :-
		 write('Start: '), write(Start), nl,
     arc(Start, Input, Next),
		 processNext(Next),
     finite_state(Next, Inputs, Finish).


processNext(Next):-
		 Next == 5, write('5'), nl.
processNext(Next):-
		 Next == 9, write('9'), nl.
processNext(Next):-
		 Next == 12, write('12'), nl.
processNext(Next):-
		 write('continue'), nl.
