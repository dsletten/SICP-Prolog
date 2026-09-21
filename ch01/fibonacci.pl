#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               fibonacci.pl
%
%   Started:            Thu Sep 27 01:25:46 2012
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

fibonacci(N, F) :-
    fibonacci(N, 1, 0, F).

fibonacci(0, _, B, B) :- !.
fibonacci(N, A, B, F) :-
    N1 is N - 1,
    A1 is A + B,
    fibonacci(N1, A1, A, F).
