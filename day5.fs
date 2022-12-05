( from https://www.youtube.com/watch?v=mvrE2ZGe-rs )
( read a file in RAM )

empty \ cleans up dictionary and RAM, see go.fs

variable 'src \ buffer start
variable #src \ buffer length

variable fh \ file handle

: open ( caddr u -- )
  r/o open-file throw fh ! ;

: close
  fh @ close-file throw ;

: read
  begin
    \ read 4096 bytes from fh handle at addr here
    here 4096 fh @ read-file throw
    \ allocate read number of bytes
    dup allot
    0= \ exit if end of file
  until
;

\ open file, read it fully and close it
: gulp  open read close ;

\ set 'src to the first data slot available
: start here 'src ! ;

\ set #src to be the length of data read so far
: finish here 'src @ - #src ! ;

\ read fully file from stack into RAM
: slurp ( caddr u -- )
  start gulp finish
;
