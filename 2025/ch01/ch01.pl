#!/usr/bin/swipl
%%  -*- Mode: Prolog -*-
%   Name:               ch01.pl
%
%   Started:            Sun Oct 19 00:00:31 2025
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

:- module(ch01, []).

square(X, Y) :- Y is X * X.

sum_of_squares(X, Y, S) :-
    square(X, X1),
    square(Y, Y1),
    S is X1 + Y1.

sum_square_max(A, B, C, S) :-
    A < B,
    A < C,
    !,
    sum_of_squares(B, C, S).
sum_square_max(A, B, C, S) :-
    A >= B,
    B < C,
    !,
    sum_of_squares(A, C, S).
sum_square_max(A, B, _, S) :-
    sum_of_squares(A, B, S).

%% ?- sum_square_max(2, 4, 1, S).
%% S = 20.

%% ?- sum_square_max(2, 4, 2, S).
%% S = 20.

%% ?- sum_square_max(2, 4, 3, S).
%% S = 25.

%% ?- sum_square_max(2, 4, 4, S).
%% S = 32.

%% ?- sum_square_max(2, 4, 5, S).
%% S = 41.

%% ?- sum_square_max(4, 2, 1, S).
%% S = 20.

%% ?- sum_square_max(4, 2, 2, S).
%% S = 20.

%% ?- sum_square_max(4, 2, 3, S).
%% S = 25.

%% ?- sum_square_max(4, 2, 4, S).
%% S = 32.

%% ?- sum_square_max(4, 2, 5, S).
%% S = 41.

%% ?- sum_square_max(3, 3, 1, S).
%% S = 18.

%% ?- sum_square_max(3, 3, 3, S).
%% S = 18.

%% ?- sum_square_max(3, 3, 5, S).
%% S = 34.

discard_min([], []) :- !.
discard_min([X|Xs], Ys) :-
    discard_min(X, Xs, Ys, []).
discard_min(_, [], Ys, Ys) :- !.
discard_min(Target, [X|Xs], Ys, Acc) :-
    X < Target,
    !,
    discard_min(X, Xs, Ys, [Target|Acc]).
discard_min(Target, [X|Xs], Ys, Acc) :-
    discard_min(Target, Xs, Ys, [X|Acc]).

discard_extreme([], _, []) :- !.
discard_extreme([X|Xs], P, Ys) :-
    discard_extreme(X, Xs, P, Ys, []).
discard_extreme(_, [], _, Ys, Ys) :- !.
discard_extreme(Target, [X|Xs], P, Ys, Acc) :-
    call(P, X, Target),
    !,
    discard_extreme(X, Xs, P, Ys, [Target|Acc]).
discard_extreme(Target, [X|Xs], P, Ys, Acc) :-
    discard_extreme(Target, Xs, P, Ys, [X|Acc]).

%% ch01:  ?- discard_extreme([4, 2, 3, 1, 8, 9, 0], [A, B] >> (A < B), Ys).
%% Ys = [1, 9, 8, 2, 3, 4].

%% ch01:  ?- discard_extreme([4, 2, 3, 1, 8, 9, 0], [A, B] >> (A > B), Ys).
%% Ys = [0, 8, 4, 1, 3, 2].

%%%
%%%    Bubblesort
%%%
sum_square_max1(A, B, C, S) :-
    B < A,
    !,
    sum_square_max1(B, A, C, S).
sum_square_max1(A, B, C, S) :-
    C < B,
    !,
    sum_square_max1(A, C, B, S).
sum_square_max1(_, B, C, S) :-
    sum_of_squares(B, C, S).

%% ?- sum_square_max1(2, 4, 1, S).
%% S = 20.

%% ?- sum_square_max1(2, 4, 2, S).
%% S = 20.

%% ?- sum_square_max1(2, 4, 3, S).
%% S = 25.

%% ?- sum_square_max1(2, 4, 4, S).
%% S = 32.

%% ?- sum_square_max1(2, 4, 5, S).
%% S = 41.

%% ?- sum_square_max1(4, 2, 1, S).
%% S = 20.

%% ?- sum_square_max1(4, 2, 2, S).
%% S = 20.

%% ?- sum_square_max1(4, 2, 3, S).
%% S = 25.

%% ?- sum_square_max1(4, 2, 4, S).
%% S = 32.

%% ?- sum_square_max1(4, 2, 5, S).
%% S = 41.

%% ?- sum_square_max1(3, 3, 1, S).
%% S = 18.

%% ?- sum_square_max1(3, 3, 3, S).
%% S = 18.

%% ?- sum_square_max1(3, 3, 5, S).
%% S = 34.

%%%
%%%    Bill the Lizard's blog
%%%    


median_king(A, B, C, M) :-
    MaxAB is max(A, B),
    MinAB is min(A, B),
    MaxMinABC is max(MinAB, C),
    M is min(MaxAB, MaxMinABC).

%% ?- median_king(2, 4, 1, M).
%% M = 2.

%% ?- median_king(2, 4, 2, M).
%% M = 2.

%% ?- median_king(2, 4, 3, M).
%% M = 3.

%% ?- median_king(2, 4, 4, M).
%% M = 4.

%% ?- median_king(2, 4, 5, M).
%% M = 4.

%% ?- median_king(4, 2, 1, M).
%% M = 2.

%% ?- median_king(4, 2, 2, M).
%% M = 2.

%% ?- median_king(4, 2, 3, M).
%% M = 3.

%% ?- median_king(4, 2, 4, M).
%% M = 4.

%% ?- median_king(4, 2, 5, M).
%% M = 4.

%% ?- median_king(3, 3, 1, M).
%% M = 3.

%% ?- median_king(3, 3, 3, M).
%% M = 3.

%% ?- median_king(3, 3, 5, M).
%% M = 3.

median_king1(A, B, C, M) :-
    M is min(max(A, B), max(min(A, B), C)).

%% ch01:  ?- median_king1(2, 4, 1, 2).
%% true.

%% ch01:  ?- median_king1(2, 4, 2, 2).
%% true.

%% ch01:  ?- median_king1(2, 4, 3, 3).
%% true.

%% ch01:  ?- median_king1(2, 4, 4, 4).
%% true.

%% ch01:  ?- median_king1(2, 4, 5, 4).
%% true.

%% ch01:  ?- median_king1(4, 2, 1, 2).
%% true.

%% ch01:  ?- median_king1(4, 2, 2, 2).
%% true.

%% ch01:  ?- median_king1(4, 2, 3, 3).
%% true.

%% ch01:  ?- median_king1(4, 2, 4, 4).
%% true.

%% ch01:  ?- median_king1(4, 2, 5, 4).
%% true.

%% ch01:  ?- median_king1(3, 3, 1, 3).
%% true.

%% ch01:  ?- median_king1(3, 3, 3, 3).
%% true.

%% ch01:  ?- median_king1(3, 3, 5, 3).
%% true.

%% ch01:  ?- median_king1(3, 3, 5, 5).
%% false.

median_bubble(A, B, C, M) :-
    B < A,
    !,
    median_bubble(B, A, C, M).
median_bubble(A, B, C, M) :-
    C < B,
    !,
    median_bubble(A, C, B, M).
median_bubble(_, B, _, B).

%% ?- median_bubble(2, 4, 1, M).
%% M = 2.

%% ?- median_bubble(2, 4, 2, M).
%% M = 2.

%% ?- median_bubble(2, 4, 3, M).
%% M = 3.

%% ?- median_bubble(2, 4, 4, M).
%% M = 4.

%% ?- median_bubble(2, 4, 5, M).
%% M = 4.

%% ?- median_bubble(4, 2, 1, M).
%% M = 2.

%% ?- median_bubble(4, 2, 2, M).
%% M = 2.

%% ?- median_bubble(4, 2, 3, M).
%% M = 3.

%% ?- median_bubble(4, 2, 4, M).
%% M = 4.

%% ?- median_bubble(4, 2, 5, M).
%% M = 4.

%% ?- median_bubble(3, 3, 1, M).
%% M = 3.

%% ?- median_bubble(3, 3, 3, M).
%% M = 3.

%% ?- median_bubble(3, 3, 5, M).
%% M = 3.
    
%%%
%%%    1.6
%%%
average(X, Y, M) :-
    M is (X + Y) / 2.

improve(Guess, X, G1) :-
    Y is X / Guess,
    average(Guess, Y, G1).

is_good_enough(Guess, X) :-
    square(Guess, G2),
    abs(G2 - X) < 0.001.

%% ?- improve(1, 2, G), improve(G, 2, G1), improve(G1, 2, G2), is_good_enough(G2, 2).
%% G = 1.5,
%% G1 = 1.4166666666666665,
%% G2 = 1.4142156862745097.

sqrt(X, Y) :-
    sqrt(1.0, X, Y).
sqrt(Guess, X, Guess) :-
    is_good_enough(Guess, X), !.
sqrt(Guess, X, Y) :-
    improve(Guess, X, G1),
    sqrt(G1, X, Y).

%%%
%%%    1.7
%%%
is_good_enough_rel(Guess, X) :-
    square(Guess, G2),
    abs((G2 - X) / X) < 0.001.

sqrt_rel(X, Y) :-
    sqrt_rel(1.0, X, Y).
sqrt_rel(Guess, X, Guess) :-
    is_good_enough_rel(Guess, X), !.
sqrt_rel(Guess, X, Y) :-
    improve(Guess, X, G1),
    sqrt_rel(G1, X, Y).

%%%
%%%    1.8
%%%
cube(X, Y) :- Y is X * X * X.

improve_cbrt(Guess, X, G1) :-
    square(Guess, G2),
    G1 is (2 * Guess + X / G2) / 3.

is_good_enough_cbrt(Guess, X) :-
    cube(Guess, G3),
    abs((G3 - X) / X) < 0.001.

cbrt(X, Y) :-
    cbrt(1.0, X, Y).
cbrt(Guess, X, Guess) :-
    is_good_enough_cbrt(Guess, X), !.
cbrt(Guess, X, Y) :-
    improve_cbrt(Guess, X, G1),
    cbrt(G1, X, Y).


factorial(N, F) :-
    (N = 0, !, F = 1);
    (N1 is N - 1, factorial(N1, F1), F is N * F1).

stacktorial(N, F) :-
    stacktorial_push([], N, F).
stacktorial_push(Stack, 0, F) :-
    !,
    stacktorial_pop(Stack, 1, F).
stacktorial_push(Stack, I, F) :-
    I1 is I - 1,
    stacktorial_push([I|Stack], I1, F).
stacktorial_pop([], F, F) :- !.
stacktorial_pop([I|Stack], Result, F) :-
    Result1 is I * Result,
    stacktorial_pop(Stack, Result1, F).

%% ch01:  ?- stacktorial(0, F).
%% F = 1.

%% ch01:  ?- stacktorial(1, F).
%% F = 1.

%% ch01:  ?- stacktorial(2, F).
%% F = 2.

%% ch01:  ?- stacktorial(3, F).
%% F = 6.

%% ch01:  ?- stacktorial(6, F).
%% F = 720.

%% ch01:  ?- stacktorial(10, F).
%% F = 3628800.

stackbonacci(N, F) :-
    stackbonacci([N], F, 0).
stackbonacci([], F, F) :- !.
stackbonacci([0|Stack], F, Acc) :-
    !,
    stackbonacci(Stack, F, Acc).
stackbonacci([1|Stack], F, Acc) :-
    !,
    Acc1 is Acc + 1,
    stackbonacci(Stack, F, Acc1).
stackbonacci([N|Stack], F, Acc) :-
    N1 is N - 1,
    N2 is N - 2,
    stackbonacci([N1,N2|Stack], F, Acc).

%% ch01:  ?- stackbonacci(0, F).
%% F = 0

%% ch01:  ?- stackbonacci(1, F).
%% F = 1 

%% ch01:  ?- stackbonacci(2, F).
%% F = 1 

%% ch01:  ?- stackbonacci(3, F).
%% F = 2 

%% ch01:  ?- stackbonacci(5, F).
%% F = 5 

%% ch01:  ?- stackbonacci(30, F).
%% F = 832040 

%%%
%%%    1.9
%%%
inc(X, Y) :- Y is X + 1.
dec(X, Y) :- Y is X - 1.
%add(A, B, B) :- !, A = 0.
add(0, B, C) :- !, B = C.
add(A, B, C) :-
    dec(A, A1),
    add(A1, B, C1),
    inc(C1, C).
%add_(A, B, B) :- !, A = 0.
add_(0, B, C) :- !, B = C.
add_(A, B, C) :-
    dec(A, A1),
    inc(B, B1),
    add_(A1, B1, C).

%%%
%%%    1.10
%%%
a(_, 0, 0) :- !.
a(0, Y, A) :- !, A is 2 * Y.
a(_, 1, 2) :- !.
a(X, Y, A) :-
    X1 is X - 1,
    Y1 is Y - 1,
    a(X, Y1, A1),
    a(X1, A1, A).
f(N, F) :- a(0, N, F).
g(N, G) :- a(1, N, G).
h(N, H) :- a(2, N, H).

%%%
%%%    1.11
%%%
fibonacci(N, F) :-
    fibonacci(N, 0, 1, 0, F).
fibonacci(N, F, _, N, F) :- !.
fibonacci(N, Current, Next, I, F) :-
    Next1 is Current + Next,
    I1 is I + 1,
    fibonacci(N, Next, Next1, I1, F).

%% sicponacci(0, 0).
%% sicponacci(1, 1).
%% sicponacci(2, 2).
%% sicponacci(N, S) :-
%%     N > 2,
%%     N1 is N - 1,
%%     N2 is N - 2,
%%     N3 is N - 3,
%%     sicponacci(N1, S1),
%%     sicponacci(N2, S2),
%%     sicponacci(N3, S3),
%%     S is S1 + (2 * S2) + (3 * S3).

sicponacci(0, 0) :- !.
sicponacci(1, 1) :- !.
sicponacci(2, 2) :- !.
sicponacci(N, S) :-
    N1 is N - 1,
    N2 is N - 2,
    N3 is N - 3,
    sicponacci(N1, S1),
    sicponacci(N2, S2),
    sicponacci(N3, S3),
    S is S1 + (2 * S2) + (3 * S3).

%% ?- sicponacci(30, S).
%% ERROR: Stack limit (1.0Gb) exceeded

sicponacci_iter(N, S) :-
    sicponacci_iter(N, 0, 1, 2, 0, S).
sicponacci_iter(N, S, _, _, N, S) :- !.
sicponacci_iter(N, Current, Next, Subsequent, I, S) :-
    Subsequent1 is Subsequent + (2 * Next) + (3 * Current),
    I1 is I + 1,
    sicponacci_iter(N, Next, Subsequent, Subsequent1, I1, S).

%%%
%%%    1.15
%%%
sufficiently_small(Theta) :-
    abs(Theta) =< 0.1.
sine_bad(Theta, Theta) :-
    sufficiently_small(Theta),
    !.
sine_bad(Theta, Sin) :-
    T3 is (Theta / 3.0),
    sine_bad(T3, S), % This eliminates the problem in the SICP exercise!
    cube(S, C),
    Sin is (3 * S) - (4 * C).

%%%
%%%    Emacs formatting problem?!
%%%
%% sine_bad(Theta, Sin) :-
%%     T3 is Theta / 3,
%%     sine_bad(T3, S), % This eliminates the problem in the SICP exercise!
%%     cube(S, C),
%%     Sin is (3 * S) - (4 * C).

%% sine_bad(Theta, Sin) :-
%%     T3 is Theta / 3.0, % `.' interpreted as end of rule?!?
%%                     sine_bad(T3, S), % This eliminates the problem in the SICP exercise!
%%     cube(S, C),
%%     Sin is (3 * S) - (4 * C).


reduce_sine(X, Y) :-
    cube(X, C),
    Y is (3 * X) - (4 * C).
sine(Theta, Theta) :-
    sufficiently_small(Theta),
    !.
sine(Theta, Sin) :-
    T3 is (Theta / 3.0),
    sine(T3, S),
    reduce_sine(S, Sin).

%%%
%%%    1.16
%%%
multiply(X, Y, Z) :- Z is X * Y.

slow_expt(_, 0, 1) :- !.
slow_expt(B, N, P) :-
    N1 is N - 1,
    slow_expt(B, N1, P1),
    multiply(B, P1, P).

slow_expt_iter(B, N, P) :-
    slow_expt_iter(B, N, 1, P).
slow_expt_iter(_, 0, P, P) :- !.
slow_expt_iter(B, Counter, Product, P) :-
    C1 is Counter - 1,
    multiply(B, Product, P1),
    slow_expt_iter(B, C1, P1, P).

square_(X, Y) :- multiply(X, X, Y).
fast_expt(_, 0, 1) :- !.
fast_expt(B, N, P) :-
    N mod 2 =:= 0,
    !,
    N1 is N div 2,
    fast_expt(B, N1, P1),
    square_(P1, P).
fast_expt(B, N, P) :-
    N1 is N - 1,
    fast_expt(B, N1, P1),
    multiply(B, P1, P).

fast_expt_iter(X, N, P) :-
    fast_expt_iter(1, X, N, P).
fast_expt_iter(A, _, 0, A) :- !.
fast_expt_iter(A, B, N, P) :-
    N mod 2 =:= 0,
    !,
    square_(B, B1),
    N1 is N div 2,
    fast_expt_iter(A, B1, N1, P).
fast_expt_iter(A, B, N, P) :-
    multiply(A, B, A1),
    N1 is N - 1,
    fast_expt_iter(A1, B, N1, P).

%%%
%%%    1.17
%%%
add__(X, Y, Z) :- Z is X + Y.

slow_times(_, 0, 0) :- !.
slow_times(A, B, P) :-
    B1 is B - 1,
    slow_times(A, B1, P1),
    add__(A, P1, P).

slow_times_iter(A, B, P) :-
    slow_times_iter(A, B, 0, P).
slow_times_iter(_, 0, P, P) :- !.
slow_times_iter(A, Counter, Sum, P) :-
    C1 is Counter - 1,
    add__(A, Sum, S1),
    slow_times_iter(A, C1, S1, P).

halve(X, Y) :- Y is X >> 1.
double(X, Y) :- Y is X << 1.

fast_times(_, 0, 0) :- !.
fast_times(A, B, P) :-
    B mod 2 =:= 0,
    !,
    halve(B, B1),
    fast_times(A, B1, P1),
    double(P1, P).
fast_times(A, B, P) :-
    B1 is B - 1,
    fast_times(A, B1, P1),
    add(A, P1, P).

%%%
%%%    1.18
%%%    
fast_times_iter(X, Y, P) :-
    fast_times_iter(0, X, Y, P).
fast_times_iter(S, _, 0, S) :- !.
fast_times_iter(S, A, B, P) :-
    B mod 2 =:= 0,
    !,
    double(A, A1),
    halve(B, B1),
    fast_times_iter(S, A1, B1, P).
fast_times_iter(S, A, B, P) :-
    B1 is B - 1,
    S1 is S + A,
    fast_times_iter(S1, A, B1, P).

%%%
%%%    1.19
%%%
fast_fib_iter(N, F) :-
    fast_fib_iter(1, 0, 0, 1, N, F).
fast_fib_iter(_, F, _, _, 0, F) :- !.
fast_fib_iter(A, B, P, Q, C, F) :-
    C mod 2 =:= 0,
    !,
    P1 is P*P + Q*Q,
    Q1 is Q*Q + 2*P*Q,
    C1 is C div 2,
    fast_fib_iter(A, B, P1, Q1, C1, F).
fast_fib_iter(A, B, P, Q, C, F) :-
    A1 is B*Q + A*Q + A*P,
    B1 is B*P + A*Q,
    C1 is C - 1,
    fast_fib_iter(A1, B1, P, Q, C1, F).

%%%
%%%    H.O. Procedures
%%%
sum_integers(A, B, 0) :- A > B, !.
sum_integers(A, B, S) :-
    A1 is A + 1,
    sum_integers(A1, B, S1),
    S is A + S1.

%% ?- sum_integers(1, 10, S).
%% S = 55.

%% ?- sum_integers(1, 20, S1), sum_integers(1, 9, S2), sum_integers(10, 20, S3), S3 is S1 - S2.
%% S1 = 210,
%% S2 = 45,
%% S3 = 165.

sum_integers1(A, B, S) :-
    sum_integers1(A, B, 0, S).
sum_integers1(A, B, S, S) :- A > B, !.
sum_integers1(A, B, Acc, S) :-
    A1 is A + 1,
    Acc1 is Acc + A,
    sum_integers1(A1, B, Acc1, S).

sum_cubes(A, B, 0) :- A > B, !.
sum_cubes(A, B, S) :-
    A1 is A + 1,
    sum_cubes(A1, B, S1),
    cube(A, C),
    S is C + S1.

%% ?- sum_cubes(1, 3, S).
%% S = 36.

%% ?- sum_cubes(1, 10, S).
%% S = 3025.

%% ?- sum_cubes(1, 100, S).
%% S = 25502500.

%% ?- sum_cubes(8, 15, S).
%% S = 13616.

sum_cubes1(A, B, S) :-
    sum_cubes1(A, B, 0, S).
sum_cubes1(A, B, S, S) :- A > B, !.
sum_cubes1(A, B, Acc, S) :-
    A1 is A + 1,
    cube(A, C),
    Acc1 is Acc + C,
    sum_cubes1(A1, B, Acc1, S).
    
pi_sum(A, B, 0) :- A > B, !.
pi_sum(A, B, S) :-
    A4 is A + 4,
    pi_sum(A4, B, S1),
    X is (1.0 / (A * (A + 2))),
    S is X + S1.

pi_sum1(A, B, S) :-
    pi_sum1(A, B, 0, S).
pi_sum1(A, B, S, S) :- A > B, !.
pi_sum1(A, B, Acc, S) :-
    A4 is A + 4,
    Acc1 is Acc + (1.0 / (A * (A + 2))),
    pi_sum1(A4, B, Acc1, S).

%% ch01:  ?- pi_sum1(1, 12, P), Pi is P * 8.
%% P = 0.372005772005772,
%% Pi = 2.976046176046176.

%% ch01:  ?- pi_sum1(1, 100, P), Pi is P * 8.
%% P = 0.39019933157387615,
%% Pi = 3.121594652591009.

%% ch01:  ?- pi_sum1(1, 1000, P), Pi is P * 8.
%% P = 0.39244908194872274,
%% Pi = 3.139592655589782.

%% ch01:  ?- pi_sum1(1, 10000, P), Pi is P * 8.
%% P = 0.3926740816989736,
%% Pi = 3.141392653591789.

sum(_, _, A, B, 0) :- A > B, !.
sum(Term, Next, A, B, S) :-
    call(Next, A, A1),
    call(Term, A, Y),
    sum(Term, Next, A1, B, S1),
    S is Y + S1.

sum_tr(Term, Next, A, B, S) :-
    sum_tr(Term, Next, A, B, 0, S).
sum_tr(_, _, A, B, S, S) :- A > B, !.
sum_tr(Term, Next, A, B, Acc, S) :-
    call(Next, A, A1),
    call(Term, A, Y),
    Acc1 is Acc + Y,
    sum_tr(Term, Next, A1, B, Acc1, S).

identity(X, X).

sum_integers_ho1(A, B, S) :-
    sum(identity, inc, A, B, S).
           
sum_integers_ho2(A, B, S) :-
%    sum_tr([X, Y] >> (X = Y), A, [X, Y] >> (Y is X + 1), B, S).
    sum_tr(=, [X, Y] >> (Y is X + 1), A, B, S).

sum_cubes_ho1(A, B, S) :-
    sum(cube, inc, A, B, S).

sum_cubes_ho2(A, B, S) :-
    sum_tr([X, Y] >> (Y is X * X * X), [X, Y] >> (Y is X + 1), A, B, S).

pi_sum_ho1(A, B, S) :-
    sum([X, Y] >> (Y is 1.0 / (X * (X + 2))), [X, Y] >> (Y is X + 4), A, B, S).

pi_sum_ho2(A, B, S) :-
    sum_tr([X, Y] >> (Y is 1.0 / (X * (X + 2))), [X, Y] >> (Y is X + 4), A, B, S).

%%%
%%%    No stack overflow?!
%%%
%% ?- pi_sum_ho1(1, 10000000, P), Pi is P * 8.
%% P = 0.3926990566987241,
%% Pi = 3.141592453589793.

integral(F, A, B, Dx, S) :-
    A0 is (A + Dx / 2.0),
    sum(F, {Dx}/[A, A1] >> (A1 is A + Dx), A0, B, S1),
%    sum(F, A0, [A1, A2] >> (A2 is A1 + Dx), B, S1),
    S is S1 * Dx.

%%%
%%%    1.29
%%%
%% simpsons(F, A, B, N, S) :-
%%     H is (B - A) / N,
%%     call(F, A, Y),
%%     sum_elements(F, A, B, H, 1, N, Y, Sum),
%%     S is H * Sum / 3.
%% sum_elements(F, _, B, _, N, N, Acc, S) :-
%%     !,
%%     call(F, B, Y),
%%     S is Y + Acc.
%% sum_elements(F, A, B, H, K, N, Acc, S) :-
%%     K mod 2 =:= 0,
%%     !,
%%     x(A, K, H, X),
%%     call(F, X, Y),
%%     S1 is 2 * Y,
%%     K1 is K + 1,
%%     Acc1 is Acc + S1,
%%     sum_elements(F, A, B, H, K1, N, Acc1, S).
%% sum_elements(F, A, B, H, K, N, Acc, S) :-
%%     x(A, K, H, X),
%%     call(F, X, Y),
%%     S1 is 4 * Y,
%%     K1 is K + 1,
%%     Acc1 is Acc + S1,
%%     sum_elements(F, A, B, H, K1, N, Acc1, S).
simpsons(F, A, B, N, S) :-
    H is (B - A) / N,
    call(F, A, Y),
    sum_elements(F, A, B, H, N, Y, Sum),
    S is H * Sum / 3.
sum_elements(F, A, B, H, N, Acc, S) :-
    odd(F, A, B, H, 1, N, Acc, S).
even(F, _, B, _, N, N, Acc, S) :-
    !,
    call(F, B, Y),
    S is Y + Acc.
even(F, A, B, H, K, N, Acc, S) :-
    x(A, K, H, X),
    call(F, X, Y),
    S1 is 2 * Y,
    K1 is K + 1,
    Acc1 is Acc + S1,
    odd(F, A, B, H, K1, N, Acc1, S).
odd(F, A, B, H, K, N, Acc, S) :-
    x(A, K, H, X),
    call(F, X, Y),
    S1 is 4 * Y,
    K1 is K + 1,
    Acc1 is Acc + S1,
    even(F, A, B, H, K1, N, Acc1, S).

x(A, K, H, X) :-
    X is A + H * K.

%% ch01:  ?- simpsons(cos, 0, pi, 10, S).
%% ?- simpsons([X, Y] >> (Y is cos(X)), 0, pi, 10, S).
%% S = 4.6504913306781755e-17.

%% ?- P is pi/2, simpsons([X, Y] >> (Y is cos(X)), 0, P, 10, S).
%% P = 1.5707963267948966,
%% S = 1.0000033922209006.

%% ch01:  ?- simpsons(identity, 0, 1, 10, S).
%% ch01:  ?- simpsons(=, 0, 1, 10, S).
%% ?- simpsons([X, Y] >> (Y is X), 0, 1, 10, S).
%% S = 1/2.

%% ?- simpsons([X, Y] >> (Y is 2 * X + 3), 0, 1, 10, S).
%% S = 4.

simpsons2(F, A, B, N, S) :-
    H is (B - A) / N,
    sum_elements2(F, A, B, H, N, Sum),
    S is H * Sum / 3.
sum_elements2(F, A, B, H, N, S) :-
    N1 is N - 1,
    call(F, A, Y0),
    sum_tr({F, A, H}/[K, Y] >> (element(F, A, H, K, Y)), inc, 1, N1, Sum),
    call(F, B, YN),
    S is Y0 + Sum + YN.

element(F, A, H, K, Y) :-
    K mod 2 =:= 0,
    !,
    x(A, K, H, X),
    call(F, X, Y0),
    Y is Y0 * 2.
element(F, A, H, K, Y) :-
    x(A, K, H, X),
    call(F, X, Y0),
    Y is Y0 * 4.
    
%% ?- simpsons2([X, Y] >> (Y is cos(X)), 0, pi, 10, S).
%% S = 2.3252456653390877e-16.

%% ?- P is pi/2, simpsons2([X, Y] >> (Y is cos(X)), 0, P, 10, S).
%% P = 1.5707963267948966,
%% S = 1.0000033922209006.

%% ?- simpsons2([X, Y] >> (Y is X), 0, 1, 10, S).
%% S = 1/2.

%% ?- simpsons2([X, Y] >> (Y is 2 * X + 3), 0, 1, 10, S).
%% S = 4.

simpsons3(F, A, B, N, S) :-
    H is (B - A) / N,
    sum_elements3(F, {H, A}/[K, X] >> (X is A + H * K), A, B, N, Sum),
    S is H * Sum / 3.
sum_elements3(F, P, A, B, N, S) :-
    N1 is N - 1,
    call(F, A, Y0),
    sum_tr({F, P}/[K, Y] >> (element3(F, P, K, Y)), inc, 1, N1, Sum),
    call(F, B, YN),
    S is Y0 + Sum + YN.

element3(F, P, K, Y) :-
    K mod 2 =:= 0,
    !,
    call(P, K, X),
    call(F, X, Y0),
    Y is Y0 * 2.
element3(F, P, K, Y) :-
    call(P, K, X),
    call(F, X, Y0),
    Y is Y0 * 4.


%%%
%%%    1.31
%%%
product(_, _, A, B, 1) :- A > B, !.
product(Term, Next, A, B, P) :-
    call(Term, A, Y),
    call(Next, A, A1),
    product(Term, Next, A1, B, P1),
    P is Y * P1.

factorial_product(N, F) :-
%    product([X, Y] >> (X = Y), 1, [X, Y] >> (Y is X + 1), N, F).
    product(identity, inc, 1, N, F).

product_tr(Term, Next, A, B, P) :-
    product_tr(Term, Next, A, B, 1, P).
product_tr(_, _, A, B, P, P) :- A > B, !.
product_tr(Term, Next, A, B, Acc, P) :-
    call(Next, A, A1),
    call(Term, A, Y),
    Acc1 is Acc * Y,
    product_tr(Term, Next, A1, B, Acc1, P).

factorial_product_tr(N, F) :-
%    product_tr([X, Y] >> (X = Y), 1, [X, Y] >> (Y is X + 1), N, F).
    product_tr(identity, inc, 1, N, F).

product_pi(A, B, P) :-
%    product([I, Y] >> (Y is (2.0 * ((I div 2) + 1)) / (2.0 * ((I + 1) div 2) + 1.0)), A, [X, Y] >> (Y is X + 1), B, P).
    product([I, Y] >> (Y is (2.0 * ((I div 2) + 1)) / (2.0 * ((I + 1) div 2) + 1.0)), inc, A, B, P).

%% ?- product_pi(1, 10, P), Pi is P * 4.
%% P = 0.8187752603337017,
%% Pi = 3.275101041334807.

%% ?- product_pi(1, 100, P), Pi is P * 4.
%% P = 0.7892575441137911,
%% Pi = 3.1570301764551645.

%% ?- product_pi(1, 1000, P), Pi is P * 4.
%% P = 0.7857901763830643,
%% Pi = 3.143160705532257.

%% ?- product_pi(1, 10000, P), Pi is P * 4.
%% P = 0.7854374264344909,
%% Pi = 3.1417497057379635.

product_pi_tr(A, B, P) :-
    product_tr([I, Y] >> (Y is (2.0 * ((I div 2) + 1)) / (2.0 * ((I + 1) div 2) + 1.0)), [X, Y] >> (Y is X + 1), A, B, P).

%% ?- product_pi_tr(1, 10, P), Pi is P * 4.
%% P = 0.8187752603337016,
%% Pi = 3.2751010413348065.

%% ?- product_pi_tr(1, 100, P), Pi is P * 4.
%% P = 0.7892575441137913,
%% Pi = 3.1570301764551654.

%% ?- product_pi_tr(1, 1000, P), Pi is P * 4.
%% P = 0.7857901763830638,
%% Pi = 3.1431607055322552.

%% ?- product_pi_tr(1, 10000, P), Pi is P * 4.
%% P = 0.7854374264345021,
%% Pi = 3.1417497057380084.

%% ?- product_pi_tr(1, 100000, P), Pi is P * 4.
%% P = 0.7854020903194853,
%% Pi = 3.141608361277941.

%% ?- product_pi_tr(1, 1000000, P), Pi is P * 4.
%% P = 0.7853985560957135,
%% Pi = 3.141594224382854.

%%%
%%%    1.32
%%%
accumulate(_, Null, _, _, A, B, Null) :- A > B, !.
accumulate(Combiner, Null, Term, Next, A, B, V) :-
    call(Term, A, Y),
    call(Next, A, A1),
    accumulate(Combiner, Null, Term, A1, Next, B, V1),
    call(Combiner, Y, V1, V).

accumulate_sum(Term, Next, A, B, S) :-
    accumulate([X, Y, Z] >> (Z is X + Y), 0, Term, Next, A, B, S).

accumulate_product(Term, Next, A, B, P) :-
    accumulate([X, Y, Z] >> (Z is X * Y), 1, Term, Next, A, B, P).

%% ch01:  ?- accumulate_sum(identity, inc, 1, 10, S).
%% ?- accumulate_sum(identity, [X, Y] >> (Y is X + 1), 1, 10, S).
%% S = 55.

%% ?- accumulate_sum(identity, [X, Y] >> (Y is X + 1), 1, 100, S).
%% S = 5050.

%% ch01:  ?- accumulate_product(identity, inc, 1, 3, S).
%% ?- accumulate_product(identity, [X, Y] >> (Y is X + 1), 1, 3, S).
%% S = 6.

%% ?- accumulate_product(identity, [X, Y] >> (Y is X + 1), 1, 10, S).
%% S = 3628800.

accumulate_tr(Combiner, Null, Term, Next, A, B, V) :-
    accumulate_(Combiner, Term, Next, A, B, Null, V).
accumulate_(_, _, _, A, B, V, V) :- A > B, !.
accumulate_(Combiner, Term, Next, A, B, Acc, V) :-
    call(Next, A, A1),
    call(Term, A, Y),
    call(Combiner, Acc, Y, Acc1),
    accumulate_(Combiner, Term, Next, A1, B, Acc1, V).

accumulate_sum_tr(Term, Next, A, B, S) :-
    accumulate_tr([X, Y, Z] >> (Z is X + Y), 0, Term, Next, A, B, S).

accumulate_product_tr(Term, Next, A, B, P) :-
    accumulate_tr([X, Y, Z] >> (Z is X * Y), 1, Term, Next, A, B, P).

accumulate_sum_integers(A, B, S) :-
%    accumulate_sum(identity, [X, Y] >> (Y is X + 1), A, B, S).
    accumulate_sum(identity, inc, A, B, S).

%%    AKA factorial
accumulate_product_integers(A, B, P) :-
%    accumulate_product(identity, [X, Y] >> (Y is X + 1), A, B, P).
    accumulate_product(identity, inc, A, B, P).

%%%
%%%    1.33
%%%
filtered_accumulate(_, _, Null, _, _, A, B, Null) :- A > B, !.
filtered_accumulate(P, Combiner, Null, Term, Next, A, B, V) :-
    call(P, A),
    !,
    call(Term, A, Y),
    call(Next, A, A1),
    filtered_accumulate(P, Combiner, Null, Term, Next, A1, B, V1),
    call(Combiner, Y, V1, V).
filtered_accumulate(P, Combiner, Null, Term, Next, A, B, V) :-
    call(Next, A, A1),
    filtered_accumulate(P, Combiner, Null, Term, Next, A1, B, V).

filtered_accumulate_factorial(N, P) :-
    filtered_accumulate([_] >> (true), [X, Y, Z] >> (Z is X * Y), 1, identity, [X, Y] >> (Y is X + 1), 1, N, P).
%    filtered_accumulate(true, [X, Y, Z] >> (Z is X * Y), 1, identity, [X, Y] >> (Y is X + 1), 1, N, P).

filtered_accumulate_tr(P, Combiner, Null, Term, Next, A, B, V) :-
    filtered_accumulate_(P, Combiner, Term, Next, A, B, Null, V).
filtered_accumulate_(_, _, _, _, A, B, V, V) :- A > B, !.
filtered_accumulate_(P, Combiner, Term, Next, A, B, Acc, V) :-
    call(P, A),
    !,
    call(Next, A, A1),
    call(Term, A, Y),
    call(Combiner, Acc, Y, Acc1),
    filtered_accumulate_(P, Combiner, Term, Next, A1, B, Acc1, V).
filtered_accumulate_(P, Combiner, Term, Next, A, B, Acc, V) :-
    call(Next, A, A1),
    filtered_accumulate_(P, Combiner, Term, Next, A1, B, Acc, V).

%%%
%%%    This is all for `sum_prime_squares'.
%%%    另见 primes.pl
%%%    
smallest_divisor(N, D) :-
    find_divisor(N, 2, D1),
    !,
    D = D1.

find_divisor(N, T, N) :-
    square(T, T2),
    T2 > N,
    !.
find_divisor(N, T, T) :-
    divides(T, N),
    !.
find_divisor(N, T, D) :-
    T1 is T + 1,
    find_divisor(N, T1, D).

divides(D, N) :-
    N rem D =:= 0.

is_prime(1) :- !, fail.
is_prime(N) :-
    smallest_divisor(N, N).

sum_prime_squares(A, B, S) :-
%    filtered_accumulate([N] >> (is_prime(N)), [X, Y, Z] >> (Z is X + Y), 0, square, [X, Y] >> (Y is X + 1), A, B, S).
    filtered_accumulate(is_prime, [X, Y, Z] >> (Z is X + Y), 0, square, inc, A, B, S).

%% ?- sum_prime_squares(1, 5, S).
%% S = 38.

%% ?- sum_prime_squares(2, 5, S).
%% S = 38.

%% ?- sum_prime_squares(2, 6, S).
%% S = 38.

relative_prime_product(N, P) :-
    N1 is N - 1,
%    filtered_accumulate({N}/[M] >> (gcd(M, N) =:= 1), [X, Y, Z] >> (Z is X * Y), 1, identity, [X, Y] >> (Y is X + 1), 1, N1, P).
    filtered_accumulate({N}/[M] >> (gcd(M, N) =:= 1), [X, Y, Z] >> (Z is X * Y), 1, identity, inc, 1, N1, P).

close_enough_search(X, Y) :- abs(X - Y) < 0.001.
search(_, A, B, V) :-
    close_enough_search(A, B), !,
    average(A, B, V).
search(F, A, B, V) :-
    average(A, B, M),
    call(F, M, Y),
    choose_search(F, A, B, M, Y, V).

choose_search(F, A, _, M, Y, V) :-
    Y > 0,
    !,
    search(F, A, M, V).
choose_search(F, _, B, M, Y, V) :-
    Y < 0,
    !,
    search(F, M, B, V).
choose_search(_, _, _, M, _, M).

half_interval_method(F, A, B, V) :-
    call(F, A, Va),
    call(F, B, Vb),
    choose_half_interval(F, A, B, Va, Vb, V).

choose_half_interval(F, A, B, Va, Vb, V) :-
    Va < 0,
    Vb > 0,
    !,
    search(F, A, B, V).
choose_half_interval(F, A, B, Va, Vb, V) :-
    Vb < 0,
    Va > 0,
    !,
    search(F, B, A, V).

%% ?- half_interval_method(sin, 2.0, 4.0, V).
%% V = 3.14111328125.

%% ?- half_interval_method([X, Y] >> (cube(X, X3), Y is X3 - 2*X - 3), 1.0, 2.0, V).
%% V = 1.89306640625.

tolerance(0.00001).
close_enough_fixed_point(X0, X1) :-
    tolerance(T),
    abs(X0 - X1) < T.
fixed_point(F, Guess, V) :-
    call(F, Guess, Next),
    fixed_point_next(F, Guess, Next, V).
fixed_point_next(_, Guess, Next, Next) :-
    close_enough_fixed_point(Guess, Next), !.
fixed_point_next(F, _, Next, V) :-
    fixed_point(F, Next, V).

sqrt_fp(X, Root) :-
    fixed_point({X}/[Y, Z] >> (R is X / Y, average(Y, R, Z)), 1.0, Root).

%%%
%%%    1.35
%%%
golden_ratio(G) :-
    fixed_point([X, Y] >> (Y is 1 + 1/X), 1.0, G).

%%%
%%%    1.36
%%%
fixed_point_verbose(F, Guess, V) :-
    call(F, Guess, Next),
    write("Guess: "),
    write(Guess),
    write(" Next: "),
    writeln(Next),
    fixed_point_next_verbose(F, Guess, Next, V).
fixed_point_next_verbose(_, Guess, Next, Next) :-
    close_enough_fixed_point(Guess, Next), !.
fixed_point_next_verbose(F, _, Next, V) :-
    fixed_point_verbose(F, Next, V).

xx(Initial, V) :-
    fixed_point_verbose([X, Y] >> (Y is log(1000) / log(X)), Initial, V).

xx_avg(Initial, V) :-
    fixed_point_verbose([X, Z] >> (Y is log(1000) / log(X), average(X, Y, Z)), Initial, V).

%%%
%%%    1.37
%%%    N is procedure to generate ith numerator.
%%%    D is procedure to generate ith denominator.
%%%
cont_frac(N, D, K, V) :-
    cont_frac(N, D, K, 1, V).
cont_frac(_, _, K, I, 0) :- I > K, !.
cont_frac(N, D, K, I, V) :-
    I1 is I + 1,
    cont_frac(N, D, K, I1, V1),
    call(N, I, Num),
    call(D, I, Denom),
    V is Num / (Denom + V1).

cont_frac_iter(N, D, K, V) :-
    cont_frac_iter(N, D, K, 0, V).
cont_frac_iter(_, _, 0, V, V) :- !.
cont_frac_iter(N, D, I, Acc, V) :-
    call(N, I, Num),
    call(D, I, Denom),
    Acc1 is Num / (Denom + Acc),
    I1 is I - 1,
    cont_frac_iter(N, D, I1, Acc1, V).

%% ?- cont_frac([X, Y] >> (Y is 1.0), [X, Y] >> (Y is 1.0), 10000, P), X is 1 / P.
%% X = 1.618033988749895,
%% P = 0.6180339887498948.

%%%
%%%    1.38
%%%
e_denom(I, D) :-
    I mod 3 =:= 2,
    !,
    D is 2 * ceil(I / 3).
e_denom(_, 1).
eminus2(K, E) :-
    cont_frac_iter([_, Y] >> (Y is 1.0), e_denom, K, E).

eminus2_(K, E) :-
    cont_frac_iter([_, Y] >> (Y is 1.0), [I, D] >> ((I mod 3 =:= 2, !, D is 2 * ceil(I / 3)); (D = 1)), K, E).

%% ?- eminus2(20, E).
%% E = 0.7182818284590452.

%%%
%%%    1.39
%%%
%tan_num(1, X, X) :- !.
tan_num(1, X, Y) :- !, X = Y.
tan_num(_, X, N) :-
    N is -(X * X).
tan_cf(X, K, T) :-
    cont_frac_iter({X}/[I, N] >> tan_num(I, X, N), [I, D] >> (D is 2 * I - 1), K, T).
    
%% ?- X is pi / 4, tan_cf(X, 5, T).
%% X = 0.7853981633974483,
%% T = 0.999999986526355.

average_damp(F, {F}/[X, Y] >> (call(F, X, Z), average(X, Z, Y))).
    
sqrt_ad(X, R) :-
    average_damp({X}/[Y, Z] >> (Z is X / Y), Ad),
    fixed_point(Ad, 1.0, R).

cbrt_ad(X, R) :-
    average_damp({X}/[Y, Z] >> (square(Y, Y2), Z is X / Y2), Ad),
    fixed_point(Ad, 1.0, R).


dx(0.00001).
deriv(G, {G}/[X, Y] >> (dx(Dx), X1 is X + Dx, call(G, X1, Y1), call(G, X, Y2), Y is (Y1 - Y2) / Dx)).

newton_transform(G, {G, GP}/[X, Y] >> (call(G, X, X1), call(GP, X, X2), Y is X - (X1/X2))) :-
    deriv(G, GP).

newtons_method(G, Guess, X) :-
    newton_transform(G, H),
    fixed_point(H, Guess, X).

sqrt_newton(X, R) :-
    newtons_method({X}/[Y, Z] >> (square(Y, Y2), Z is Y2 - X), 1.0, R).

fixed_point_of_transform(G, Xform, Guess, FP) :-
    call(Xform, G, H),
    fixed_point(H, Guess, FP).

sqrt_ad_xform(X, R) :-
    fixed_point_of_transform({X}/[Y, Z] >> (Z is X / Y), average_damp, 1.0, R).

sqrt_newton_xform(X, R) :-
    fixed_point_of_transform({X}/[Y, Z] >> (square(Y, Y2), Z is Y2 - X), newton_transform, 1.0, R).

%%%
%%%    1.40
%%%    
cubic(A, B, C, [X, Y] >> (Y is X*X*X + A*X*X + B*X + C)).
%cubic(A, B, C, {A, B, C}/[X, Y] >> (Y is X*X*X + A*X*X + B*X + C)). % Not needed since A, B, C are not variables??

%% ch01:  ?- cubic(-9, 26, -24, F), call(F, 2, Y).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% Y = 0.

%% ch01:  ?- cubic(-9, 26, -24, F), call(F, 3, Y).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% Y = 0.

%% ch01:  ?- cubic(-9, 26, -24, F), call(F, 4, Y).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% Y = 0.

%% ch01:  ?- cubic(-9, 26, -24, F), newtons_method(F, 1, R).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% R = 2.0000000000160725.

%% ch01:  ?- cubic(-9, 26, -24, F), newtons_method(F, 4, R).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% R = 4.0.

%% ch01:  ?- cubic(-9, 26, -24, F), newtons_method(F, 3, R).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% R = 3.0.

%% ch01:  ?- cubic(-9, 26, -24, F), newtons_method(F, 2, R).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% R = 2.0.

%% ch01:  ?- cubic(-9, 26, -24, F), newtons_method(F, 2.5, R).
%% F = {-9, 26, -24}/[_A, _B]>>(_B is _A*_A*_A+ -9*_A*_A+26*_A+ -24),
%% R = 4.000000000000173.

%%%
%%%    1.41
%%%
double_cross(F, [X, Y] >> (call(F, X, Z), call(F, Z, Y))).
%double_cross(F, {F}/[X, Y] >> (call(F, X, Y1), call(F, Y1, Y))). % Don't need this since F is not a variable??

%% ch01:  ?- double_cross(inc, F), call(F, 5, Y).
%% F = [_A, _B]>>(call(inc, _A, _C), call(inc, _C, _B)),
%% Y = 7.

%% ch01:  ?- double_cross(inc, F), double_cross(F, FF), call(FF, 5, Y).
%% F = [_A, _B]>>(call(inc, _A, _C), call(inc, _C, _B)),
%% FF = [_D, _E]>>(call([_A, _B]>>(call(inc, _A, _C), call(inc, _C, _B)), _D, _F), call([_A, _B]>>(call(inc, _A, _C), call(inc, _C, _B)), _F, _E)),
%% Y = 9.

%% ch01:  ?- double_cross(double_cross, F), double_cross(F, FF), call(FF, inc, F16), call(F16, 5, Y).
%% F = [_A, _B]>>(call(double_cross, _A, _C), call(double_cross, _C, _B)),
%% FF = [_D, _E]>>(call([_A, _B]>>(call(double_cross, _A, _C), call(double_cross, _C, _B)), _D, _F), call([_A, _B]>>(call(double_cross, _A, _C), call(double_cross, _C, _B)), _F, _E)),
%% F16 = [_G, _H]>>(call([_I, _J]>>(call([_K, _L]>>(call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _K, _P), call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _P, _L)), _I, _Q), call([_K, _L]>>(call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _K, _P), call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _P, _L)), _Q, _J)), _G, _R), call([_I, _J]>>(call([_K, _L]>>(call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _K, _P), call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _P, _L)), _I, _Q), call([_K, _L]>>(call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _K, _P), call([_M, _N]>>(call(inc, _M, _O), call(inc, _O, _N)), _P, _L)), _Q, _J)), _R, _H)),
%% Y = 21.

%%%
%%%    1.42
%%%
%% compose([], identity).
%% compose([F|Fr], C) :-
%%     foldl([F1, F2, G] >> (G = {F1, F2}/[X, Y] >> (call(F1, X, X1), call(F2, X1, Y))), Fr, F, C).
%ERROR:    No permission to redefine imported_procedure `ugraphs:compose/3'
comp(F, G, {F, G}/[X, Y] >> (call(G, X, Z), call(F, Z, Y))).

%% ch01:  ?- comp(sqrt, inc, F), call(F, 8, Y).
%% F = {sqrt, inc}/[_A, _B]>>(call(inc, _A, _C), call(sqrt, _C, _B)),
%% Y = 3.00009155413138.

%% partial(F, X, {X
%% ch01:  ?- F = [X, Y, Z] >> (Z is X + Y), apply([Y, Z] >> (call(F, 2, Y, Z)), [3, Sum]).
%% F = [X, Y, Z]>>(Z is X+Y),
%% Sum = 5.
    
%%%
%%%    1.43
%%%
repeated(_, 0, identity) :- !.
repeated(F, 1, F) :- !.
repeated(F, N, R) :-
    N1 is N - 1,
    repeated(F, N1, R1),
%    compose([F, R1], R).
    comp(F, R1, R).

%% ch01:  ?- repeated(square, 2, S), call(S, 2, X).
%% S = {square, square}/[_A, _B]>>(call(square, _A, _C), call(square, _C, _B)),
%% X = 16.

%% ch01:  ?- repeated(square, 3, S), call(S, 2, X).
%% S = {{square, square}/[_A, _B]>>(call(square, _A, _C), call(square, _C, _B)), square}/[_D, _E]>>(call({square, square}/[_A, _B]>>(call(square, _A, _C), call(square, _C, _B)), _D, _F), call(square, _F, _E)),
%% X = 256.

%%%
%%%    1.44
%%%
smooth(F, G) :-
    G = {F}/[X, Z] >> (dx(Dx), Xm is X - Dx, Xp is X + Dx, call(F, Xm, Ym), call(F, X, Y), call(F, Xp, Yp), Z is (Ym + Y + Yp) / 3.0).

%% ch01:  ?- smooth(square, G), call(G, 4, X).
%% G = {square}/[_A, _B]>>(dx(_C), _D is _A-_C, _E is _A+_C, call(square, _D, _F), call(square, _A, _G), call(square, _E, _H), _B is (_F+_G+_H)/3.0),
%% X = 16.000000000066663.

smooth_n(F, N, S) :-
    repeated(smooth, N, R),
    call(R, F, S).

%% ch01:  ?- smooth_n(square, 2, S), call(S, 4, Y).
%% S = {{square}/[_A, _B]>>(dx(_C), _D is _A-_C, _E is _A+_C, call(square, _D, _F), call(square, _A, _G), call(square, _E, _H), _B is (_F+_G+_H)/3.0)}/[_I, _J]>>(dx(_K), _L is _I-_K, _M is _I+_K, call({square}/[_A, _B]>>(dx(_C), _D is _A-_C, _E is _A+_C, call(square, _D, _F), call(square, _A, _G), call(square, _E, _H), _B is (_F+_G+_H)/3.0), _L, _N), call({square}/[_A, _B]>>(dx(_C), _D is _A-_C, _E is _A+_C, call(square, _D, _F), call(square, _A, _G), call(square, _E, _H), _B is (_F+_G+_H)/3.0), _I, _O), call({square}/[_A, _B]>>(dx(_C), _D is _A-_C, _E is _A+_C, call(square, _D, _F), call(square, _A, _G), call(square, _E, _H), _B is (_F+_G+_H)/3.0), _M, _P), _J is (_N+_O+_P)/3.0),
%% Y = 16.00000000013333.

%%%
%%%    1.45
%%%
nth_root(N, {N}/[X, R] >> (M is floor(log(N)/log(2)),
                           repeated(average_damp, M, AD),
                           N1 is N - 1, 
                           call(AD, {N1, X}/[Y, Z] >> (Z is X / (Y ** N1)), P),
                           fixed_point(P, 1.0, R))).

%% ch01:  ?- nth_root(3, P).
%% P = {3}/[_A, _B]>>(_C is floor(log(3)/log(2)), repeated(average_damp, _C, _D), call(_D, {3, _A}/[_E, _F]>>(_G is 3-1, _F is _A/_E**_G), _H), fixed_point(_H, 1.0, _B)).

%% ch01:  ?- nth_root(3, P), call(P, 8, R).
%% P = {3}/[_A, _B]>>(_C is floor(log(3)/log(2)), repeated(average_damp, _C, _D), call(_D, {3, _A}/[_E, _F]>>(_G is 3-1, _F is _A/_E**_G), _H), fixed_point(_H, 1.0, _B)),
%% R = 1.9999981824788517.

%% ch01:  ?- nth_root(3, P), call(P, -8, R).
%% P = {3}/[_A, _B]>>(_C is floor(log(3)/log(2)), repeated(average_damp, _C, _D), call(_D, {3, _A}/[_E, _F]>>(_G is 3-1, _F is _A/_E**_G), _H), fixed_point(_H, 1.0, _B)),
%% R = -1.9999978503973392.

%% ch01:  ?- nth_root(2, P), call(P, 4, R).
%% P = {2}/[_A, _B]>>(_C is floor(log(2)/log(2)), repeated(average_damp, _C, _D), call(_D, {2, _A}/[_E, _F]>>(_G is 2-1, _F is _A/_E**_G), _H), fixed_point(_H, 1.0, _B)),
%% R = 2.000000000000002.

%% ch01:  ?- nth_root(4, P), call(P, 16, R).
%% P = {4}/[_A, _B]>>(_C is floor(log(4)/log(2)), repeated(average_damp, _C, _D), call(_D, {4, _A}/[_E, _F]>>(_G is 4-1, _F is _A/_E**_G), _H), fixed_point(_H, 1.0, _B)),
%% R = 2.0000000000021965.

%% ch01:  ?- nth_root(10, P), call(P, 1024, R).
%% P = {10}/[_A, _B]>>(_C is floor(log(10)/log(2)), repeated(average_damp, _C, _D), call(_D, {10, _A}/[_E, _F]>>(_G is 10-1, _F is _A/_E**_G), _H), fixed_point(_H, 1.0, _B)),
%% R = 2.000001183010332.

%%%
%%%    1.46
%%%
%% iterative_improve(GoodEnough, Improve, P) :-
%%     P = {P}/[Guess, X] >> ((call(GoodEnough, Guess), X = Guess) ; (call(Improve, Guess, G1), call(P, G1, X))).

iterative_improve(GoodEnough, Improve, P) :-
    P = {GoodEnough, Improve, P}/[Guess, X] >> ((call(GoodEnough, Guess), !, X = Guess) ; (call(Improve, Guess, G1), writeln(P), call(P, G1, X))).


%% y(M, F) :-
%%     Y = {M}/[Future, F1] >> (call(M, {Future}/[Arg, Result] >> (call(Future, Future, G), call(G, Arg, Result)), F1)),
%%     call(Y, Y, F).

y(M, F) :-
    call({M}/[Future, G] >> (call(M, {Future}/[In, Out] >> (call(Future, Future, F1), call(F1, In, Out)), G)),
         {M}/[Future, G] >> (call(M, {Future}/[In, Out] >> (call(Future, Future, F1), call(F1, In, Out)), G)),
         F).

iterative_improve2(GoodEnough, Improve, P) :-
    y([Recur, F] >> (F = {Recur, GoodEnough, Improve}/[Guess, X] >> ((call(GoodEnough, Guess), !, X = Guess);
                                                                     (call(Improve, Guess, G1),
                                                                      call(Recur, G1, X)))),
      P).

%% ch01:  ?- X = 4, iterative_improve2({X}/[Guess] >> (square(Guess, G2), abs(G2-X) < 0.001), {X}/[Guess, G2] >> (G1 is X / Guess, average(Guess, G1, G2)), P), call(P, 1.0, Z).
%% X = 4,
%% P = {{{[_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G)}/[_K, _L]>>(call({[_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), {[_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), _M), call(_M, _K, _L)), {4}/[_N]>>(square(_N, _O), abs(_O-4)<0.001), {4}/[_N, _O]>>(_P is 4/_N, average(_N, _P, _O))}/[_Q, _R]>>(call({4}/[_N]>>(square(_N, _O), abs(_O-4)<0.001), _Q), !, _R=_Q;call({4}/[_N, _O]>>(_P is 4/_N, average(_N, _P, _O)), _Q, _S), call({{[_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G)}/[_K, _L]>>(call({[_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), {[_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), _C), !, _D=_C;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), _M), call(_M, _K, _L)), _S, _R)),
%% Z = 2.0000000929222947.

%% ch01:  ?- X = 2, iterative_improve2({X}/[Guess] >> (square(Guess, G2), abs(G2-X) < 0.001), {X}/[Guess, G2] >> (G1 is X / Guess, average(Guess, G1, G2)), P), call(P, 1.0, Z).
%% X = 2,
%% P = {{{[_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G)}/[_K, _L]>>(call({[_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), {[_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), _M), call(_M, _K, _L)), {2}/[_N]>>(square(_N, _O), abs(_O-2)<0.001), {2}/[_N, _O]>>(_P is 2/_N, average(_N, _P, _O))}/[_Q, _R]>>(call({2}/[_N]>>(square(_N, _O), abs(_O-2)<0.001), _Q), !, _R=_Q;call({2}/[_N, _O]>>(_P is 2/_N, average(_N, _P, _O)), _Q, _S), call({{[_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G)}/[_K, _L]>>(call({[_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), {[_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D)))}/[_F, _G]>>call([_A, _B]>>(_B={_A, {2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2))}/[_C, _D]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), _C), !, _D=_C;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _C, _E), call(_A, _E, _D))), {_F}/[_H, _I]>>(call(_F, _F, _J), call(_J, _H, _I)), _G), _M), call(_M, _K, _L)), _S, _R)),
%% Z = 1.4142156862745097.

sqrt_ho2(X, Root) :-
    iterative_improve2({X}/[Guess] >> (square(Guess, G2), abs(G2-X) < 0.001),
                       {X}/[Guess, G2] >> (G1 is X / Guess, average(Guess, G1, G2)),
                       P),
    call(P, 1.0, Root).

%% ch01:  ?- sqrt_ho2(9, R).
%% R = 3.00009155413138.

%% ch01:  ?- sqrt_ho2(4, R).
%% R = 2.0000000929222947.

%% ch01:  ?- sqrt_ho2(2, R).
%% R = 1.4142156862745097.


iterative_improve3(GoodEnough, Improve, P) :-
    P = {GoodEnough, Improve, P}/[Guess, X] >> ((call(GoodEnough, Guess), !, X = Guess);
                                                (call(Improve, Guess, G1),
                                                 iterative_improve3(GoodEnough, Improve, P1),
                                                 call(P1, G1, X))).

%% ch01:  ?- X = 2, iterative_improve3({X}/[Guess] >> (square(Guess, G2), abs(G2-X) < 0.001), {X}/[Guess, G2] >> (G1 is X / Guess, average(Guess, G1, G2)), P), call(P, 1.0, Z).
%% X = 2,
%% P = _S1, % where
%%     _S1 = {{2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S1}/[1.0, 1.4142156862745097]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), 1.0), 1.4142156862745097=1.0;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), 1.0, 1.5), iterative_improve3({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S2), call(_S2, 1.5, 1.4142156862745097)),
%%     _S2 = {{2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S2}/[1.5, 1.4142156862745097]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), 1.5), 1.4142156862745097=1.5;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), 1.5, 1.4166666666666665), iterative_improve3({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S3), call(_S3, 1.4166666666666665, 1.4142156862745097)),
%%     _S3 = {{2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S3}/[1.4166666666666665, 1.4142156862745097]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), 1.4166666666666665), 1.4142156862745097=1.4166666666666665;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), 1.4166666666666665, 1.4142156862745097), iterative_improve3({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S4), call(_S4, 1.4142156862745097, 1.4142156862745097)),
%%     _S4 = {{2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _S4}/[1.4142156862745097, 1.4142156862745097]>>(call({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), 1.4142156862745097), 1.4142156862745097=1.4142156862745097;call({2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), 1.4142156862745097, _A), iterative_improve3({2}/[Guess]>>(square(Guess, G2), abs(G2-2)<0.001), {2}/[Guess, G2]>>(G1 is 2/Guess, average(Guess, G1, G2)), _B), call(_B, _A, 1.4142156862745097)),
%% Z = 1.4142156862745097 

%% ch01:  ?- X = 4, iterative_improve3({X}/[Guess] >> (square(Guess, G2), abs(G2-X) < 0.001), {X}/[Guess, G2] >> (G1 is X / Guess, average(Guess, G1, G2)), P), call(P, 1.0, Z).
%% X = 4,
%% P = _S1, % where
%%     _S1 = {{4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S1}/[1.0, 2.0000000929222947]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), 1.0), 2.0000000929222947=1.0;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), 1.0, 2.5), iterative_improve3({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S2), call(_S2, 2.5, 2.0000000929222947)),
%%     _S2 = {{4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S2}/[2.5, 2.0000000929222947]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), 2.5), 2.0000000929222947=2.5;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), 2.5, 2.05), iterative_improve3({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S3), call(_S3, 2.05, 2.0000000929222947)),
%%     _S3 = {{4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S3}/[2.05, 2.0000000929222947]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), 2.05), 2.0000000929222947=2.05;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), 2.05, 2.000609756097561), iterative_improve3({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S4), call(_S4, 2.000609756097561, 2.0000000929222947)),
%%     _S4 = {{4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S4}/[2.000609756097561, 2.0000000929222947]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), 2.000609756097561), 2.0000000929222947=2.000609756097561;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), 2.000609756097561, 2.0000000929222947), iterative_improve3({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S5), call(_S5, 2.0000000929222947, 2.0000000929222947)),
%%     _S5 = {{4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _S5}/[2.0000000929222947, 2.0000000929222947]>>(call({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), 2.0000000929222947), 2.0000000929222947=2.0000000929222947;call({4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), 2.0000000929222947, _A), iterative_improve3({4}/[Guess]>>(square(Guess, G2), abs(G2-4)<0.001), {4}/[Guess, G2]>>(G1 is 4/Guess, average(Guess, G1, G2)), _B), call(_B, _A, 2.0000000929222947)),
%% Z = 2.0000000929222947 

sqrt_ho3(X, Root) :-
    iterative_improve3({X}/[Guess] >> (square(Guess, G2), abs(G2-X) < 0.001),
                       {X}/[Guess, G2] >> (G1 is X / Guess, average(Guess, G1, G2)),
                       P),
    call(P, 1.0, Root).

%% ch01:  ?- sqrt_ho3(2, R).
%% R = 1.4142156862745097.

%% ch01:  ?- sqrt_ho3(4, R).
%% R = 2.0000000929222947.

%% ch01:  ?- sqrt_ho3(9, R).
%% R = 3.00009155413138.

fixed_point_ho2(F, Initial, X) :-
    iterative_improve2({F}/[Guess] >> (call(F, Guess, G1), tolerance(T), abs(Guess-G1) < T),
                       {F}/[Guess, G1] >> (call(F, Guess, G1)),
                       P),
    call(P, Initial, X).


fixed_point_ho3(F, Initial, X) :-
    iterative_improve3({F}/[Guess] >> (call(F, Guess, G1), tolerance(T), abs(Guess-G1) < T),
                       {F}/[Guess, G1] >> (call(F, Guess, G1)),
                       P),
    call(P, Initial, X).


%% ch01:  ?- fixed_point(cos, 1.0, V).
%% V = 0.7390822985224024.

%% ch01:  ?- fixed_point_ho3(cos, 1.0, V).
%% V = 0.7390893414033927.

%% ch01:  ?- fixed_point([X, Y] >> (Y is sin(X) + cos(X)), 1.0, V).
%% V = 1.2587315962971173.

%% ch01:  ?- fixed_point_ho3([X, Y] >> (Y is sin(X) + cos(X)), 1.0, V).
%% V = 1.2587228743052672.

%% ch01:  ?- fixed_point_ho2(cos, 1.0, V).
%% V = 0.7390893414033927.

%% ch01:  ?- fixed_point_ho2([X, Y] >> (Y is sin(X) + cos(X)), 1.0, V).
%% V = 1.2587228743052672.
