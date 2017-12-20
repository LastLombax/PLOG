:- use_module(library(clpfd)).

restrict_line(ArrayValues, FD_set, Sequence, Size) :-
	getSequence(ArrayValues, [], Size, Sequence),
	%Sequence = [b, 3, b, 1]
	%FD_set = [1, 1, 3]
	all_distinct(Aux),
	restrainSequence(FD_set, Sequence, Aux),
	labeling([], Sequence).
	
	

getSequence([], Sequence, Size, Sequence2) :-
	length(Sequence, Size),
	append(Sequence, RestBoxes, Sequence2).
	
	
getSequence([Value | RestVals], Sequence,_, Sequence2) :-
	automaton_slice(Value, Seq),
	append(Sequence, Seq, NewSequence),
	getSequence(RestVals, NewSequence,_, Sequence2). 
	

automaton_slice(Value, Sequence) :-
	automaton(_, _, Sequence,
            [source(s),sink(n)],
            [arc(s,b,s),
             arc(s,N,n,[Sum - N]),
			 arc(n,N,n,[Sum - N])],
            [Sum],[Value],[0]).

restrainSequence(_, [], []).
restrainSequence(FD_set, [H | T], [Haux | Taux]) :-
	element(Haux, FD_set, H),
	restrainSequence(FD_set, T, Taux).
	