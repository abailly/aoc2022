0 Value fd-in
0 Value fd-out
256 Constant max-line
Create line-buffer  max-line 2 + allot

( open file for input )
: open-input ( addr u -- )  r/o open-file throw to fd-in ;

( create file for output )
: open-output ( addr u -- )  w/o create-file throw to fd-out ;

: scan-file ( addr u -- )
  begin
      line-buffer max-line fd-in read-line throw
  while
         >r 2dup line-buffer r> compare 0=
     until
  else
     drop
  then
  2drop ;

: copy-file ( -- )
  begin
    line-buffer max-line fd-in read-line throw
  while
    line-buffer swap fd-out write-line throw
  repeat ;

s" input.txt" open-input
s" output.txt" open-output
copy-file
