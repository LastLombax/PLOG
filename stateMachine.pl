
%------------STATE MACHINE-------------

%initial nodes: initial(nodename).
%final nodes: final(nodename).
%edges: arc(from-node, label, to-node).
:-dynamic index/1.

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

testState:- listA(List), assert(index(1)), finite_state(1, List, Result).


finite_state(Start, [], Start).
finite_state(done, _, done) :- !.
finite_state(Start, [Input | Inputs], Finish) :-
		 write('Start: '), write(Start), nl,
     arc(Start, Input, Next),
		 processNext(Next),
     finite_state(Next, Inputs, Finish).

processNext(Next):-
		Next == 6, captureCaseA.
processNext(Next):-
		 Next == 5, captureCaseA.
processNext(Next):-
		 Next == 9, captureCaseB.
processNext(Next):-
		 Next == 12, captureCaseC.
processNext(Next):-
		 write('continue'), nl.


captureCaseA:-
	write('5'), nl.

captureCaseB:-
	write('9'), nl.

captureCaseC:-
	write('12'), nl.







%se o proximo for 5 ou 12 é um caso
%se o proximo for 9, tem de continuar a ler até nao encontrar um O.
