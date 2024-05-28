/*
    Write a program sumsquare n (via foldln, of course!) which takes 
    an integer n as input, and returns the sum of the squares of integers from 1 to n.
*/
with import ./foldln.nix;
let
    # without using foldl
    sumsquare = n:
        if n == 1
            then 1
        else
            (n * n) + sumsquare (n - 1)
    ;

    # using foldl (omg, so easier and elegant =P)
    squareIfSucc = n: m: 
        if m - n == 1
            then (n * n) + (m * m)
        else
            (n * n) + m
    ;

    /*
        Currying/Partial-application:

        whre is the third argument on the following definition?
        Currying I guess (and sometimes called partia application maybe).
        The third arg will come from
        the caller. `sumsquareF` is actually returning a function
        which expects one more arg
    */
    sumsquareF = foldln squareIfSucc 1;

    /*
        *Important*: bug
        
        another solution for the same exercies doesn't work:

        sumsquare = foldln (s: i: s + (i * i)) 0;
        
        My foldln implementation is probably wrong then?
        It doesn't correctly foldln?

        It seemed to be correct until now because the order of 
        evaluation didn't matter. Until I tested this sumsquare
        solution where the order matters
    */
in
{
    t1 = sumsquareF 1 == 1;
    t2 = sumsquareF 2 == 5;
    t3 = sumsquareF 3 == 14;
    t4 = sumsquareF 4 == 30;
    t5 = sumsquareF 5 == 55;
}

/*
RANDOM NOTES:

Writing the stack trace manually makes debugging recursive functions easier I guess
(why not just use builtin trace? me dumb)

# foldln def
foldln = f: s: n: 
    if s == n
        then n
    else
        f s (foldln f (s + 1) n)

sumsquareF 3
n = 3 -> foldln (n*n + m*m) 1 n

f 1 (foldln f 2 3)
f 1  (f 2 (foldln f 3 3))
f 1  (f 2 3)
f 1 (13)
*/
