#!/usr/bin/swipl
%%  I'm trying to write some -*- Mode: Prolog -*- here!
%   Name:               ch02.pl
%
%   Started:            Fri Jul  3 16:06:48 2026
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

:- module(ch02, []).
:- ['/home/slytobias/Thelio/modified/prolog/modules/core'].

%make_rat(N, D, rational(N, D)).
%% make_rat(N, D, rational(N1, D1)) :-
%%     G is gcd(N, D),
%%     N1 is N / G,
%%     D1 is D / G.
make_rat(N, D, R) :-
    D < 0,
    !,
    N1 is -N,
    D1 is -D,
    make_rat(N1, D1, R).
make_rat(N, D, rational(N1, D1)) :-
    G is gcd(N, D),
    N1 is N / G,
    D1 is D / G.
numer(rational(N, _), N).
denom(rational(_, D), D).

%%%
%%%    So much for abstraction...
%%%    
%% add_rat(rational(N0, D0), rational(N1, D1), Sum) :-
%%     N is N0 * D1 + N1 * D0,
%%     D is D0 * D1,
%%     make_rat(N, D, Sum).

%% sub_rat(rational(N0, D0), rational(N1, D1), Diff) :-
%%     N is N0 * D1 - N1 * D0,
%%     D is D0 * D1,
%%     make_rat(N, D, Diff).

%% mul_rat(rational(N0, D0), rational(N1, D1), Prod) :-
%%     N is N0 * N1,
%%     D is D0 * D1,
%%     make_rat(N, D, Prod).

%% div_rat(rational(N0, D0), rational(N1, D1), Quot) :-
%%     N is N0 * D1,
%%     D is D0 * N1,
%%     make_rat(N, D, Quot).

%% equal_rat(rational(N0, D0), rational(N1, D1)) :-
%%     N0 * D1 =:= N1 * D0.

add_rat(X, Y, Sum) :-
    numer(X, N0),
    denom(X, D0),
    numer(Y, N1),
    denom(Y, D1),
    N is N0 * D1 + N1 * D0,
    D is D0 * D1,
    make_rat(N, D, Sum).

sub_rat(X, Y, Diff) :-
    numer(X, N0),
    denom(X, D0),
    numer(Y, N1),
    denom(Y, D1),
    N is N0 * D1 - N1 * D0,
    D is D0 * D1,
    make_rat(N, D, Diff).

mul_rat(X, Y, Prod) :-
    numer(X, N0),
    denom(X, D0),
    numer(Y, N1),
    denom(Y, D1),
    N is N0 * N1,
    D is D0 * D1,
    make_rat(N, D, Prod).

div_rat(X, Y, Quot) :-
    numer(X, N0),
    denom(X, D0),
    numer(Y, N1),
    denom(Y, D1),
    N is N0 * D1,
    D is D0 * N1,
    make_rat(N, D, Quot).

equal_rat(X, Y) :-
    numer(X, N0),
    denom(X, D0),
    numer(Y, N1),
    denom(Y, D1),
    N0 * D1 =:= N1 * D0.

%%%
%%%    2.2
%%%
make_point(X, Y, point(X, Y)).
x_point(point(X, _), X).
y_point(point(_, Y), Y).

print_point(P) :-
    x_point(P, X),
    y_point(P, Y),
    write('('),
    write(X),
    write(','),
    write(Y),
    write(')').

coincident(P0, P1) :-
    x_point(P0, X0),
    y_point(P0, Y0),
    x_point(P1, X1),
    y_point(P1, Y1),
    X0 =:= X1,
    Y0 =:= Y1.

distinct(P0, P1) :-
    \+ coincident(P0, P1).

%%%%
%%%%    This circumvents the abstraction barrier!
%%%%    
%distance(point(X0, Y0), point(X1, Y1), D) :-
distance(P0, P1, D) :-
    x_point(P0, X0),
    y_point(P0, Y0),
    x_point(P1, X1),
    y_point(P1, Y1),
    D is sqrt((X0 - X1) ** 2 + (Y0 - Y1) ** 2).

make_segment(Start, End, segment(Start, End)).
start_segment(segment(Start, _), Start).
end_segment(segment(_, End), End).

%print_segment(segment(Start, End)) :-
print_segment(S) :-
    start_segment(S, Start),
    end_segment(S, End),
    write('('),
    print_point(Start),
    write(' -> '),
    print_point(End),
    write(')').

same_segments(S0, S1) :-
    start_segment(S0, Start0),
    end_segment(S0, End0),
    start_segment(S1, Start1),
    end_segment(S1, End1),
    coincident(Start0, Start1),
    !,
    coincident(End0, End1).
same_segments(S0, S1) :-
    start_segment(S0, Start0),
    end_segment(S0, End0),
    start_segment(S1, Start1),
    end_segment(S1, End1),
    coincident(Start0, End1),
    !,
    coincident(End0, Start1).
    
distinct_segments(S0, S1) :-
    \+ same_segments(S0, S1).

test_same_segments([X0, Y0], [X1, Y1], [X2, Y2], [X3, Y3]) :-
    make_point(X0, Y0, P0),
    make_point(X1, Y1, P1),
    make_segment(P0, P1, S0),
    make_point(X2, Y2, P2),
    make_point(X3, Y3, P3),
    make_segment(P2, P3, S1),
    same_segments(S0, S1).

%% ch02:  ?- test_same_segments([0, 4], [1, 8], [0, 4], [1, 8]).
%% true.

%% ch02:  ?- test_same_segments([1, 2], [7, 9], [7, 9], [1, 2]).
%% true.

%% ch02:  ?- test_same_segments([1, 2], [7.0, 9], [7, 9.0], [1, 2]).
%% true.

%% ch02:  ?- test_same_segments([1, 2], [7, 9], [6, 9], [1, 2]).
%% false.

%length_segment(segment(S, E), L) :-
length_segment(S, L) :-
    start_segment(S, Start),
    end_segment(S, End),
    distance(Start, End, L).

destructure_segment(S, Start, X0, Y0, End, X1, Y1) :-
    start_segment(S, Start),
    end_segment(S, End),
    x_point(Start, X0),
    y_point(Start, Y0),
    x_point(End, X1),
    y_point(End, Y1).

average(X, Y, Z) :-
    Z is (X + Y) / 2.

%midpoint_segment(segment(S, E), M) :-
midpoint_segment(S, M) :-
    destructure_segment(S, _, X0, Y0, _, X1, Y1),
    average(X0, X1, X),
    average(Y0, Y1, Y),
    make_point(X, Y, M).

horizontal(S) :-
    destructure_segment(S, _, _, Y0, _, _, Y1),
    Y0 =:= Y1.

vertical(S) :-
    destructure_segment(S, _, X0, _, _, X1, _),
    X0 =:= X1.

slope(S, 0) :- horizontal(S), !.
slope(S, infinity) :- vertical(S), !.
slope(S, M) :-
    destructure_segment(S, _, X0, Y0, _, X1, Y1),
    M is (Y1 - Y0) / (X1 - X0).

parallel(S0, S1) :- horizontal(S0), !, horizontal(S1).
parallel(S0, S1) :- vertical(S0), !, vertical(S1).
parallel(_, S1) :- vertical(S1), !, fail.
parallel(S0, S1) :-
    slope(S0, M1),
    slope(S1, M2),
    approximately_equal(M1, M2).

perpendicular(S0, S1) :- horizontal(S0), !, vertical(S1).
perpendicular(S0, S1) :- vertical(S0), !, horizontal(S1).
perpendicular(_, S1) :- vertical(S1), !, fail.
perpendicular(S0, S1) :-
    slope(S0, M1),
    slope(S1, M2),
    X is M1 * M2,
    approximately_equal(X, -1).

%% ch02:  ?- make_point(0, 0, P1), make_point(5, 0, P2), make_segment(P1, P2, S0), make_point(3, 3, P3), make_point(8, 3, P4), make_segment(P3, P4, S1), parallel(S0, S1).
%% P1 = point(0, 0),
%% P2 = point(5, 0),
%% S0 = segment(point(0, 0), point(5, 0)),
%% P3 = point(3, 3),
%% P4 = point(8, 3),
%% S1 = segment(point(3, 3), point(8, 3)).

%% ch02:  ?- make_point(0, 0, P1), make_point(1, 2, P2), make_segment(P1, P2, S0), make_point(0, 0, P3), make_point(1, 1/2, P4), make_segment(P3, P4, S1), perpendicular(S0, S1).
%% false.

%% ch02:  ?- make_point(2, 2, P1), make_point(3, 3, P2), make_segment(P1, P2, S0), make_point(-2, 2, P3), make_point(3, -3, P4), make_segment(P3, P4, S1), perpendicular(S0, S1).
%% P1 = point(2, 2),
%% P2 = point(3, 3),
%% S0 = segment(point(2, 2), point(3, 3)),
%% P3 = point(-2, 2),
%% P4 = point(3, -3),
%% S1 = segment(point(-2, 2), point(3, -3)).

%%%
%%%    This is of secondary importance now. No longer used to validate.
%%%    
intersection(S0, S1, P) :-
    parallel(S0, S1), !,
    shared_endpoint(S0, S1, P).
intersection(S0, S1, P) :-
    vertical(S1),
    !,
    destructure_segment(S0, _, X0, Y0, _, X1, _),
    destructure_segment(S1, _, X2, Y2, _, _, Y3),
    ordered(X0, X2, X1),
    !,
    slope(S0, M),
    B is Y0 - M * X0,
    Y is M * X2 + B,
    ordered(Y2, Y, Y3),
    !,
    make_point(X2, Y, P).
intersection(S0, S1, P) :-
    vertical(S0),
    !,
    intersection(S1, S0, P).
intersection(S0, S1, P) :-
    destructure_segment(S0, _, X0, Y0, _, X2, _),
    destructure_segment(S1, _, X1, Y1, _, _, _),
    slope(S0, M0),
    slope(S1, M1),
    B0 is Y0 - M0 * X0,
    B1 is Y1 - M1 * X1,
    X is (B1 - B0) / (M0 - M1),
    Y is M0 * X + B0,
    ordered(X0, X, X2),
    !,
    make_point(X, Y, P).

ordered(A, B, C) :- A =< B, B =< C.
ordered(A, B, C) :- A >= B, B >= C.

test_intersection([X0, Y0], [X1, Y1], [X2, Y2], [X3, Y3], P) :-
    make_point(X0, Y0, P0),
    make_point(X1, Y1, P1),
    make_segment(P0, P1, S0),
    make_point(X2, Y2, P2),
    make_point(X3, Y3, P3),
    make_segment(P2, P3, S1),
    intersection(S0, S1, P).

%% ch02:  ?- test_intersection([-4, 0], [9, 0], [2, -3], [2, 5], P).
%% P = point(2, 0).

%% ch02:  ?- test_intersection([2, -3], [2, 5], [-4, 0], [9, 0], P).
%% P = point(2, 0).

%% ch02:  ?- test_intersection([-4, 0], [9, 0], [2, 3], [2, 5], P).
%% false.

%% ch02:  ?- test_intersection([2, 3], [2, 5], [-4, 0], [9, 0], P).
%% false.

%% ch02:  ?- test_intersection([2, -3], [2, 5], [0, 0], [6, 6], P).
%% P = point(2, 2).

%% ch02:  ?- test_intersection([0, 0], [6, 6], [2, -3], [2, 5], P).
%% P = point(2, 2).

%% ch02:  ?- test_intersection([2, -3], [2, 5], [0, 0], [1, 1], P).
%% false.

%%%
%%%    Does not support int/float equality
%%%    
%% shared_endpoint(S0, S1, P) :-
%%     start_segment(S0, P),
%%     start_segment(S1, P),
%%     !,
%%     end_segment(S0, Q),
%%     end_segment(S1, R),
%%     Q \= R.
%% shared_endpoint(S0, S1, P) :-
%%     start_segment(S0, P),
%%     end_segment(S1, P),
%%     !,
%%     end_segment(S0, Q),
%%     start_segment(S1, R),
%%     Q \= R.
%% shared_endpoint(S0, S1, P) :-
%%     end_segment(S0, P),
%%     start_segment(S1, P),
%%     !,
%%     start_segment(S0, Q),
%%     end_segment(S1, R),
%%     Q \= R.
%% shared_endpoint(S0, S1, P) :-
%%     end_segment(S0, P),
%%     end_segment(S1, P),
%%     start_segment(S0, Q),
%%     start_segment(S1, R),
%%     Q \= R.

%% shared_endpoint(S0, S1, P) :-
%%     start_segment(S0, Start1),
%%     end_segment(S0, End1),
%%     start_segment(S1, Start2),
%%     end_segment(S1, End2),
%%     shared(Start1, End1, Start2, End2, P).

%% shared(A, B, A, C, A) :- B \= C, !.
%% shared(A, B, C, A, A) :- B \= C, !.
%% shared(B, A, A, C, A) :- B \= C, !.
%% shared(B, A, C, A, A) :- B \= C, !.

shared_endpoint(S0, S1, P) :-
    destructure_segment(S0, Start0, _, _, End0, _, _),
    destructure_segment(S1, Start1, _, _, End1, _, _),
    screen(Start0, End0, Start1, End1, P).

screen(Start0, End0, Start1, End1, P) :- shared(Start0, Start1, End0, End1, P), !.
screen(Start0, End0, Start1, End1, P) :- shared(Start0, End1, End0, Start1, P), !.
screen(Start0, End0, Start1, End1, P) :- shared(End0, Start1, Start0, End1, P), !.
screen(Start0, End0, Start1, End1, P) :- shared(End0, End1, Start0, Start1, P).

shared(P0, P1, P2, P3, P0) :-
    coincident(P0, P1),
    distinct(P2, P3).

%% ch02:  ?- make_point(-1, -1, P1), make_point(1, 1, P2), make_segment(P1, P2, S0), make_point(-1, 1, P3), make_point(1, -1, P4), make_segment(P3, P4, S1), intersection(S0, S1, P).
%% P1 = point(-1, -1),
%% P2 = point(1, 1),
%% S0 = segment(point(-1, -1), point(1, 1)),
%% P3 = point(-1, 1),
%% P4 = point(1, -1),
%% S1 = segment(point(-1, 1), point(1, -1)),
%% P = point(0, 0).

%% ch02:  ?- make_point(2, 2, P1), make_point(1, 1, P2), make_segment(P1, P2, S0), make_point(-1, 1, P3), make_point(1, -1, P4), make_segment(P3, P4, S1), intersection(S0, S1, P).
%% false.

%% ch02:  ?- make_point(0, 0, P1), make_point(1, 3, P2), make_segment(P1, P2, S0), make_point(2, 0, P3), make_point(1, 3, P4), make_segment(P3, P4, S1), intersection(S0, S1, P).
%% P1 = point(0, 0),
%% P2 = P4, P4 = P, P = point(1, 3),
%% S0 = segment(point(0, 0), point(1, 3)),
%% P3 = point(2, 0),
%% S1 = segment(point(2, 0), point(1, 3)).

%% ch02:  ?- make_point(0, 0, P1), make_point(1, 3, P2), make_segment(P1, P2, S0), make_point(1, 0, P3), make_point(2, 3, P4), make_segment(P3, P4, S1), intersection(S0, S1, P).
%% false.

%% ch02:  ?- make_point(0, 0, P1), make_point(1, 3, P2), make_segment(P1, P2, S0), make_point(1, 3, P3), make_point(3, 9, P4), make_segment(P3, P4, S1), intersection(S0, S1, P).
%% P1 = point(0, 0),
%% P2 = P3, P3 = P, P = point(1, 3),
%% S0 = segment(point(0, 0), point(1, 3)),
%% P4 = point(3, 9),
%% S1 = segment(point(1, 3), point(3, 9)).

%% ch02:  ?- make_point(0, 0, P1), make_point(1, 3, P2), make_segment(P1, P2, S0), make_point(1, 3, P3), make_point(0, 0, P4), make_segment(P3, P4, S1), intersection(S0, S1, P).
%% false.

%% joined(S0, S1) :-
%%     intersection(S0, S1, P),
%%     start_segment(S0, P),
%%     end_segment(S1, P).

make_rectangle_segments(A, B, C, D, R) :-
    validate_segments(A, B, C, D, R).

validate_segments(S0, S1, S2, S3, R) :-
    parallel(S0, S1),
    double_check_segments(S0, S1, S2, S3, R).
validate_segments(S0, S1, S2, S3, R) :-
    parallel(S0, S2),
    double_check_segments(S0, S2, S1, S3, R).
validate_segments(S0, S1, S2, S3, R) :-
    parallel(S0, S3),
    double_check_segments(S0, S3, S1, S2, R).

%% shared_endpoints([], _).
%% shared_endpoints([A|As], Bs) :-
%%     check_shared(A, Bs),
%%     shared_endpoints(As, Bs).

shared_endpoints([]).
shared_endpoints([[X,Y]|Pairs]) :-
    shared_endpoint(X, Y, _),
    shared_endpoints(Pairs).

%% check_shared(_, []).
%% check_shared(A, [B|Bs]) :-
%%     shared_endpoint(A, B, _),
%%     check_shared(A, Bs).

distinct_sides([]).
distinct_sides([S|Ss]) :-
    check_distinct(S, Ss),
    distinct_sides(Ss).

check_distinct(_, []).
check_distinct(Segment, [S|Ss]) :-
    distinct_segments(Segment, S),
    check_distinct(Segment, Ss).

%% double_check_segments(Top, Bottom, Left, Right, rectangle(Top, Bottom, Left, Right)) :-
%%     parallel(Left, Right),
%%     perpendicular(Top, Left),
%%     shared_endpoints([Top, Bottom], [Left, Right]),
%%     distinct_sides([Top, Bottom, Left, Right]).

double_check_segments(Top, Bottom, Left, Right, rectangle(Top, Bottom, Left, Right)) :-
    parallel(Left, Right),
    perpendicular(Top, Left),
    cartesian([Top, Bottom], [Left, Right], Pairs),
    shared_endpoints(Pairs),
    distinct_sides([Top, Bottom, Left, Right]).

test_rectangle_segments([X0, Y0], [X1, Y1], [X2, Y2], [X3, Y3], [X4, Y4], [X5, Y5], [X6, Y6], [X7, Y7], R) :-
    make_point(X0, Y0, P0),
    make_point(X1, Y1, P1),
    make_segment(P0, P1, S0),
    make_point(X2, Y2, P2),
    make_point(X3, Y3, P3),
    make_segment(P2, P3, S1),
    make_point(X4, Y4, P4),
    make_point(X5, Y5, P5),
    make_segment(P4, P5, S2),
    make_point(X6, Y6, P6),
    make_point(X7, Y7, P7),
    make_segment(P6, P7, S3),
    make_rectangle_segments(S0, S1, S2, S3, R).

%% ch02:  ?- test_rectangle_segments([0, 0], [5, 0], [0, 7], [5, 7], [0, 0], [0, 7], [5, 7], [5, 0], R).
%% R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))) ;
%% false.

%% ch02:  ?- test_rectangle_segments([0, -1], [1, 0], [0, 1], [-1, 0], [1, 0], [0, 1], [-1, 0], [0, -1], R).
%% R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))) ;
%% false.

%% ch02:  ?- test_rectangle_segments([0, 0], [5, 0], [0, 0], [0, 7], [0, 0], [5, 0], [0, 0], [0, 7], R).
%% false.

%% ch02:  ?- test_rectangle_segments([0, 0], [4, 0], [4, 0], [5, 2], [5, 2], [1, 2], [1, 2], [0, 0], R).
%% false.

rectangle_top(rectangle(Top, _, _, _), Top).
rectangle_bottom(rectangle(_, Bottom, _, _), Bottom).
rectangle_left(rectangle(_, _, Left, _), Left).
rectangle_right(rectangle(_, _, _, Right), Right).
    
rectangle_length(R, L) :-
    rectangle_top(R, T),
    start_segment(T, S),
    end_segment(T, E),
    distance(S, E, L).

rectangle_width(R, W) :-
    rectangle_left(R, L),
    start_segment(L, S),
    end_segment(L, E),
    distance(S, E, W).

area(R, A) :-
    rectangle_length(R, L),
    rectangle_width(R, W),
    A is L * W.

perimeter(R, P) :-
    rectangle_length(R, L),
    rectangle_width(R, W),
    P is 2 * L + 2 * W.

%% ch02:  ?- R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))), rectangle_length(R, L).
%% R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))),
%% L = 5.0.

%% ch02:  ?- R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))), rectangle_width(R, W).
%% R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))),
%% W = 7.0.

%% ch02:  ?- R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))), area(R, A).
%% R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))),
%% A = 35.0.

%% ch02:  ?- R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))), perimeter(R, P).
%% R = rectangle(segment(point(0, 0), point(5, 0)), segment(point(0, 7), point(5, 7)), segment(point(0, 0), point(0, 7)), segment(point(5, 7), point(5, 0))),
%% P = 24.0.


%% ch02:  ?- R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))), rectangle_length(R, L).
%% R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))),
%% L = 1.4142135623730951.

%% ch02:  ?- R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))), rectangle_width(R, W).
%% R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))),
%% W = 1.4142135623730951.

%% ch02:  ?- R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))), area(R, A).
%% R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))),
%% A = 2.0000000000000004.

%% ch02:  ?- R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))), perimeter(R, P).
%% R = rectangle(segment(point(0, -1), point(1, 0)), segment(point(0, 1), point(-1, 0)), segment(point(1, 0), point(0, 1)), segment(point(-1, 0), point(0, -1))),
%% P = 5.656854249492381.




make_rectangle_points(A, B, C, D, R) :-
    validate_points(A, B, C, D, R).

validate_points(P0, P1, P2, P3, R) :-
    make_segment(P0, P2, S02),
    make_segment(P0, P3, S03),
    perpendicular(S02, S03), !,
    double_check_points(P0, P1, P2, P3, R).
validate_points(P0, P1, P2, P3, R) :-
    make_segment(P0, P1, S01),
    make_segment(P0, P3, S03),
    perpendicular(S01, S03), !,
    double_check_points(P0, P2, P1, P3, R).
validate_points(P0, P1, P2, P3, R) :-
    make_segment(P0, P1, S01),
    make_segment(P0, P2, S02),
    perpendicular(S01, S02), !,
    double_check_points(P0, P3, P1, P2, R).

double_check_points(P0, P1, Q0, Q1, rectangle(diagonal(P0, P1), diagonal(Q0, Q1))) :-
    make_segment(P0, Q1, S0),
    make_segment(Q0, P1, S1),
    make_segment(P0, Q0, S2),
    make_segment(Q1, P1, S3),
    distance(P0, P1, D),
    distance(Q0, Q1, D),
    parallel(S0, S1),
    parallel(S2, S3).

%% ch02:  ?- make_point(0, 0, P0), make_point(4, 0, P1), make_point(4, 2, P2), make_point(0, 2, P3), make_rectangle_points(P0, P1, P2, P3, R).
%% P0 = point(0, 0),
%% P1 = point(4, 0),
%% P2 = point(4, 2),
%% P3 = point(0, 2),
%% R = rectangle(diagonal(point(0, 0), point(4, 2)), diagonal(point(4, 0), point(0, 2))).

%%%
%%%    These can kind of coexist peacefully with the earlier representation??
%%%    Same arity, but only one of each will match a particular rectangle implementation.
%%%    
rectangle_length(rectangle(diagonal(P0, _), diagonal(_, Q1)), L) :-
    distance(P0, Q1, L).

rectangle_width(rectangle(diagonal(P0, _), diagonal(Q0, _)), L) :-
    distance(P0, Q0, L).

%% ch02:  ?- make_point(0, 0, P0), make_point(4, 0, P1), make_point(4, 2, P2), make_point(0, 2, P3), make_rectangle_points(P0, P1, P2, P3, R), rectangle_length(R, L).
%% P0 = point(0, 0),
%% P1 = point(4, 0),
%% P2 = point(4, 2),
%% P3 = point(0, 2),
%% R = rectangle(diagonal(point(0, 0), point(4, 2)), diagonal(point(4, 0), point(0, 2))),
%% L = 2.0.

%% ch02:  ?- make_point(0, 0, P0), make_point(4, 0, P1), make_point(4, 2, P2), make_point(0, 2, P3), make_rectangle_points(P0, P1, P2, P3, R), rectangle_width(R, W).
%% P0 = point(0, 0),
%% P1 = point(4, 0),
%% P2 = point(4, 2),
%% P3 = point(0, 2),
%% R = rectangle(diagonal(point(0, 0), point(4, 2)), diagonal(point(4, 0), point(0, 2))),
%% W = 4.0.

%% ch02:  ?- make_point(0, 0, P0), make_point(4, 0, P1), make_point(4, 2, P2), make_point(0, 2, P3), make_rectangle_points(P0, P1, P2, P3, R), area(R, A).
%% P0 = point(0, 0),
%% P1 = point(4, 0),
%% P2 = point(4, 2),
%% P3 = point(0, 2),
%% R = rectangle(diagonal(point(0, 0), point(4, 2)), diagonal(point(4, 0), point(0, 2))),
%% A = 8.0.

%% ch02:  ?- make_point(0, 0, P0), make_point(4, 0, P1), make_point(4, 2, P2), make_point(0, 2, P3), make_rectangle_points(P0, P1, P2, P3, R), perimeter(R, A).
%% P0 = point(0, 0),
%% P1 = point(4, 0),
%% P2 = point(4, 2),
%% P3 = point(0, 2),
%% R = rectangle(diagonal(point(0, 0), point(4, 2)), diagonal(point(4, 0), point(0, 2))),
%% A = 12.0.

%%%
%%%    2.4
%%%
cons(H, T, cons(H, T)).
car(cons(H, _), H).
cdr(cons(_, T), T).

%% ch02:  ?- cons(1, 2, C).
%% C = cons(1, 2).

%% ch02:  ?- cons(1, 2, C), car(C, H).
%% C = cons(1, 2),
%% H = 1.

%% ch02:  ?- cons(1, 2, C), cdr(C, T).
%% C = cons(1, 2),
%% T = 2.

cons1(X, Y, {X, Y}/[M, Z] >> ((M = 0, !, Z = X); (M = 1, !, Z = Y))).
car1(Z, X) :- call(Z, 0, X).
cdr1(Z, Y) :- call(Z, 1, Y).

%% ch02:  ?- cons1(1, 2, C).
%% C = {1, 2}/[_A, _B]>>(_A=0, !, _B=1;_A=1, !, _B=2).

%% ch02:  ?- cons1(1, 2, C), car1(C, H).
%% C = {1, 2}/[_A, _B]>>(_A=0, !, _B=1;_A=1, !, _B=2),
%% H = 1.

%% ch02:  ?- cons1(1, 2, C), cdr1(C, T).
%% C = {1, 2}/[_A, _B]>>(_A=0, !, _B=1;_A=1, !, _B=2),
%% T = 2.

%%%    Church encoding:
%%%    pair ≡ λxy. λz. z x y
%%%    first = λp. p (λxy. x)
%%%    second = λp. p (λxy. y)
%%%
cons2(X, Y, {X, Y}/[M, Z] >> call(M, X, Y, Z)).
car2(Z, X) :- call(Z, [P, _, R] >> (R = P), X).
cdr2(Z, Y) :- call(Z, [_, Q, R] >> (R = Q), Y).

%% ch02:  ?- cons2(1, 2, C).
%% C = {1, 2}/[_A, _B]>>call(_A, 1, 2, _B).

%% ch02:  ?- cons2(1, 2, C), car2(C, H).
%% C = {1, 2}/[_A, _B]>>call(_A, 1, 2, _B),
%% H = 1.

%% ch02:  ?- cons2(1, 2, C), cdr2(C, T).
%% C = {1, 2}/[_A, _B]>>call(_A, 1, 2, _B),
%% T = 2.

%%%
%%%    2.5
%%%
carb(2).
cdrb(3).

int_cons(X, Y, Z) :-
    carb(A),
    cdrb(D),
    Z is (A ** X) * (D ** Y).

%% factor(P, D, F) :-
%%     divmod(P, D, Q, 0), !,
%%     factor(Q, D, F).
%% factor(P, _, P).

%% %% int_car(Z, X) :-
%% %%     carb(A),
%% %%     cdrb(D),
%% %%     factor(Z, D, F),
%% %%     log(F, A, L),
%% %%     X is truncate(L).

%% %% int_cdr(Z, X) :-
%% %%     carb(A),
%% %%     cdrb(D),
%% %%     factor(Z, A, F),
%% %%     log(F, D, L),
%% %%     X is truncate(L).

%% decompose(X, Y, Z, V) :-
%%     factor(X, Y, F),
%%     log(F, Z, L),
%%     V is truncate(L).

%% int_car(Z, X) :-
%%     carb(A),
%%     cdrb(D),
%%     decompose(Z, A, D, X).

%% int_cdr(Z, X) :-
%%     carb(A),
%%     cdrb(D),
%%     decompose(Z, D, A, X).

factor(P, D, N) :-
    factor(P, D, N, 0).
factor(P, D, N, Acc) :-
    divmod(P, D, Q, 0), !,
    Acc1 is Acc + 1,
    factor(Q, D, N, Acc1).
factor(_, _, N, N).

int_car(Z, X) :-
    carb(A),
    factor(Z, A, X).

int_cdr(Z, X) :-
    cdrb(D),
    factor(Z, D, X).


%%%
%%%    2.29
%%%
make_mobile(Left, Right, mobile(Left, Right)).
make_branch(Length, Structure, branch(Length, Structure)).

%%%
%%%    a.
%%%
left_branch(mobile(Left, _), Left).
right_branch(mobile(_, Right), Right).
branch_length(branch(Length, _), Length).
branch_structure(branch(_, Structure), Structure).

%%%
%%%    b.
%%%
%%%
%%%    D'oh!
%%%    
%% total_weight(mobile(L, R), W) :-
%%     !,
%%     branch_structure(L, ML),
%%     branch_structure(R, MR),
%%     total_weight(ML, WL),
%%     total_weight(MR, WR),
%%     W is WL + WR.
total_weight(M, W) :-
    left_branch(M, L),
    right_branch(M, R),
    !,
    branch_structure(L, ML),
    branch_structure(R, MR),
    total_weight(ML, WL),
    total_weight(MR, WR),
    W is WL + WR.
total_weight(W, W).

%%%
%%%    Ugh!
%%%    
%% ch02:  ?- make_branch(1, 2, B), make_mobile(B, B, M), total_weight(M, W).
%% B = branch(1, 2),
%% M = mobile(branch(1, 2), branch(1, 2)),
%% W = 4.

%% ch02:  ?- make_branch(1, 6, B1), make_branch(1, 3, B2), make_mobile(B2, B2, M1), make_branch(1, M1, B3), make_mobile(B1, B3, M2), total_weight(M2, W).
%% B1 = branch(1, 6),
%% B2 = branch(1, 3),
%% M1 = mobile(branch(1, 3), branch(1, 3)),
%% B3 = branch(1, mobile(branch(1, 3), branch(1, 3))),
%% M2 = mobile(branch(1, 6), branch(1, mobile(branch(1, 3), branch(1, 3)))),
%% W = 12.

%% ch02:  ?- make_branch(1, 24, B1), make_branch(1, 6, B2), make_branch(1, 12, B3), make_mobile(B2, B2, M1), make_branch(1, M1, B4), make_mobile(B4, B3, M2), make_branch(1, M2, B5), make_mobile(B1, B5, M3), total_weight(M3, W).
%% B1 = branch(1, 24),
%% B2 = branch(1, 6),
%% B3 = branch(1, 12),
%% M1 = mobile(branch(1, 6), branch(1, 6)),
%% B4 = branch(1, mobile(branch(1, 6), branch(1, 6))),
%% M2 = mobile(branch(1, mobile(branch(1, 6), branch(1, 6))), branch(1, 12)),
%% B5 = branch(1, mobile(branch(1, mobile(branch(1, 6), branch(1, 6))), branch(1, 12))),
%% M3 = mobile(branch(1, 24), branch(1, mobile(branch(1, mobile(branch(1, 6), branch(1, 6))), branch(1, 12)))),
%% W = 48.

%%%
%%%    c.
%%%
torque(Branch, Torque) :-
    branch_length(Branch, Length),
    branch_structure(Branch, Structure),
    total_weight(Structure, W),
    Torque is Length * W.

%% ch02:  ?- make_branch(0, 999999999, B), torque(B, T).
%% B = branch(0, 999999999),
%% T = 0.

%% ch02:  ?- make_branch(1, 3, B), make_mobile(B, B, M), left_branch(M, B1), torque(B1, T).
%% B = B1, B1 = branch(1, 3),
%% M = mobile(branch(1, 3), branch(1, 3)),
%% T = 3.

%% ch02:  ?- make_branch(1, 1, B1), make_branch(1/3, 3, B2), make_mobile(B1, B2, M), right_branch(M, R), torque(R, T).
%% B1 = branch(1, 1),
%% B2 = R, R = branch(1/3, 3),
%% M = mobile(branch(1, 1), branch(1/3, 3)),
%% T = 1.

%% ch02:  ?- make_branch(7, 1, B1), make_branch(7/3, 3, B2), make_mobile(B1, B2, M), right_branch(M, R), torque(R, T).
%% B1 = branch(7, 1),
%% B2 = R, R = branch(7/3, 3),
%% M = mobile(branch(7, 1), branch(7/3, 3)),
%% T = 7.

balanced(M) :- number(M), !.
balanced(M) :-
    left_branch(M, L),
    right_branch(M, R),
    torque(L, TL),
    torque(R, TR),
    TL =:= TR,
    branch_structure(L, SL),
    branch_structure(R, SR),
    balanced(SL),
    balanced(SR).
    
%% ch02:  ?- make_branch(1, 3, B), make_mobile(B, B, M), balanced(M).
%% B = branch(1, 3),
%% M = mobile(branch(1, 3), branch(1, 3)).

%% ch02:  ?- make_branch(1, 3, B1), make_branch(3, 1, B2), make_mobile(B1, B2, M), balanced(M).
%% B1 = branch(1, 3),
%% B2 = branch(3, 1),
%% M = mobile(branch(1, 3), branch(3, 1)).

%% ch02:  ?- make_branch(1, 9, B1), make_branch(3, 3, B2), make_mobile(B1, B2, M), balanced(M).
%% B1 = branch(1, 9),
%% B2 = branch(3, 3),
%% M = mobile(branch(1, 9), branch(3, 3)).

%% ch02:  ?- make_branch(1, 9, B1), make_branch(3, 4, B2), make_mobile(B1, B2, M), balanced(M).
%% false.

%% ch02:  ?- make_branch(1, 12, B1), make_branch(1, 2, B2), make_mobile(B2, B2, M1), make_branch(3, M1, B3), make_mobile(B1, B3, M2), balanced(M2).
%% B1 = branch(1, 12),
%% B2 = branch(1, 2),
%% M1 = mobile(branch(1, 2), branch(1, 2)),
%% B3 = branch(3, mobile(branch(1, 2), branch(1, 2))),
%% M2 = mobile(branch(1, 12), branch(3, mobile(branch(1, 2), branch(1, 2)))).

%% ch02:  ?- make_branch(1, 12, B1), make_branch(1, 1, B2), make_branch(1/3, 3, B3), make_mobile(B2, B3, M1), make_branch(3, M1, B4), make_mobile(B1, B4, M2), balanced(M2).
%% B1 = branch(1, 12),
%% B2 = branch(1, 1),
%% B3 = branch(1/3, 3),
%% M1 = mobile(branch(1, 1), branch(1/3, 3)),
%% B4 = branch(3, mobile(branch(1, 1), branch(1/3, 3))),
%% M2 = mobile(branch(1, 12), branch(3, mobile(branch(1, 1), branch(1/3, 3)))).

%% ch02:  ?- make_branch(1, 12, B1), make_branch(2, 1, B2), make_branch(2/3, 3, B3), make_mobile(B2, B3, M1), make_branch(3, M1, B4), make_mobile(B1, B4, M2), balanced(M2).
%% B1 = branch(1, 12),
%% B2 = branch(2, 1),
%% B3 = branch(2/3, 3),
%% M1 = mobile(branch(2, 1), branch(2/3, 3)),
%% B4 = branch(3, mobile(branch(2, 1), branch(2/3, 3))),
%% M2 = mobile(branch(1, 12), branch(3, mobile(branch(2, 1), branch(2/3, 3)))).

%% ch02:  ?- make_branch(1, 12, B1), make_branch(7, 1, B2), make_branch(7/3, 3, B3), make_mobile(B2, B3, M1), make_branch(3, M1, B4), make_mobile(B1, B4, M2), balanced(M2).
%% B1 = branch(1, 12),
%% B2 = branch(7, 1),
%% B3 = branch(7/3, 3),
%% M1 = mobile(branch(7, 1), branch(7/3, 3)),
%% B4 = branch(3, mobile(branch(7, 1), branch(7/3, 3))),
%% M2 = mobile(branch(1, 12), branch(3, mobile(branch(7, 1), branch(7/3, 3)))).

%% ch02:  ?- make_branch(6, 2, B1), make_branch(7, 1, B2), make_branch(7/3, 3, B3), make_mobile(B2, B3, M1), make_branch(3, M1, B4), make_mobile(B1, B4, M2), balanced(M2).
%% B1 = branch(6, 2),
%% B2 = branch(7, 1),
%% B3 = branch(7/3, 3),
%% M1 = mobile(branch(7, 1), branch(7/3, 3)),
%% B4 = branch(3, mobile(branch(7, 1), branch(7/3, 3))),
%% M2 = mobile(branch(6, 2), branch(3, mobile(branch(7, 1), branch(7/3, 3)))).

%%%
%%%    d.
%%%
%% make_mobile(Left, Right, [Left|Right]).
%% make_branch(Length, Structure, [Length|Structure]).
%% left_branch([Left|_], Left).
%% right_branch([_|Right], Right).
%% branch_length([Length|_], Length).
%% branch_structure([_|Structure], Structure).

scale_list(_, [], []) :- !.
scale_list(Factor, [X|Xs], [Y|Ys]) :-
    Y is Factor * X,
    scale_list(Factor, Xs, Ys).

scale_list1(Factor, Xs, Ys) :-
    maplist({Factor}/[X, Y] >> (Y is Factor * X), Xs, Ys).

scale_tree(_, [], []).
scale_tree(Factor, X, Y) :-
    number(X),
    !,
    Y is Factor * X.
scale_tree(Factor, [H|T], [H1|T1]) :-
    scale_tree(Factor, H, H1),
    scale_tree(Factor, T, T1).

scale_tree_sicp(Factor, In, Out) :-
    maplist({Factor}/[Sub1, Sub2] >> ((number(Sub1) , Sub2 is Factor * Sub1); scale_tree_sicp(Factor, Sub1, Sub2)), In, Out).

scale_tree_graham(Factor, X, Y) :-
    number(X),
    !,
    Y is Factor * X.
scale_tree_graham(Factor, In, Out) :-
    maplist({Factor}/[X, Y] >> (scale_tree_graham(Factor, X, Y)), In, Out).
