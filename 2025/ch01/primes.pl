#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               primes.pl
%
%   Started:            Wed May 20 14:01:50 2026
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

:- module(primes, []).

:- ['/home/slytobias/Thelio/modified/prolog/modules/core'].


square(X, Y) :- Y is X * X.

%% smallest_divisor(N, D) :-
%%     find_divisor(N, 2, D).
%%%
%%%    D'oh!
%%%    
%% primes:  ?- smallest_divisor(4, 4).
%% true.

%%%
%%%    Assumes that D is uninstantiated above. This can cause problems when it
%%%    is already instantiated:
%%%        It is reasonable for find_divisor/3 to succeed with find_divisor(4, 2, 4).
%%%        It is not reasonable for smallest_divisor/2 to succeed with smallest_divisor(4, 4).
%%%        
%%%    The version below fixes that.
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

%%%
%%%    This relies on smallest_divisor doing its job properly, namely determining the
%%%    `smallest` divisor. The original version allowed this:
%%%    smallest_divisor(4, 4).
%%%    
is_prime(1) :- !, fail.
is_prime(N) :-
    smallest_divisor(N, N).

%% is_prime(N) :-
%%     smallest_divisor(N, D),
%%     !,
%%     N = D.

%% primes:  ?- is_prime(1).
%% true.

%% primes:  ?- smallest_divisor(1, D).
%% D = 1.

exp_mod(_, 0, _, 1) :- !.
exp_mod(Base, Exp, M, X) :-
    is_even(Exp),
    !,
    Exp1 is Exp div 2,
    exp_mod(Base, Exp1, M, X1),
    square(X1, X2),
    X is X2 rem M.
exp_mod(Base, Exp, M, X) :-
    Exp1 is Exp - 1,
    exp_mod(Base, Exp1, M, X1),
    X2 is Base * X1,
    X is X2 rem M.

set_seed() :-
    set_random(seed(random)).

fermat_test(N) :-
    N1 is N - 1,
    random_between(1, N1, A),
    fermat_test(A, N).

fermat_test(A, N) :-
    exp_mod(A, N, N, A).

fast_is_prime(1, _) :- !, fail.
fast_is_prime(_, 0) :- !.
fast_is_prime(N, Times) :-
    fermat_test(N),
    T1 is Times - 1,
    fast_is_prime(N, T1).

%% primes:  ?- fast_is_prime(2, 10).
%% true.

%% primes:  ?- fast_is_prime(4, 10).
%% false.

%% primes:  ?- fast_is_prime(99, 10).
%% false.

%% primes:  ?- fast_is_prime(1729, 10).               <-- Carmichael number!
%% true.

%% primes:  ?- fast_is_prime(15485849, 10).
%% true.

%%%
%%%    1.23
%%%
smallest_divisor_a(N, D) :-
    find_divisor_a(N, 2, D1),
    !,
    D = D1.

find_divisor_a(N, T, N) :-
    square(T, T2),
    T2 > N,
    !.
find_divisor_a(N, T, T) :-
    divides(T, N),
    !.
find_divisor_a(N, T, D) :-
    next_divisor(T, T1),
    find_divisor_a(N, T1, D).

next_divisor(2, 3) :- !.
next_divisor(N, M) :- M is N + 2.

is_prime_a(1) :- !, fail.
is_prime_a(N) :-
    smallest_divisor_a(N, N).

smallest_divisor_b(N, D) :-
    find_divisor_b(N, 2, D1),
    !,
    D = D1.

find_divisor_b(N, T, N) :-
    square(T, T2),
    T2 > N,
    !.
find_divisor_b(N, T, T) :-
    divides(T, N),
    !.
find_divisor_b(N, 2, D) :-
    find_divisor_b(N, 3, D).
find_divisor_b(N, T, D) :-
    T1 is T + 2,
    find_divisor_b(N, T1, D).

is_prime_b(1) :- !, fail.
is_prime_b(N) :-
    smallest_divisor_b(N, N).

smallest_divisor_c(N, D) :-
    find_divisor_c(N, 2, D1),
    !,
    D = D1.

find_divisor_c(N, T, N) :-
    square(T, T2),
    T2 > N,
    !.
find_divisor_c(N, T, T) :-
    divides(T, N),
    !.
find_divisor_c(N, T, D) :-
    T1 is T + 1,
    find_divisor_odd(N, T1, D).

find_divisor_odd(N, T, N) :-
    square(T, T2),
    T2 > N,
    !.
find_divisor_odd(N, T, T) :-
    divides(T, N),
    !.
find_divisor_odd(N, T, D) :-
    T1 is T + 2,
    find_divisor_odd(N, T1, D).

next_divisor(2, 3) :- !.
next_divisor(N, M) :- M is N + 2.

is_prime_c(1) :- !, fail.
is_prime_c(N) :-
    smallest_divisor_c(N, N).

%%%
%%%    1.27
%%%
is_carmichael(N) :-
    confirm(1, N),
    \+ is_prime(N).

confirm(N, N) :- !.
confirm(A, N) :-
    exp_mod(A, N, N, A),
    !,
    A1 is A + 1,
    confirm(A1, N).

%%%
%%%    https://rosettacode.org/wiki/Miller-Rabin_primality_test#Prolog
%%%
:- module(primality, [is_prime/2]).

% is_prime/2 returns false if N is composite, true if N probably prime
%    implements a Miller-Rabin primality test and is deterministic for N < 3.415e+14,
%    and is probabilistic for larger N. Adapted from the Erlang version.
is_prime(1, Ret) :- Ret = false, !.          % 1 is non-prime
is_prime(2, Ret) :- Ret = true, !.           % 2 is prime
is_prime(3, Ret) :- Ret = true, !.           % 3 is prime
is_prime(N, Ret) :- 
    N > 3, (N mod 2 =:= 0), Ret = false, !.  % even number > 3 is composite
is_prime(N, Ret) :- 
    N > 3, (N mod 2 =:= 1),                  % odd number > 3
    N < 341550071728321,
    deterministic_witnesses(N, L),
    is_mr_prime(N, L, Ret), !.               % deterministic test
is_prime(N, Ret) :-
    random_witnesses(N, 100, [], Out),
    is_mr_prime(N, Out, Ret), !.             % probabilistic test

% returns list of deterministic witnesses
deterministic_witnesses(N, L) :- N < 1373653,
	                         L = [2, 3].
deterministic_witnesses(N, L) :- N < 9080191,
	                         L = [31, 73].
deterministic_witnesses(N, L) :- N < 25326001,
	                         L = [2, 3, 5].
deterministic_witnesses(N, L) :- N < 3215031751,
	                         L = [2, 3, 5, 7].
deterministic_witnesses(N, L) :- N < 4759123141,
	                         L = [2, 7, 61].
deterministic_witnesses(N, L) :- N < 1122004669633,
	                         L = [2, 13, 23, 1662803].
deterministic_witnesses(N, L) :- N < 2152302898747,
	                         L = [2, 3, 5, 7, 11].
deterministic_witnesses(N, L) :- N < 3474749660383,
	                         L = [2, 3, 5, 7, 11, 13].
deterministic_witnesses(N, L) :- N < 341550071728321,
	                         L = [2, 3, 5, 7, 11, 13, 17].

% random_witnesses/4 returns a list of K witnesses selected at random with range 2 -> N-2
random_witnesses(_, 0, T, T).
random_witnesses(N, K, T, Out) :-
    G is N - 2,
    H is 1 + random(G),
    I is K - 1,
    random_witnesses(N, I, [H | T], Out), !.

% find_ds/2 receives odd integer N and returns [D, S] s.t. N-1 = 2^S * D
find_ds(N, L) :-
    A is N - 1,
    find_ds(A, 0, L), !.

find_ds(D, S, L) :-
    D mod 2 =:= 0,
    P is D // 2,
    Q is S + 1,
    find_ds(P, Q, L), !.
find_ds(D, S, L) :-
    L = [D, S].

is_mr_prime(N, As, Ret) :-
    find_ds(N, L),
    L = [D | T],
    T = [S | _],
    outer_loop(N, As, D, S, Ret), !.

outer_loop(N, As, D, S, Ret) :-
    As = [A | At],
    Base is powm(A, D, N),
    inner_loop(Base, N, 0, S, Result),
    (  Result == false           -> Ret = false
    ;  Result == true, At == []  -> Ret = true
    ;  outer_loop(N, At, D, S, Ret)
    ).
    
inner_loop(Base, N, Loop, S, Result) :-
    Next_Base is (Base * Base) mod N,
    Next_Loop is Loop + 1,
    ( Loop =:= 0, Base =:= 1   -> Result = true
    ;             Base =:= N-1 -> Result = true
    ; Next_Loop =:= S          -> Result = false
    ; inner_loop(Next_Base, N, Next_Loop, S, Result)
    ).
