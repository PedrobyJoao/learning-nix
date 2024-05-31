/*
 Now let’s try to factorize sum and fact by introducing a new function, foldln f s n,
 where n is integer marking the end of our integer sequence. Try to understand what 
 f and s represent, and implement foldln; use it to re-implement sum and fact to check your results.

 Note: the following solution could be improved memory-efficiency wise using tail recursion.

 **IMPORTANT**:
 foldln = foldl on n, n being a sequence of natural numbers
*/
with builtins;
let
    /*
        The name of function `foldln`, the `l` is for *left*,
        meaning that the evaluation order of fold should start
        at the first elements (e.g.: 0 1).

        My previous implementation was a `foldrn`, starting
        evaluating from the rightest elements (the last ones) first.

        Note: although the following implementation is working,
        the order of evaluation is not correct.

        Let f = n: m: add n m

        Wrong evaluation order: (f 1 (f 2 (f 3 4)))

        Correct evaluation order: (f (f (f (f 0 1) 2) 3) 4) 

        Expanding on the correct evaluation order:

        foldln f 0 4 ==> (f (f (f (f 0 1) 2) 3) 4)

        stack:
        foldln f 0 4
        (f (foldln 0 3) 4)
        (f (f (foldln 0 2) 3) 4)
        (f (f (f (foldln 0 1) 2) 3) 4)
        (f (f (f (f 0 1) 2) 3) 4)

        sum_square:
        (f (f (f (f 0 1) 2) 3) 4)
    */

    foldlnNoTR = f: s: n:
        if n - s <= 1
            then f s n
        else
            f (foldln f s (n - 1)) n
    ;

    /*
        foldln add 1 5
        go 1 5
        go (1 + 1) (add 1 5) == go 2 6
        go (2 + 1) (add 2 6) == go 3 8
        go (3 + 1) (add 3 8) == go 4 11
        go (4 + 1) (add 4 11) == go 5 15
        15
        ==
        (add 4 (add 3 (add 2 (add 1 5))))
    */
    # with tail recursion
    foldln = f: s: n: let go = aux: acc:
        if aux == n
            then acc
        else
            go (aux + 1) (f aux acc)
        ;in go s n
    ;

    /*
        sumUntil 4
        (add (add (add (add 0 1) 2) 3) 4)
    */
    sumUntil = n: foldln (n: m: n + m) 0 n;

    /*
        factorOf 4
        (mult (mult (mult 1 2) 3) 4)
    */
    factOf = n: foldln (n: m: n * m) 1 n;
in
{
    inherit foldln; # make it exportable. Is inherit the best way?

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
