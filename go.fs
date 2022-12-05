( https://youtu.be/mvrE2ZGe-rs?t=1145 )
( edit-compile-run loop in forth )
: empty s" ---marker--- marker ---marker---" evaluate ;
: edit s" emacsclient day5.fs" system ;
: run s" day5.fs" included ;
: ecr edit run ;

marker ---marker---
