#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               newton-raphson.pl
%
%   Started:            Sun Sep 23 00:06:16 2012
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
%   Changed order of parameters in improve/3 compared to Lisp version in SICP.
%%

square(X, Y) :- Y is X * X.

average(X, Y, A) :- A is (X + Y) / 2.0.

improve(Guess, X, Y) :-
    X1 is X / Guess,
    average(Guess, X1, Y).

good_enough(Guess, X) :-
    square(Guess, G1),
    X1 is G1 - X,
    abs(X1, X2),
    X2 < 0.00001.

my_sqrt(X, Y) :- sqrt_iter(1.0, X, Y).

sqrt_iter(Guess, X, Guess) :- good_enough(Guess, X), !.
sqrt_iter(Guess, X, Y) :-
    improve(Guess, X, G1),
    sqrt_iter(G1, X, Y).

%%%
%%%     火 251028
%%%
%%%     Ex. 1.8
%%%
cube(X, Y) :- Y is X * X * X.

improve_cbrt(Guess, X, Y) :-
    square(Guess, G2),
    Y is (2 * Guess + X / G2) / 3.

good_enough_cbrt(Guess, X) :-
    cube(Guess, G3),
    abs((G3 - X) / X) < 0.001.

cbrt_iter(Guess, X, Guess) :- good_enough_cbrt(Guess, X), !.
cbrt_iter(Guess, X, Y) :-
    improve_cbrt(Guess, X, G1),
    cbrt_iter(G1, X, Y).

cbrt(X, Y) :- cbrt_iter(1.0, X, Y).

