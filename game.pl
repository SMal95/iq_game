% Samuel M
% Homework 6 - Cracker Barrel IQ Peg Game
% look at README for run instructions.
:- use_module(library(lambda)).

%%%%%Move Definitions%%%%
% (from peg, over peg, to location) %

move(S,2,D) :-
	member([S,D], [[1,4], [4,1]]).
move(S,3,D) :-
	member([S,D], [[1,6], [6,1]]).
move(S,4,D) :-
	member([S,D], [[2,7], [7,2]]).
move(S,5,D) :-
	member([S,D], [[2,9], [9,2]]).
move(S,5,D) :-
	member([S,D], [[3,8], [8,3]]).
move(S,5,D) :-
	member([S,D], [[4,6], [6,4]]).
move(S,6,D) :-
	member([S,D], [[3,10], [10,3]]).
move(S,7,D) :-
	member([S,D], [[4,11], [11,4]]).
move(S,8,D) :-
	member([S,D], [[4,13], [13,4]]).
move(S,8,D) :-
	member([S,D], [[5,12], [12,5]]).
move(S,8,D) :-
	member([S,D], [[7,9], [9,7]]).
move(S,9,D) :-
	member([S,D], [[5,14], [14,5]]).
move(S,9,D) :-
	member([S,D], [[6,13], [13,6]]).
move(S,9,D) :-
	member([S,D], [[8,10], [10,8]]).
move(S,10,D) :-
	member([S,D], [[6,15], [15,6]]).
move(S,12,D) :-
	member([S,D], [[11,13], [13,11]]).
move(S,13,D) :-
	member([S,D], [[12,14], [14,12]]).
move(S,14,D) :-
	member([S,D], [[13,15], [15,13]]).

%%%%%Initialize%%%%

iq_game :-
	iq_game(Solutions),
	print(Solutions).

%%%%%Generate solution%%%%

% @
%change the peg number within parameter one in exe()
% and remove that peg number from the list in parameter two
% to solve for when that peg is empty
% example to solve for peg 4:
%     -> exe([4], [1,2,3,5,6,7,8,9,10,11,12,13,14,15], [], Solutions).
iq_game(Solutions) :-
	exe([5], [1,2,3,4,6,7,8,9,10,11,12,13,14,15], [], Solutions).

exe(_, [_], List, Solutions) :-
	reverse(List, Solutions).

exe(Free, Occupied, List, Solutions) :-
	select(S, Occupied, O1),
	select(O, O1, O2),
	select(D, Free, F1),
	move(S,O,D),
	exe([S, O | F1], [D | O2], [move(S,O,D) | List], Solutions).

%%%%Print the solution%%%%

% @
%change the peg number within the second parameter in print()
% to solve for when that peg is empty %
% hint-> print(Solutions, [peg#]).
print(Solutions) :-
	print(Solutions, [5]).

% numlist and maplist are built in Prolog funtions
% format and writeln are forms of output for Prolog
% ...\X^I^... requires Prolog lambda library
print([], Free) :-
	numlist(1, 15, List),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1), List,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	writeln('Game Complete.').

print([move(Source, Jumped, Open) | Tail], Free) :-
	numlist(1, 15, List),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1), List,
		[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	format('Move: From peg ~w, over peg ~w, to ~w~n', [Source, Jumped, Open]),
	select(Open, Free, F1),
	print(Tail, [Source, Jumped | F1]).