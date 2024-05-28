/*
 Now let’s try to factorize sum and fact by introducing a new function, foldln f s n,
 where n is integer marking the end of our integer sequence. Try to understand what 
 f and s represent, and implement foldln; use it to re-implement sum and fact to check your results.

 Note: the following solution could be improved memory-efficiency wise using tail recursion.
*/
let
    # without tail recursion
    foldln = f: s: n: 
        if s == n
            then n
        else
            f s (foldln f (s + 1) n)
    ;

    # TODO: with tail recursion

    /*
        sumUntil 4
        (add 1 (add 2 (add 3 4)))
    */
    sumUntil = n: foldln (n: m: n + m) 1 n;

    /*
        factorOf 4
        (mult 1 (mult 2 (mult 3 4)))
    */
    factOf = n: foldln (n: m: n * m) 1 n;
in
{
    inherit foldln;

    # all the following must yield true
    t1 = factOf 1 == 1;
    t2 = factOf 2 == 2;
    t3 = factOf 3 == 6;
    t4 = factOf 4 == 24;
    t5 = factOf 5 == 120;

    t6 = sumUntil 1 == 1;
    t7 = sumUntil 2 == 3;
    t8 = sumUntil 3 == 6;
    t9 = sumUntil 4 == 10;
}
