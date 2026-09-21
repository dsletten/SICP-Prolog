#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               count_change.pl
%
%   Started:            Wed May  6 17:24:06 2026
%   Modifications:
%
%   Purpose:
%
%
%
%   Calling Sequence:
%
%
%   Inputs:
%
%   Outputs:
%
%   Example:
%
%   Notes:
%
%%

:- module(count_change, []).

denomination(penny, 1).
denomination(nickel, 5).
denomination(dime, 10).
denomination(quarter, 25).
denomination('half-dollar', 50).

default_coins([penny, nickel, dime, quarter, 'half-dollar']).

%%%
%%%    Infinite loop!
%%%    
%% make_change(0, _, 1).
%% make_change(A, _, 0) :- A < 0.
%% %make_change(_, [], 0).
%% make_change(A, [], 0) :- A > 0.
%% make_change(Amount, Coins, Count) :-
%%     Coins = [C|Cs],
%%     denomination(C, D),
%%     A is Amount - D,
%%     make_change(Amount, Cs, Count1),
%%     make_change(A, Coins, Count2),
%%     Count is Count1 + Count2.

make_change(0, _, 1).
make_change(A, _, 0) :- A < 0.
make_change(A, [], 0) :- A > 0.
make_change(Amount, Coins, Count) :-
    Amount > 0,
    Coins = [C|Cs],
    denomination(C, D),
    A is Amount - D,
    make_change(Amount, Cs, Count1),
    make_change(A, Coins, Count2),
    Count is Count1 + Count2.

make_change_1(0, _, 1) :- !.
make_change_1(A, _, 0) :- A < 0, !.
make_change_1(_, [], 0) :- !.
make_change_1(Amount, Coins, Count) :-
    Coins = [C|Cs],
    denomination(C, D),
    A is Amount - D,
    make_change_1(Amount, Cs, Count1),
    make_change_1(A, Coins, Count2),
    Count is Count1 + Count2.

make_change_3(0, _, 1) :- !.
make_change_3(A, _, 0) :- A < 0, !.
make_change_3(_, [], 0) :- !.
make_change_3(Amount, Coins, Count) :-
    fewer_coins_3(Amount, Coins, Count1),
    less_money_3(Amount, Coins, Count2),
    Count is Count1 + Count2.

fewer_coins_3(Amount, [_|Coins], Count) :-
    make_change_3(Amount, Coins, Count).
less_money_3(Amount, Coins, Count) :-
    Coins = [C|_],
    denomination(C, D),
    A is Amount - D,
    make_change_3(A, Coins, Count).

%%%
%%%    Weird...Prolog is much slower than Lisp but the first version without cuts blows up.
%%%
%% count_change:  ?- default_coins(D), make_change(1000, D, C).
%% ERROR: Stack limit (1.0Gb) exceeded
%% ERROR:   Stack sizes: local: 0.7Gb, global: 0.2Gb, trail: 40.4Mb
%% ERROR:   Stack depth: 135, last-call: 1%, Choice points: 2,648,557
%% ERROR:   Possible non-terminating recursion:
%% ERROR:     [135] count_change:make_change(93, [length:1], _52971100)
%% ERROR:     [134] count_change:make_change(93, [length:2], _52971128)

%% count_change:  ?- default_coins(D), make_change_1(1000, D, C).
%% D = [penny, nickel, dime, quarter, 'half-dollar'],
%% C = 801451.

%% count_change:  ?- default_coins(D), make_change_3(1000, D, C).
%% D = [penny, nickel, dime, quarter, 'half-dollar'],
%% C = 801451.

:- dynamic change/3.

make_change_memoized(0, _, 1) :- !.
make_change_memoized(A, _, 0) :- A < 0, !.
make_change_memoized(_, [], 0) :- !.
make_change_memoized(Amount, Coins, Count) :-
    change(Amount, Coins, Count), !.
make_change_memoized(Amount, Coins, Count) :-
    Coins = [C|Cs],
    denomination(C, D),
    A is Amount - D,
    make_change_memoized(Amount, Cs, Count1),
    make_change_memoized(A, Coins, Count2),
    Count is Count1 + Count2,
    assertz(change(Amount, Coins, Count)).





exercism(Amount, Coins, Result) :-
    sort(0, @=<, Coins, Ascending),
    sort(0, @>=, Coins, Descending),
    make_change(Amount, Descending, [], [], Amount, [], Path),
    build_coins(Path, Ascending, Result).

build_coins([], [], []) :- !.
build_coins([Coin|Coins], [Value|Values], Result) :-
    build(Coin, Value, Vs),
    build_coins(Coins, Values, R),
    append(Vs, R, Result).

build(0, _, []) :- !.
build(C, V, [V|R]) :-
    C1 is C - 1,
    build(C1, V, R).

%%%
%%%    Ugh! `make_change/3' above...
%%%    
make_change(Amount, [], CandidateCoins, CandidateValues, _, _, CandidateCoins) :-
    foldl([X, Y, Sum] >> (Sum is X + Y), CandidateValues, 0, Amount), !.
make_change(_, [], _, _, _, Path, Path) :- !.
make_change(Amount, [V|Coins], CandidateCoins, CandidateValues, Limit, Path, Result) :-
    N is Limit div V,
    iterate(Amount, V, N, Limit, Coins, CandidateCoins, CandidateValues, Path, Result).

path_length(Path, L) :-
    foldl([X, Y, Sum] >> (Sum is X + Y), Path, 0, L).

invalid_path(Path, Candidate) :-
    Path \= [],
    path_length(Path, P),
    path_length(Candidate, C),
    C >= P.

iterate(_, _, N, _, _, _, _, Path, Path) :-
    N < 0, !.
iterate(_, _, N, _, _, CandidateCoins, _, Path, Path) :-
    invalid_path(Path, [N|CandidateCoins]), !.
iterate(Amount, V, N, Limit, Coins, CandidateCoins, CandidateValues, Path, Result) :-
    Value is N * V,
    L is Limit - Value,
    make_change(Amount, Coins, [N|CandidateCoins], [Value|CandidateValues], L, Path, R),
    N1 is N - 1,
    iterate(Amount, V, N1, Limit, Coins, CandidateCoins, CandidateValues, R, Result).


%% count_change:  ?- exercism(1, [1, 5, 10, 25], R).
%% R = [1].

%% count_change:  ?- exercism(25, [1, 5, 10, 25], R).
%% R = [25].

%% count_change:  ?- exercism(15, [1, 5, 10, 25], R).
%% R = [5, 10].

%% count_change:  ?- exercism(23, [1, 4, 15, 20, 50], R).
%% R = [4, 4, 15].

%% count_change:  ?- exercism(63, [1, 5, 10, 21, 25], R).
%% R = [21, 21, 21].

%% count_change:  ?- exercism(999, [1, 2, 5, 10, 20, 50, 100], R).
%% R = [2, 2, 5, 20, 20, 50, 100, 100, 100, 100, 100, 100, 100, 100, 100].

%% count_change:  ?- exercism(21, [2, 5, 10, 20, 50], R).
%% R = [2, 2, 2, 5, 10].

%% count_change:  ?- exercism(27, [4, 5], R).
%% R = [4, 4, 4, 5, 5, 5].

%% count_change:  ?- exercism(20, [1, 10, 11], R).
%% R = [10, 10].

%% count_change:  ?- exercism(0, [1, 5, 10, 21, 25], R).
%% R = [].

%% count_change:  ?- exercism(3, [5, 10], R).
%% false.

%% count_change:  ?- exercism(94, [5, 10], R).
%% false.

%% count_change:  ?- exercism(-5, [1, 2, 5], R).
%% false.
