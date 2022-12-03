include common.fs

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
      <
      if swap drop 0
      else drop 0
           endif \ compare current with max and replace
    else
      s>number? 2drop + \ add to current value
      endif
  repeat
;

s" ./day1/input.txt" open-input
scan-file
2drop .
bye
