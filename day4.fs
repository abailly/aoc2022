#! /usr/bin/env gforth --

require string.fs
include common.fs

variable shifted

: shift ( x1 ... xn n -- xn x1 .. xn-1 )
  dup shifted !
  0
  do
    shifted @
    roll
  loop
;

: compute-interval ( addr u -- lb ub )
  [char] - $split
  s>number? 2drop
  -rot
  s>number? 2drop
  swap
;

\ given a string like
\ "xxxx-yyyy,zzzz-tttt"
\ return the four numbers representing the 2 intervals
: compute-intervals ( addr u -- lb1 ub1 lb2 ub2 )
  [char] , $split
  compute-interval
  2swap
  compute-interval
;

\ is the second range contains in the first?
: contains (  lb1 ub1 lb2 ub2 -- flag )
  rot \ lb1 lb2 ub2 ub1
  <= -rot <= and
;

: 4dup
  2tuck 2swap 2tuck 2swap
;

\ tells whether one interval includes the other
: includes ( lb1 ub1 lb2 ub2 -- flag )
  4dup \ duplicate ranges
  contains
  4 shift
  contains
  or
;

: scan-file ( -- )
  0 \ current score value
  begin
    read-one-line
  while
    \ compute intervals
    line-buffer swap compute-intervals
    \ if one includes the other, increase count
    includes
    if 1+ then
  repeat
;

next-arg open-input \ read file to open from command-line
scan-file
drop .
bye
