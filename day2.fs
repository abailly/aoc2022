include common.fs

1 constant rock
2 constant paper
3 constant scissors

0 constant lose
3 constant draw
6 constant win

\ identify the type of play for a given char
: play ( c -- n )
  case
    [char] A of rock endof
    [char] B of paper endof
    [char] C of scissors endof
    [char] X of rock endof
    [char] Y of paper endof
    [char] Z of scissors endof
  endcase ;

\ outcome of a pair of plays for player 2 (me)
\ c1 and c2 must be one of rock, paper, scissors
: outcome ( c1 c2 -- n )
  -
  case
    -1 of win endof
    1 of lose endof
    0 of draw endof
    -2 of lose endof
    2 of win endof
  endcase
;

: scan-file ( -- )
  0 \ current score value
  begin
    read-one-line
  while

  repeat
;

s" ./day2/test.txt" open-input
scan-file
2drop .
bye
