#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               pascal.pl
%
%   Started:            Mon Sep 24 09:30:01 2012
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

pascal(_, 0, 0) :- !.
pascal(I, J, 0) :- J > I, !.
pascal(1, 1, 1) :- !.
pascal(I, J, P) :-
    I1 is I - 1,
    J1 is J - 1,
    pascal(I1, J1, P1),
    pascal(I1, J, P2),
    P is P1 + P2.

pascal2(_, 0, 1) :- !.
pascal2(I, J, P) :-
    J1 is J - 1,
    pascal2(I, J1, P1),
    P is P1 * (I - J) / J.

pascal3(R, C, P) :-
    pascal3(R, C, 0, P, 1).
pascal3(_, C, C, P, P) :- !.
pascal3(R, C, I, P, V) :-
    V1 is V * (R - (I + 1)) / (I + 1),
    I1 is I + 1,
    pascal3(R, C, I1, P, V1).

pascal3a(R, C, P) :-
    C1 is C - 1,
    pascal3(R, C1, P).

pascal_row(N, Row) :-
    pascal_row(N, 1, Row).
pascal_row(N, I, []) :- I > N, !.
pascal_row(N, I, [P|T]) :-
    pascal3a(N, I, P),
    I1 is I + 1,
    pascal_row(N, I1, T).
    
%% pascal3(_, 0, 1) :- !.
%% pascal3(I, J, P) :-
%%     pascal3(I, J, P, 0).
%% pascal3(I, J, P, K) :-
%%     J1 is J - 1,
%%     pascal3(I, J, V1),

%% pascal3(_, 1, 1) :- !.
%% pascal3(I, J, P) :-
%%     J1 is J - 1,
%%     pascal3(I, J1, P, V).
%% pascal3(I, J, P, V) :-
%%     J1 is J - 1,
%%     pascal3(I, J, V1),
    