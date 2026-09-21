#!/usr/local/bin/pl -q -t main -f
%%
%   -*- Mode: Prolog -*-
%   Name:               change.pl
%
%   Started:            Thu Sep 27 01:32:34 2012
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

denomination(penny, 1).
denomination(nickel, 5).
denomination(dime, 10).
denomination(quarter, 25).
denomination(half_dollar, 50).

make_change(0, _, 1) :- !.
make_change(_, [], 0) :- !.
make_change(A, _, 0) :- A < 0, !.
make_change(A, [Coin|Coins], Count) :-
    denomination(Coin, D),
    A1 is A - D,
    make_change(A, Coins, Count1),
    make_change(A1, [Coin|Coins], Count2),
    Count is Count1 + Count2.

make_change2(Amount, [Coin|Coins], Count) :-
    denomination(Coin, D),
    Amount1 is Amount - D,
    fewer_coins(Amount, Coins, Count1),
    less_money(Amount1, [Coin|Coins], Count2),
    Count is Count1 + Count2.

fewer_coins(_, [], 0) :- !.
fewer_coins(Amount, Coins, Count) :-
    make_change2(Amount, Coins, Count).

less_money(0, _, 1) :- !.
less_money(A, _, 0) :- A < 0, !.
less_money(Amount, Coins, Count) :-
    make_change2(Amount, Coins, Count).
