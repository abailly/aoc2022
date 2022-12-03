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
