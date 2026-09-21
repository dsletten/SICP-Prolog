#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               church.pl
%
%   Started:            Fri Jul 31 14:31:04 2026
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

:- module(church, []).

increment(N, M) :- M is N + 1.



zero(_, [X, Y] >> (Y is X)).

successor(N, {N}/[F, M] >> (M = {N}/[X, Y] >> (call(N, F, G), call(G, X, Z), call(F, Z, Y)))).

    
church:  ?- successor(zero, One), call(One, increment, F), call(F, 8, Y).
One = {zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D))),
F = {zero}/[_G, _H]>>(call(zero, increment, _I), call(_I, _G, _J), call(increment, _J, _H)),
Y = 9.

church:  ?- successor(zero, One), successor(One, Two), call(Two, increment, F), call(F, 8, Y).
One = {zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D))),
Two = {{zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D)))}/[_G, _H]>>(_H={{zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D)))}/[_I, _J]>>(call({zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D))), _G, _K), call(_K, _I, _L), call(_G, _L, _J))),
F = {{zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D)))}/[_M, _N]>>(call({zero}/[_A, _B]>>(_B={zero}/[_C, _D]>>(call(zero, _A, _E), call(_E, _C, _F), call(_A, _F, _D))), increment, _O), call(_O, _M, _P), call(increment, _P, _N)),
Y = 10.
