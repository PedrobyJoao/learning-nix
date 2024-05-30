/*
    More info about fold implementations in general within ./foldln.nix

    Implement foldrn; find an example where foldln and foldrn
    would give different output on the same input.

    I may try to implement tail recursion
*/
let
    /*
        Reminder: foldrn, r stands for starting the evaluation from the righest

        Expected evaluation of `foldrn add 1 4`:
        (add 1 (add 2 (add 3 4)))

        (add s (foldrn (s + 1) (n - 1)))




    */
    foldrn = f: s: n:
        if s == n
            then n
        else
            f s (foldrn f (s + 1) n)
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
