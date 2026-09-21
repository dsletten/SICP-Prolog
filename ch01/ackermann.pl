#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               ackermann.pl
%
%   Started:            Sat Sep 22 23:52:45 2012
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

ackermann(_, 0, 0) :- !.
ackermann(0, Y, A) :- A is 2 * Y, !.
ackermann(_, 1, 2) :- !.
ackermann(X, Y, A) :-
    X1 is X - 1,
    Y1 is Y - 1,
    ackermann(X, Y1, A1),
    ackermann(X1, A1, A).

?- ackermann(0, 1, A).
A = 2.

?- ackermann(0, 2, A).
A = 4.

?- ackermann(0, 3, A).
A = 6.

?- ackermann(1, 1, A).
A = 2.

?- ackermann(1, 2, A).
A = 4.

?- ackermann(1, 3, A).
A = 8.

?- ackermann(2, 1, A).
A = 2.

?- ackermann(2, 2, A).
A = 4.

?- ackermann(2, 3, A).
A = 16.

?- ackermann(2, 4, A).
A = 65536.

%% ackermann(_, 0, 0).
%% ackermann(0, Y, A) :-
%%     Y \= 0,
%%     A is 2 * Y.
%% ackermann(X, 1, 2) :-
%%     X \= 0.
%% ackermann(X, Y, A) :-
%%     Y \= 0,
%%     X \= 0,
%%     X1 is X - 1,
%%     Y1 is Y - 1,
%%     ackermann(X, Y1, A1),
%%     ackermann(X1, A1, A).
