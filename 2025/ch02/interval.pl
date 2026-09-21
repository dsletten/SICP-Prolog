#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               interval.pl
%
%   Started:            Fri Aug  7 13:11:43 2026
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

:- module(interval, []).

%%%
%%%    2.7
%%%
make_interval(L, U, interval(L, U)) :- L =< U.
lower_bound(interval(L, _), L).
upper_bound(interval(_, U), U).

print_interval(X) :-
    lower_bound(X, L),
    upper_bound(X, U),
    write('['),
    write(L),
    write(', '),
    write(U),
    write(']').

equal_interval(X, Y) :-
    lower_bound(X, L0),
    upper_bound(X, U0),
    lower_bound(Y, L1),
    upper_bound(Y, U1),
    L0 =:= L1,
    U0 =:= U1.

add_interval(X, Y, Z) :-
    lower_bound(X, L0),
    upper_bound(X, U0),
    lower_bound(Y, L1),
    upper_bound(Y, U1),
    L2 is L0 + L1,
    U2 is U0 + U1,
    make_interval(L2, U2, Z).

mul_interval(X, Y, Z) :-
    lower_bound(X, L0),
    upper_bound(X, U0),
    lower_bound(Y, L1),
    upper_bound(Y, U1),
    min_max(L0, U0, L1, U1, Min, Max),
    make_interval(Min, Max, Z).

%% min_max(A, B, C, D, Min, Max) :-
%%     P0 is A * C,
%%     P1 is A * D,
%%     P2 is B * C,
%%     P3 is B * D,
%%     min_list([P0, P1, P2, P3], Min),
%%     max_list([P0, P1, P2, P3], Max).

%%%
%%%    2.11
%%%    
min_max(A, B, C, D, Min, Max) :-
    A >= 0,
    C >= 0,
    !,
    Min is A * C,
    Max is B * D.
min_max(A, B, C, D, Min, Max) :-
    A >= 0,
    D =< 0,
    !,
    Min is B * C,
    Max is A * D.
min_max(A, B, C, D, Min, Max) :-
    A >= 0,
    !,
    Min is B * C,
    Max is B * D.
min_max(A, B, C, D, Min, Max) :-
    B =< 0,
    C >= 0,
    !,
    Min is A * D,
    Max is B * C.
min_max(A, B, C, D, Min, Max) :-
    B =< 0,
    D =< 0,
    !,
    Min is B * D,
    Max is A * C.
min_max(A, B, C, D, Min, Max) :-
    B =< 0,
    !,
    Min is A * D, 
    Max is A * C.
min_max(A, B, C, D, Min, Max) :-
    C >= 0,
    !,
    Min is A * D,
    Max is B * D.
min_max(A, B, C, D, Min, Max) :-
    D =< 0,
    !,
    Min is B * C,
    Max is A * C.
min_max(A, B, C, D, Min, Max) :-
    P0 is A * C,
    P1 is A * D,
    P2 is B * C,
    P3 is B * D,
    Min is min(P1, P2),
    Max is max(P0, P3).

test_mul_interval([A, B], [C, D], Z) :-
    make_interval(A, B, X),
    make_interval(C, D, Y),
    mul_interval(X, Y, Z).

%%  Commutative
%% interval:  ?- test_mul_interval([7, 11], [3, 6], Z).
%% Z = interval(21, 66).

%% interval:  ?- test_mul_interval([3, 6], [7, 11], Z).
%% Z = interval(21, 66).

%%  Associative
%% interval:  ?- make_interval(4, 6, X), make_interval(1, 2, Y), make_interval(3, 5, Z), mul_interval(Y, Z, A), mul_interval(X, A, B).
%% X = interval(4, 6),
%% Y = interval(1, 2),
%% Z = interval(3, 5),
%% A = interval(3, 10),
%% B = interval(12, 60).

%% interval:  ?- make_interval(4, 6, X), make_interval(1, 2, Y), make_interval(3, 5, Z), mul_interval(X, Y, A), mul_interval(A, Z, B).
%% X = interval(4, 6),
%% Y = interval(1, 2),
%% Z = interval(3, 5),
%% A = interval(4, 12),
%% B = interval(12, 60).

%%  Distributive
%% interval:  ?- make_interval(0, 2, X), make_interval(9, 12, Y), make_interval(6, 8, Z), add_interval(Y, Z, A), mul_interval(X, A, B).
%% X = interval(0, 2),
%% Y = interval(9, 12),
%% Z = interval(6, 8),
%% A = interval(15, 20),
%% B = interval(0, 40).

%% interval:  ?- make_interval(0, 2, X), make_interval(9, 12, Y), make_interval(6, 8, Z), mul_interval(X, Y, A), mul_interval(X, Z, B), add_interval(A, B, C).
%% X = interval(0, 2),
%% Y = interval(9, 12),
%% Z = interval(6, 8),
%% A = interval(0, 24),
%% B = interval(0, 16),
%% C = interval(0, 40).

spans_zero(X) :-
    lower_bound(X, L),
    upper_bound(X, U),
    L =< 0,
    0 =< U.

reciprocal(X, Y) :-
    \+ spans_zero(X),
    lower_bound(X, L),
    upper_bound(X, U),
    L1 is 1 / U,
    U1 is 1 / L,
    make_interval(L1, U1, Y).

div_interval(X, Y, Z) :-
    reciprocal(Y, Y1),
    mul_interval(X, Y1, Z).

opposite(X, Y) :-
    lower_bound(X, L),
    upper_bound(X, U),
    L1 is -U,
    U1 is -L,
    make_interval(L1, U1, Y).

sub_interval(X, Y, Z) :-
    opposite(Y, Y1),
    add_interval(X, Y1, Z).

%%%
%%%    Wrapper around original constructor.
%%%    
make_center_width(C, W, X) :-
    L is C - W,
    U is C + W,
    make_interval(L, U, X).

%% interval:  ?- make_center_width(3.5, 0.15, X).
%% X = interval(3.35, 3.65).

center(X, C) :-
    lower_bound(X, L),
    upper_bound(X, U),
    C is (L + U) / 2.

width(X, W) :-
    lower_bound(X, L),
    upper_bound(X, U),
    W is (U - L) / 2.

make_center_percent(C, P, X) :-
    L is C * (1 - P / 100),
    U is C * (1 + P / 100),
    make_interval(L, U, X).

percent(X, P) :-
    width(X, W),
    center(X, C),
    P is (W / C) * 100.

%% interval:  ?- Resistance1 = 6.8, Resistance2 = 4.7, Percent1 = 10, Percent2 = 5, make_center_percent(Resistance1, Percent1, R1), make_center_percent(Resistance2, Percent2, R2), center(R1, C1), center(R2, C2), percent(R1, P1), percent(R2, P2).
%% Resistance1 = 6.8,
%% Resistance2 = C2, C2 = 4.7,
%% Percent1 = 10,
%% Percent2 = 5,
%% R1 = interval(6.12, 7.48),
%% R2 = interval(4.465, 4.9350000000000005),
%% C1 = 6.800000000000001,
%% P1 = 10.000000000000002,
%% P2 = 5.000000000000006.

%% interval:  ?- Resistance1 = 6.8, Resistance2 = 4.7, Percent1 = 10, Percent2 = 5, make_center_percent(Resistance1, Percent1, R1), make_center_percent(Resistance2, Percent2, R2), reciprocal(R1, R1a), reciprocal(R2, R2a), add_interval(R1a, R2a, R3), reciprocal(R3, R3a).
%% Resistance1 = 6.8,
%% Resistance2 = 4.7,
%% Percent1 = 10,
%% Percent2 = 5,
%% R1 = interval(6.12, 7.48),
%% R2 = interval(4.465, 4.9350000000000005),
%% R1a = interval(0.1336898395721925, 0.16339869281045752),
%% R2a = interval(0.20263424518743667, 0.22396416573348266),
%% R3 = interval(0.33632408475962916, 0.38736285854394015),
%% R3a = interval(2.581558809636278, 2.97332259363673).

parallel1(R1, R2, Rp) :-
    mul_interval(R1, R2, R3),
    add_interval(R1, R2, R4),
    div_interval(R3, R4, Rp).

parallel2(R1, R2, Rp) :-
    reciprocal(R1, R1a),
    reciprocal(R2, R2a),
    add_interval(R1a, R2a, R3),
    reciprocal(R3, Rp).

%% interval:  ?- make_center_percent(6.8, 10, R1), make_center_percent(4.7, 5, R2), parallel1(R1, R2, Rp).
%% R1 = interval(6.12, 7.48),
%% R2 = interval(4.465, 4.9350000000000005),
%% Rp = interval(2.201031010873943, 3.4873689182805863).

%% interval:  ?- make_center_percent(6.8, 10, R1), make_center_percent(4.7, 5, R2), parallel2(R1, R2, Rp).
%% R1 = interval(6.12, 7.48),
%% R2 = interval(4.465, 4.9350000000000005),
%% Rp = interval(2.581558809636278, 2.97332259363673).

