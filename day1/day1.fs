0 Value fd-in
0 Value fd-out
256 Constant max-line
Create line-buffer  max-line 2 + allot

0 Variable empty-lines

( open file for input )
: open-input ( addr u -- )  r/o open-file throw to fd-in ;

( create file for output )
: open-output ( addr u -- )  w/o create-file throw to fd-out ;

: scan-file ( -- )
  ( put location of next instruction on control flow stack

  control flow stack only exists during compilation mode, eg. when we
  define a word with ':
  )
  begin
    ( put addr of line-buffer, maximum line length and input fd on stack )
    line-buffer max-line fd-in
    ( read one line )
    ( c-addr u1 fileid -- u2 flag ior )
    read-line
    ( Throw an exception, popping franmes if n is is non-zero
      this means the eof has been reached
      k*x n -- k*x | i*x n )
    throw
  while
    ( duplicate 2 elemets from stack )
    2dup
    ( put line-buffer value on stack )
    line-buffer
    ( push back result stack to data stack )
    s" "
    ( compare 2 strings, putting -1 +1 or 0 depending on theire respective
    lexicographic order
      c-addr1 u1 c-addr2 u2 -- n
    )
    compare
    ( if top of stack is 0, put true flag on )
    ( x -- )
    0=
    if
      1 empty-lines +!
    endif
until
else
  drop
then
    2drop
    empty-lines
    ;

: copy-file ( -- )
  begin
    line-buffer max-line fd-in read-line throw
  while
    line-buffer swap fd-out write-line throw
  repeat ;

s" /Users/arnaud/projects/aoc2022/day1/input.txt" open-input
scan-file
.
