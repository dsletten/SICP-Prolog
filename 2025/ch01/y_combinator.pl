#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               y_combinator.pl
%
%   Started:            Tue Jul  7 14:48:14 2026
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

:- module(y_combinator, []).

collatz(1) :- !.
collatz(N) :-
    N mod 2 =:= 0,
    !,
    N1 is N / 2,
    collatz(N1).
collatz(N) :-
    N1 is 3 * N + 1,
    collatz(N1).

collatz1(N) :-
    (N = 1, !) ; (N mod 2 =:= 0, !, N1 is N / 2, collatz1(N1)) ; (N1 is 3 * N + 1, collatz1(N1)).

%% y_combinator:  ?- collatz1(10).
%% true.

%% y_combinator:  ?- collatz1(9).
%% true.

%% y_combinator:  ?- collatz1(150).
%% true.

collatz2(N, F) :-
    (N = 1, !) ; (N mod 2 =:= 0, !, N1 is N / 2, collatz2(N1, F)) ; (N1 is 3 * N + 1, collatz2(N1, F)).
    
%% y_combinator:  ?- collatz2(10, collatz2).
%% true.

%% y_combinator:  ?- collatz2(9, collatz2).
%% true.

%% y_combinator:  ?- collatz2(150, collatz2).
%% true.

collatz_maker(Future, F) :-
    F = {Future}/[N] >> ((N = 1, !);
                         (N mod 2 =:= 0, !, collatz_maker(Future, F1), N1 is N / 2, call(F1, N1));
                         (collatz_maker(Future, F1), N1 is 3 * N + 1, call(F1, N1))).

%% y_combinator:  ?- collatz_maker(foo, C), call(C, 10).
%% C = {foo}/[_A]>>(_A=1, !;_A mod 2=:=0, !, call(collatz_maker, foo, _B), _C is _A/2, call(_B, _C);call(collatz_maker, foo, _B), _C is 3*_A+1, call(_B, _C)).

%% y_combinator:  ?- collatz_maker(foo, C), call(C, 9).
%% C = {foo}/[_A]>>(_A=1, !;_A mod 2=:=0, !, call(collatz_maker, foo, _B), _C is _A/2, call(_B, _C);call(collatz_maker, foo, _B), _C is 3*_A+1, call(_B, _C)).

%% y_combinator:  ?- collatz_maker(foo, C), call(C, 150).
%% C = {foo}/[_A]>>(_A=1, !;_A mod 2=:=0, !, call(collatz_maker, foo, _B), _C is _A/2, call(_B, _C);call(collatz_maker, foo, _B), _C is 3*_A+1, call(_B, _C)).

collatz_maker1(Future, F) :-
    F = {Future}/[N] >> ((N = 1, !);
                         (N mod 2 =:= 0, !, call(Future, Future, F1), N1 is N / 2, call(F1, N1));
                         (call(Future, Future, F1), N1 is 3 * N + 1, call(F1, N1))).

%% y_combinator:  ?- collatz_maker1(collatz_maker1, C), call(C, 10).
%% C = {collatz_maker1}/[_A]>>(_A=1, !;_A mod 2=:=0, !, call(collatz_maker1, collatz_maker1, _B), _C is _A/2, call(_B, _C);call(collatz_maker1, collatz_maker1, _B), _C is 3*_A+1, call(_B, _C)).

%% y_combinator:  ?- collatz_maker1(collatz_maker1, C), call(C, 9).
%% C = {collatz_maker1}/[_A]>>(_A=1, !;_A mod 2=:=0, !, call(collatz_maker1, collatz_maker1, _B), _C is _A/2, call(_B, _C);call(collatz_maker1, collatz_maker1, _B), _C is 3*_A+1, call(_B, _C)).

%% y_combinator:  ?- collatz_maker1(collatz_maker1, C), call(C, 150).
%% C = {collatz_maker1}/[_A]>>(_A=1, !;_A mod 2=:=0, !, call(collatz_maker1, collatz_maker1, _B), _C is _A/2, call(_B, _C);call(collatz_maker1, collatz_maker1, _B), _C is 3*_A+1, call(_B, _C)).

collatz_maker2(Future, F) :-
%    F = {Future}/[N] >> ((N = 1, !); ?????
    F = [N] >> ((N = 1, !);
                (N mod 2 =:= 0,
                 !,
                 N1 is N / 2,
                 call({Future}/[Arg] >> (call(Future, Future, F1), call(F1, Arg)), N1));
                (N1 is 3 * N + 1,
                 call({Future}/[Arg] >> (call(Future, Future, F1), call(F1, Arg)), N1))).

%% y_combinator:  ?- collatz_maker2(collatz_maker2, C), call(C, 10).
%% C = {collatz_maker2}/[_A]>>(_A=1, !;_A mod 2=:=0, !, _B is _A/2, call({collatz_maker2}/[_C]>>(call(collatz_maker2, collatz_maker2, _D), call(_D, _C)), _B);_B is 3*_A+1, call({collatz_maker2}/[_C]>>(call(collatz_maker2, collatz_maker2, _D), call(_D, _C)), _B)).

%% y_combinator:  ?- collatz_maker2(collatz_maker2, C), call(C, 9).
%% C = {collatz_maker2}/[_A]>>(_A=1, !;_A mod 2=:=0, !, _B is _A/2, call({collatz_maker2}/[_C]>>(call(collatz_maker2, collatz_maker2, _D), call(_D, _C)), _B);_B is 3*_A+1, call({collatz_maker2}/[_C]>>(call(collatz_maker2, collatz_maker2, _D), call(_D, _C)), _B)).

%% y_combinator:  ?- collatz_maker2(collatz_maker2, C), call(C, 150).
%% C = {collatz_maker2}/[_A]>>(_A=1, !;_A mod 2=:=0, !, _B is _A/2, call({collatz_maker2}/[_C]>>(call(collatz_maker2, collatz_maker2, _D), call(_D, _C)), _B);_B is 3*_A+1, call({collatz_maker2}/[_C]>>(call(collatz_maker2, collatz_maker2, _D), call(_D, _C)), _B)).

collatz_maker3(Future, F) :-
    call([Recur, G] >> (G = {Recur}/[N] >> ((N = 1, !);
                                            (N mod 2 =:= 0,
                                             !,
                                             N1 is N / 2,
                                             call(Recur, N1));
                                            (N1 is 3 * N + 1,
                                             call(Recur, N1)))),
         {Future}/[Arg] >> (call(Future, Future, F1), call(F1, Arg)),
         F).
                              
%% y_combinator:  ?- collatz_maker3(collatz_maker3, C), call(C, 10).
%% C = {{collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A))}/[_C]>>(_C=1, !;_C mod 2=:=0, !, _D is _C/2, call({collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A)), _D);_D is 3*_C+1, call({collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A)), _D)).

%% y_combinator:  ?- collatz_maker3(collatz_maker3, C), call(C, 9).
%% C = {{collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A))}/[_C]>>(_C=1, !;_C mod 2=:=0, !, _D is _C/2, call({collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A)), _D);_D is 3*_C+1, call({collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A)), _D)).

%% y_combinator:  ?- collatz_maker3(collatz_maker3, C), call(C, 150).
%% C = {{collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A))}/[_C]>>(_C=1, !;_C mod 2=:=0, !, _D is _C/2, call({collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A)), _D);_D is 3*_C+1, call({collatz_maker3}/[_A]>>(call(collatz_maker3, collatz_maker3, _B), call(_B, _A)), _D)).

collatz_maker4(Future, F) :-
    collatz_m({Future}/[Arg] >> (call(Future, Future, F1), call(F1, Arg)), F).

collatz_m(Recur, F) :-
    F = {Recur}/[N] >> ((N = 1, !);
                        (N mod 2 =:= 0,
                         !,
                         N1 is N / 2,
                         call(Recur, N1));
                        (N1 is 3 * N + 1,
                         call(Recur, N1))).

%% y_combinator:  ?- collatz_maker4(collatz_maker4, C), call(C, 10).
%% C = {{collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A))}/[_C]>>(_C=1, !;_C mod 2=:=0, !, _D is _C/2, call({collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A)), _D);_D is 3*_C+1, call({collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A)), _D)).

%% y_combinator:  ?- collatz_maker4(collatz_maker4, C), call(C, 9).
%% C = {{collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A))}/[_C]>>(_C=1, !;_C mod 2=:=0, !, _D is _C/2, call({collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A)), _D);_D is 3*_C+1, call({collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A)), _D)).

%% y_combinator:  ?- collatz_maker4(collatz_maker4, C), call(C, 150).
%% C = {{collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A))}/[_C]>>(_C=1, !;_C mod 2=:=0, !, _D is _C/2, call({collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A)), _D);_D is 3*_C+1, call({collatz_maker4}/[_A]>>(call(collatz_maker4, collatz_maker4, _B), call(_B, _A)), _D)).

collatz_maker5(F) :-
    call([Future, G] >> (collatz_m({Future}/[Arg] >> (call(Future, Future, F1), call(F1, Arg)), G)),
         [Future, G] >> (collatz_m({Future}/[Arg] >> (call(Future, Future, F1), call(F1, Arg)), G)),
         F).

%% y_combinator:  ?- collatz_maker5(C), call(C, 10).
%% C = {{[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E))}/[_G]>>(_G=1, !;_G mod 2=:=0, !, _H is _G/2, call({[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H);_H is 3*_G+1, call({[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H)).

%% y_combinator:  ?- collatz_maker5(C), call(C, 9).
%% C = {{[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E))}/[_G]>>(_G=1, !;_G mod 2=:=0, !, _H is _G/2, call({[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H);_H is 3*_G+1, call({[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H)).

%% y_combinator:  ?- collatz_maker5(C), call(C, 150).
%% C = {{[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E))}/[_G]>>(_G=1, !;_G mod 2=:=0, !, _H is _G/2, call({[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H);_H is 3*_G+1, call({[_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call([_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), [_A, _B]>>collatz_m({_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H)).

%% factorial_m(Recur, F) :-
%%     F = {Recur}/[N, Fact] >> ((N = 0, !, Fact is 1);
%%                               (N1 is N - 1,
%%                                call(Recur, N1, Fact1),
%%                                Fact is N * Fact1)).
%% collatz_m(Recur, F) :-
%%     F = {Recur}/[N] >> ((N = 1, !);
%%                         (N mod 2 =:= 0,
%%                          !,
%%                          N1 is N / 2,
%%                          call(Recur, N1));
%%                         (N1 is 3 * N + 1,
%%                          call(Recur, N1))).

%% F = {{{factorial_m}/[_A, _B]>>call(factorial_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call({factorial_m}/[_A, _B]>>call(factorial_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), {factorial_m}/[_A, _B]>>call(factorial_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E))}/[_G, _H]>>(_G=0, !, _H=1;_I is _G-1, call({{factorial_m}/[_A, _B]>>call(factorial_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call({factorial_m}/[_A, _B]>>call(factorial_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), {factorial_m}/[_A, _B]>>call(factorial_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _I, _J), _H is _G*_J).

%% F = {{{collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call({collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), {collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E))}/[_G]>>(_G=1, !;_G mod 2=:=0, !, _H is _G/2, call({{collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call({collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), {collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H);_H is 3*_G+1, call({{collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B)}/[_E]>>(call({collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), {collatz_m}/[_A, _B]>>call(collatz_m, {_A}/[_C]>>(call(_A, _A, _D), call(_D, _C)), _B), _F), call(_F, _E)), _H)).

factorial(0, 1) :- !.
factorial(N, Fact) :-
    N1 is N - 1,
    factorial(N1, Fact1),
    Fact is N * Fact1.

factorial1(N, Fact) :-
    (N = 0, !, Fact = 1);
    (N1 is N - 1,
     factorial1(N1, Fact1),
     Fact is N * Fact1).

factorial2(N, Fact, F) :-
    (N = 0, !, Fact = 1);
    (N1 is N - 1,
     factorial2(N1, Fact1, F),
     Fact is N * Fact1).

factorial_maker(Future, F) :-
    F = {Future}/[N, Fact] >> ((N = 0, !, Fact = 1);
                               (N1 is N - 1,
                                factorial_maker(Future, F1),
                                call(F1, N1, Fact1),
                                Fact is N * Fact1)).

%% y_combinator:  ?- factorial_maker(foo, F), call(F, 6, Fact).
%% F = {foo}/[_A, _B]>>(_A=0, !, _B=1;_C is _A-1, factorial_maker(foo, _D), call(_D, _C, _E), _B is _A*_E),
%% Fact = 720.

factorial_maker1(Future, F) :-
    F = {Future}/[N, Fact] >> ((N = 0, !, Fact = 1);
                               (N1 is N - 1,
                                call(Future, Future, F1),
                                call(F1, N1, Fact1),
                                Fact is N * Fact1)).

%% y_combinator:  ?- factorial_maker1(factorial_maker1, F), call(F, 6, Fact).
%% F = {factorial_maker1}/[_A, _B]>>(_A=0, !, _B=1;_C is _A-1, call(factorial_maker1, factorial_maker1, _D), call(_D, _C, _E), _B is _A*_E),
%% Fact = 720.

factorial_maker2(Future, F) :-
    F = [N, Fact] >> ((N = 0, !, Fact = 1);
                      (N1 is N - 1,
                       call({Future, Fact}/[Arg] >> (call(Future, Future, F1),
                                                     call(F1, Arg, Fact1),
                                                     Fact is N * Fact1),
                            N1))).

%% ?- factorial_maker2(factorial_maker2, F).
%% F = [_A, _B]>>(_A=0, !, _B=1;
%%                _C is _A-1,
%%                call({factorial_maker2, _B}/[_D]>>(call(factorial_maker2, factorial_maker2, _E),
%%                                                   call(_E, _D, _F), _B is _A*_F),
%%                     _C)).

%%%
%%%    This definition is broken. A different variable `Fact' is created in the nested lambda expression.
%%%    
%% factorial_maker2__(Future, F) :-
%%     F = [N, Fact] >> ((N = 0, !, Fact = 1);
%%                       (N1 is N - 1,
%%                        call({Future}/[Arg] >> (call(Future, Future, F1),
%%                                                      call(F1, Arg, Fact1),
%%                                                      Fact is N * Fact1),
%%                             N1))).

%% ?- factorial_maker2__(factorial_maker2__, F).
%% F = [_A, _B]>>(_A=0, !, _B=1;
%%                _C is _A-1,
%%                call({factorial_maker2__}/[_D]>>(call(factorial_maker2__, factorial_maker2__, _E),
%%                                                 call(_E, _D, _F), _B is _A*_F),
%%                     _C)).






factorial_tr(0, Fact, Fact) :- !.
factorial_tr(N, Fact, Acc) :-
    Acc1 is N * Acc,
    N1 is N - 1,
    factorial_tr(N1, Fact, Acc1).

factorial_tr1(N, Fact, Acc) :-
    (N = 0, !, Fact = Acc);
    (Acc1 is N * Acc,
     N1 is N - 1,
     factorial_tr1(N1, Fact, Acc1)).

factorial_tr2(N, Fact, Acc, F) :-
    (N = 0, !, Fact = Acc);
    (Acc1 is N * Acc,
     N1 is N - 1,
     factorial_tr2(N1, Fact, Acc1, F)).

%% y_combinator:  ?- factorial_tr2(6, F, 1, foo).
%% F = 720.

factorial_maker_tr(Future, F) :-
    F = {Future}/[N, Fact, Acc] >> ((N = 0, !, Fact = Acc);
                                    (Acc1 is N * Acc,
                                     N1 is N - 1,
                                     factorial_maker_tr(Future, F1),
                                     call(F1, N1, Fact, Acc1))).

%% y_combinator:  ?- factorial_maker_tr(foo, F), call(F, 6, Fact, 1).
%% F = {foo}/[_A, _B, _C]>>(_A=0, !, _B=_C;_D is _A*_C, _E is _A-1, factorial_maker_tr(foo, _F), call(_F, _E, _B, _D)),
%% Fact = 720.

factorial_maker_tr1(Future, F) :-
    F = {Future}/[N, Fact, Acc] >> ((N = 0, !, Fact = Acc);
                                    (Acc1 is N * Acc,
                                     N1 is N - 1,
                                     call(Future, Future, F1),
                                     call(F1, N1, Fact, Acc1))).

%% y_combinator:  ?- factorial_maker_tr1(factorial_maker_tr1, F), call(F, 6, Fact, 1).
%% F = {factorial_maker_tr1}/[_A, _B, _C]>>(_A=0, !, _B=_C;_D is _A*_C, _E is _A-1, call(factorial_maker_tr1, factorial_maker_tr1, _F), call(_F, _E, _B, _D)),
%% Fact = 720.

factorial_maker_tr2(Future, F) :-
    F = [N, Fact, Acc] >> ((N = 0, !, Fact = Acc);
                           (Acc1 is N * Acc,
                            N1 is N - 1,
                            call({Future, Fact, Acc1}/[Arg] >> (call(Future, Future, F1),
                                                                call(F1, Arg, Fact, Acc1)),
                                 N1))).

factorial_maker_tr3(Future, F) :-
    call([Recur, G] >> (G = {Recur}/[N, Fact, Acc] >> ((N = 0, !, Fact = Acc);
                                                       (Acc1 is N * Acc,
                                                        N1 is N - 1,
                                                        call(Recur, N1)))),
         {Future, Fact, Acc1}/[Arg] >> (call(Future, Future, F1), call(F1, Arg, Fact, Acc1)),
         F).

factorial_maker_tr3__(Future, F) :-
    call([Recur, G] >> (G = {Recur}/[N, Fact, Acc] >> ((N = 0, !, Fact = Acc);
                                                       (Acc1 is N * Acc,
                                                        N1 is N - 1,
                                                        call(Recur, N1, Fact, Acc1)))),
         [Arg, Fact, Acc] >> (call(Future, Future, F1), call(F1, Arg, Fact, Acc)),
         F).

factorial_maker_tr4__(Future, F) :-
    factorial_tr_m__({Future}/[Arg, Fact, Acc] >>(call(Future, Future, F1), call(F1, Arg, Fact, Acc)), F).

factorial_tr_m__(Recur, F) :-
    F = {Recur}/[N, Fact, Acc] >> ((N = 0, !, Fact = Acc);
                                   (Acc1 is N * Acc,
                                    N1 is N - 1,
                                    call(Recur, N1, Fact, Acc1))).

factorial_maker_tr5__(F) :-
    call([Future, G] >> (factorial_tr_m__({Future}/[Arg, Fact, Acc] >>(call(Future, Future, F1), call(F1, Arg, Fact, Acc)), G)),
         [Future, G] >> (factorial_tr_m__({Future}/[Arg, Fact, Acc] >>(call(Future, Future, F1), call(F1, Arg, Fact, Acc)), G)),
         F).




plus5(0, 5) :- !.
plus5(N, M) :-
    N1 is N - 1,
    plus5(N1, M1),
    M is M1 + 1.

plus1(N, M) :-
    (N = 0, !, M = 5);
    (N1 is N - 1, plus1(N1, M1), M is M1 + 1).

plus2(N, M, F) :-
    (N = 0, !, M = 5);
    (N1 is N - 1, plus2(N1, M1, F), M is M1 + 1).

%% plus3(N, P) :-
%%     P = {N}/[F, M] >> ((N = 0, !, M = 5);
%%                        (N1 is N - 1, call(F, N1, M1), M is M1 + 1).

plus_maker(Future, F) :-
    F = {Future}/[N, M] >> ((N = 0, !, M = 5);
                            (N1 is N - 1,
                             plus_maker(Future, F1),
                             call(F1, N1, M1),
                             M is M1 + 1)).

%% y_combinator:  ?- plus_maker(plus_maker, P), call(P, 9, M).
%% P = {plus_maker}/[_A, _B]>>(_A=0, !, _B=5;_C is _A-1, plus_maker(plus_maker, _D), call(_D, _C, _E), _B is _E+1),
%% M = 14.

plus_maker1(Future, F) :-
    F = {Future}/[N, M] >> ((N = 0, !, M = 5);
                            (N1 is N - 1,
                             call(Future, Future, F1),
                             call(F1, N1, M1),
                             M is M1 + 1)).

%% y_combinator:  ?- plus_maker1(plus_maker1, P), call(P, 9, M).
%% P = {plus_maker1}/[_A, _B]>>(_A=0, !, _B=5;_C is _A-1, call(plus_maker1, plus_maker1, _D), call(_D, _C, _E), _B is _E+1),
%% M = 14.

plus_maker2(Future, F) :-
    F = [N, M] >> ((N = 0, !, M = 5);
                   (N1 is N - 1,
                    call({Future, M, M1}/[Arg] >> (call(Future, Future, F1),
                                                   call(F1, Arg, M1)), % M1 doesn't "exist" yet? But must be same variable in calculation of M below.
                         N1),
                    M is M1 + 1)).

%% y_combinator:  ?- plus_maker2(plus_maker2, P), call(P, 9, M).
%% P = [_A, _B]>>(_A=0, !, _B=5;_C is _A-1, call({plus_maker2, _B, _D}/[_E]>>(call(plus_maker2, plus_maker2, _F), call(_F, _E, _D)), _C), _B is _D+1),
%% M = 14.

plus_maker3(Future, F) :-
    call([Recur, G] >> (G = {Recur}/[N, M] >> ((N = 0, !, M = 5);
                                               (N1 is N - 1,
                                                call(Recur, N1, M1),
                                                M is M1 + 1))),
         {Future}/[N, M] >> (call(Future, Future, F1), call(F1, N, M)),
         F).

%% y_combinator:  ?- plus_maker3(plus_maker3, P), call(P, 9, M).
%% P = {{plus_maker3}/[_A, _B]>>(call(plus_maker3, plus_maker3, _C), call(_C, _A, _B))}/[_D, _E]>>(_D=0, !, _E=5;_F is _D-1, call({plus_maker3}/[_A, _B]>>(call(plus_maker3, plus_maker3, _C), call(_C, _A, _B)), _F, _G), _E is _G+1),
%% M = 14.

plus_maker4(Future, F) :-
    plus_m({Future}/[N, M] >> (call(Future, Future, F1), call(F1, N, M)), F).

plus_m(Recur, F) :-
    F = {Recur}/[N, M] >> ((N = 0, !, M = 5);
                           (N1 is N - 1,
                            call(Recur, N1, M1),
                            M is M1 + 1)).

%% y_combinator:  ?- plus_maker4(plus_maker4, P), call(P, 9, M).
%% P = {{plus_maker4}/[_A, _B]>>(call(plus_maker4, plus_maker4, _C), call(_C, _A, _B))}/[_D, _E]>>(_D=0, !, _E=5;_F is _D-1, call({plus_maker4}/[_A, _B]>>(call(plus_maker4, plus_maker4, _C), call(_C, _A, _B)), _F, _G), _E is _G+1),
%% M = 14.

plus_maker5(F) :-
    call([Future, G] >> (plus_m({Future}/[N, M] >> (call(Future, Future, F1), call(F1, N, M)), G)),
         [Future, G] >> (plus_m({Future}/[N, M] >> (call(Future, Future, F1), call(F1, N, M)), G)),
         F).

%% y_combinator:  ?- plus_maker5(P), call(P, 9, M).
%% P = {{[_A, _B]>>plus_m({_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call([_A, _B]>>plus_m({_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), [_A, _B]>>plus_m({_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G))}/[_I, _J]>>(_I=0, !, _J=5;_K is _I-1, call({[_A, _B]>>plus_m({_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call([_A, _B]>>plus_m({_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), [_A, _B]>>plus_m({_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G)), _K, _L), _J is _L+1),
%% M = 14.


%% y_combinator:  ?- y2(plus_m, P), call(P, 9, M).
%% P = {{{plus_m}/[_A, _B]>>call(plus_m, {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({plus_m}/[_A, _B]>>call(plus_m, {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {plus_m}/[_A, _B]>>call(plus_m, {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G))}/[_I, _J]>>(_I=0, !, _J=5;_K is _I-1, call({{plus_m}/[_A, _B]>>call(plus_m, {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({plus_m}/[_A, _B]>>call(plus_m, {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {plus_m}/[_A, _B]>>call(plus_m, {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G)), _K, _L), _J is _L+1),
%% M = 14.

%% y_combinator:  ?- y2([Recur, F] >> (F = {Recur}/[N, M] >> ((N = 0, !, M = 5); (N1 is N - 1, call(Recur, N1, M1), M is M1 + 1))), P), call(P, 9, M).
%% M = 14,
%% P = {{{[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G))}/[_I, _J]>>(_I=0, !, _J=5;_K is _I-1, call({{[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G)), _K, _L), _J is _L+1).

y0(M, F) :-
    call({M}/[Future, G] >> (call(M, {Future}/[In] >> (call(Future, Future, F1), call(F1, In)), G)),
         {M}/[Future, G] >> (call(M, {Future}/[In] >> (call(Future, Future, F1), call(F1, In)), G)),
         F).
    

y(M, F) :-
    call({M}/[Future, G] >> (call(M, {Future}/[In, Out] >> (call(Future, Future, F1), call(F1, In, Out)), G)),
         {M}/[Future, G] >> (call(M, {Future}/[In, Out] >> (call(Future, Future, F1), call(F1, In, Out)), G)),
         F).

%%%
%%%    Plus 5
%%%    
%% y_combinator:  ?- y([Recur, F] >> (F = {Recur}/[N, M] >> ((N = 0, !, M = 5); (N1 is N - 1, call(Recur, N1, M1), M is M1 + 1))), P), call(P, 9, M).
%% M = 14,
%% P = {{{[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G))}/[_I, _J]>>(_I=0, !, _J=5;_K is _I-1, call({{[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {[Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 14]>>(N=0, !, 14=5;N1 is N-1, call(Recur, N1, M1), 14 is M1+1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G)), _K, _L), _J is _L+1).

%%%
%%%    Factorial
%%%    
%% y_combinator:  ?- y([Recur, F] >> (F = {Recur}/[N, Fact] >> ((N = 0, !, Fact is 1); (N1 is N - 1, call(Recur, N1, Fact1), Fact is N * Fact1))), P), call(P, 6, Fact).
%% Fact = 720,
%% P = {{{[Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({[Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {[Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G))}/[_I, _J]>>(_I=0, !, _J is 1;_K is _I-1, call({{[Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B)}/[_F, _G]>>(call({[Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), {[Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1))}/[_A, _B]>>call([Recur, F]>>(F={Recur}/[N, 720]>>(N=0, !, 720 is 1;N1 is N-1, call(Recur, N1, Fact1), 720 is N*Fact1)), {_A}/[_C, _D]>>(call(_A, _A, _E), call(_E, _C, _D)), _B), _H), call(_H, _F, _G)), _K, _L), _J is _I*_L).

%%%
%%%    Length
%%%
%% y_combinator:  ?- y([Recur, F] >> (F = {Recur}/[L, N] >> ((L = [], !, N = 0); (L = [_|T], call(Recur, T, N1), N is N1 + 1))), P), call(P, [a, b, c], N).
%% N = 3,
%% P = {{{[Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1))}/[_B, _C]>>call([Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1)), {_B}/[_D, _E]>>(call(_B, _B, _F), call(_F, _D, _E)), _C)}/[_G, _H]>>(call({[Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1))}/[_B, _C]>>call([Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1)), {_B}/[_D, _E]>>(call(_B, _B, _F), call(_F, _D, _E)), _C), {[Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1))}/[_B, _C]>>call([Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1)), {_B}/[_D, _E]>>(call(_B, _B, _F), call(_F, _D, _E)), _C), _I), call(_I, _G, _H))}/[_J, _K]>>(_J=[], !, _K=0;_J=[_|_L], call({{[Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1))}/[_B, _C]>>call([Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1)), {_B}/[_D, _E]>>(call(_B, _B, _F), call(_F, _D, _E)), _C)}/[_G, _H]>>(call({[Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1))}/[_B, _C]>>call([Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1)), {_B}/[_D, _E]>>(call(_B, _B, _F), call(_F, _D, _E)), _C), {[Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1))}/[_B, _C]>>call([Recur, F]>>(F={Recur}/[L, 3]>>(L=[], !, 3=0;L=[_A|T], call(Recur, T, N1), 3 is N1+1)), {_B}/[_D, _E]>>(call(_B, _B, _F), call(_F, _D, _E)), _C), _I), call(_I, _G, _H)), _L, _M), _K is _M+1).

%%%
%%%    Graham's version
%%%
factorial_g(N0, Factorial) :- % Why is this `N' captured?!
    call([F, G] >> (G = {F}/[N, Fact] >> call(F, F, N, Fact)),
         [F, N, Fact] >> ((N = 0, !, Fact = 1);
                          (writeln(F), N1 is N - 1,
                           call(F, F, N1, Fact1),
                           Fact is Fact1 * N)),
         R),
    call(R, N0, Factorial).
