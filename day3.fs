include common.fs

\ split the string in half, yielding two strings
\ note this only manipulates pointers and does not
\ allocate a new string
: split  ( string len -- s1 l1 s2 l2 )
  2 / 2dup dup rot + swap
;

\ store the len of string to go over
\ I tried to use the return stack but this did not work well...
variable len2

\ retrieve character at position i from chain
: char-at ( caddr n -- caddr c )
  swap tuck +
  c@
;

\ swap 2 cells 2 levels deep in the stack
: swap2 ( a b c d -- b a c d)
  2swap swap 2swap
;

\ finds the character the 2 strings have in common
\ this simply runs a double loop on the first and second string
\ until a common character is found
\ There MUST be a common character
: common-character ( s1 u1 s2 u2 -- c )
  dup len2 ! \ store u2
  rot \ s1 s2 u2 u1
  0 \ s1 s2 u2 u1 0
  \ loop on s1
  do  \ s1 s2 u2
    rot \ s2 u2 s1
    i char-at
    rot \ s2 s1 c1 u2
    swap2
    0   \ s1 s2 c1 u2 0
    do \ loop on s2
      swap i char-at
      rot swap \ s1 s2 c1 c2
      2dup \ s1 s2 c1 c2 c1 c2
      =
      if \ s1 s2 c1 c2
        drop 0 leave
        endif
        drop
     loop
  dup
  0=
  if drop nip nip leave endif
  drop
  len2 @ \ s1 s2 u2
  loop
     ;

: char-value ( c -- u )
  dup [char] a >= \ is it a lower-case char?
  if
    [char] a - 1+
  else
    [char] A - 27 +
    endif
    ;

: scan-file ( -- )
  0 \ current score value
  begin
    read-one-line
  while
    \ we need to split the string in half
    line-buffer swap split
    \ get the common character
    common-character
    char-value +
  repeat
;

next-arg open-input \ read file to open from command-line
scan-file
drop .
bye
