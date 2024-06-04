/*
    More info about fold implementations in general within ./foldln.nix

    Implement foldrn; find an example where foldln and foldrn
    would give different output on the same input.

    I may try to implement tail recursion
*/
with builtins;
let
    /*
        ** foldrn with tail recursion **
        Reminder: foldrn, r stands for starting the evaluation from the righest
        
        f: stands for the func to be computed on acc and i
        s: stands for the INITIAL VALUE of the ACCUMULATOR
        i: from where to start the iterator

        ***** IMPORTANT *****
        I thought `s` referred to where to start the foldrn process,
        and actually my previous implementation indeed was handling that way.

        But it wasn't the correct way, because:

        1. foldrn should go iterate through all natural numbers
        until i > n. It should NOT start in the middle

        2. `s` refers to the initial value of the acc, not anything else
        ***** IMPORTANT *****

        - Stack example:

        foldrn add 1 5
        go 5 1
        go 4 6 -> go (5 - 1) (add 5 1)
        go 3 10 -> go (4 - 1) (add 4 6)
        go 2 13 -> go (3 - 1) (add 3 10)
        go 1 15 -> go (2 - 1) (add 2 13)
        15
        ==
        (add 2(add 3 (add 4 (add 5 1)))
    */
    foldrn = f: s: n: let go = acc: i:
        if i == 1
            then trace (
                "Final result for s=${toString s} and n=${toString n}: ${toString acc}"
                ) acc
        else
            trace "i = ${toString i} acc = ${toString acc}" go (f acc i) (i - 1) 
        
        ;in go 1 n
    ;

    /*
        sumUntil 4
        (add 1 (add 2 (add 3 4)))
    */
    sumUntil = n: foldrn (n: m: n + m) 0 n;

    /*
        factorOf 4
        (mult 1 (mult 2 (mult 3 4)))
    */
    factOf = n: foldrn (n: m: n * m) 1 n;
in
{
    inherit foldrn;

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
