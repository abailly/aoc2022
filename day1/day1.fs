0 Value fd-in
0 Value fd-out
256 Constant max-line
Create line-buffer  max-line 2 + allot

( open file for input )
: open-input ( addr u -- )  r/o open-file throw to fd-in ;

( create file for output )
: open-output ( addr u -- )  w/o create-file throw to fd-out ;

: read-one-line ( -- u | throw )
  ( put addr of line-buffer, maximum line length and input fd on stack )
  line-buffer max-line fd-in
  ( read one line )
  ( c-addr u1 fileid -- u2 flag ior )
  read-line
  ( Throw an exception, popping franmes if n is is non-zero
    this means the eof has been reached
    k*x n -- k*x | i*x n )
  throw ;

: scan-file ( -- )
  0 \ current max value
  0 \ current value
  begin
    read-one-line
  while
    line-buffer swap \ put length on top for compare
    2dup \ save string and len
    s" " compare 0= \ is the string empty?
    if
      2drop \ drop saved string
      2dup \ max and current value
      s\" empty line\n" type
      .s
      <
      if swap drop 0
      else drop 0
           endif \ compare current with max and replace
    else
      s>number? 2drop + \ add to current value
      endif
  repeat
;

s" /Users/arnaud/projects/aoc2022/day1/input.txt" open-input
scan-file
2drop .
