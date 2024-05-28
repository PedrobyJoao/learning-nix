/*
Write a program sum which takes an integer as input, 
and returns the sum of integers from 1 to n
*/

let
    # I overcomplicated putting this auxiliar function (some people would say 'variable').
    # it isn't necessary at all, and not elegant.
    sum = n: let aux = i:
        if i == n
            then n 
        else
            i + aux (i + 1)
        ; in aux 1
    ;
in
sum 10
