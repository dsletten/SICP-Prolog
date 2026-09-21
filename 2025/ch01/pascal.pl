#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               pascal.pl
%
%   Started:            Sun May 10 02:43:07 2026
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

:- module(pascal, []).

pascal(_, 0, 1) :- !.
pascal(I, I, 1) :- !.
pascal(R, C, P) :-
    R1 is R - 1,
    C1 is C - 1,
    pascal(R1, C1, P1),
    pascal(R1, C, P2),
    P is P1 + P2.

triangle(N, Row) :-
    triangle(N, 0, Row).
triangle(R, C, []) :- C > R, !.
triangle(R, C, [P|Row]) :-
    pascal(R, C, P),
    C1 is C + 1,
    triangle(R, C1, Row).

pascal_tr(R, C, P) :-
    pascal_tr(R, C, 0, 1, 1, P).
pascal_tr(_, C, C, _, V, V) :- !.
pascal_tr(R, C, I0, I1, V, P) :-
    I2 is I1 + 1,
    V1 is V * (R - I0) / I1,
    pascal_tr(R, C, I1, I2, V1, P).

triangle_tr(N, Row) :-
    triangle_tr(N, 0, Row).
triangle_tr(R, C, []) :- C > R, !.
triangle_tr(R, C, [P|Row]) :-
    pascal_tr(R, C, P),
    C1 is C + 1,
    triangle_tr(R, C1, Row).

%%%
%%%    Numerator decreases. Denominator increases.
%%%    
pascal_tr2(R, C, P) :-
    C1 is min(C, R-C),
    pascal_tr2(C1, 0, R, 1, 1, P).
pascal_tr2(C, C, _, _, V, V) :- !.
pascal_tr2(C, I, N, D, V, P) :-
    I1 is I + 1,
    N1 is N - 1,
    D1 is D + 1,
    V1 is V * N / D,
    pascal_tr2(C, I1, N1, D1, V1, P).

triangle_tr2(N, Row) :-
    triangle_tr2(N, 0, Row).
triangle_tr2(R, C, []) :- C > R, !.
triangle_tr2(R, C, [P|Row]) :-
    pascal_tr2(R, C, P),
    C1 is C + 1,
    triangle_tr2(R, C1, Row).
