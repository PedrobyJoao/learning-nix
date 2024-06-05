/*
Write the following programs:

- sumfib n which sums the first n terms of the fibonacci sequence;
- sumfact n, which sums the factorials of the integers from 1 to n;
- sumr n m which sums the integers between n and m, included;
- sumeven n and sumodd n, which respectively sums even and odd numbers between 1 and n.
*/
with builtins;
with import ./easy/odd_even.nix;
with import ./easy/fibo.nix;
with import ./foldln.nix;
with import ./foldrn.nix;
let
    # `s` stands for start point of accumulator
    foldlnseq = x: f: s: n: let go = acc: i:
       if i > n
           then acc 
        else
            go (f acc (x i)) (i + 1)
        ;in go s 1
    ;

    /*
        foldln is now a special case of foldlnseq.
        x: x (int -> int)

        What does it mean? foldln is a special case of foldlnseq
        where the `x` function being passed does nothing, it just
        returns the argument itself.

        It should be used when the iterator `i` doesn't have to be
        altered in anyway, just `f acc i` suffice for the functionality.
    */
    foldln = foldlnseq (x: x);

    /*
        On the following cases, foldln will be used because
        `i` doesn't need to be altered when calculating the sum
        of n natural numbers or the factorial of n.
    */
    sum = foldln add 0;
    fact = foldln mul 1;

    /*
        You're not seeing the previous versions of the functions now,
        but all the sum functions when using the old version of foldln
        are basically on the following format:

        1. First scenario (sumr, sumodd and sumeven)

        sumSomething = n: foldln (
            if something
                then f acc i # e.g. of f = add
            else
                acc
        ) 0 n;

        2. Second scenario (sumfact and sumfibo)

        sumfact = n: foldln (acc: i: acc + factOf i) 0 n;
        sumfibo = n: foldln (acc: i: acc + fibo i) 0 n;

        which could be translated to:
        ... foldln (acc: i: f acc (x i)) 0 n;
        f being commonly == add until now

        As you can see, the `x` of foldlnseq would actually play a role here
        because the only difference between both functions is a (x: x) function
        being applied in `i`.

        ---------------
        So now let's reimplement all sum functions with the new foldln, foldlnseq
        and foldlnp.
    */

    # TODO: foldlnp should use foldlnseq rather than foldln
    foldlnp = p: f: s: n:
        foldln (acc: i:
            if p i
                then f acc i
            else
                acc
        ) s n
    ;

    # (old-version) sumfact = n: foldln (acc: i: acc + factOf i) 0 n;
    sumfact = n: foldlnseq factOf add 0 n;

    # (old-version) sumfibo = n: foldln (acc: i: acc + fibo i) 0 n;
    sumfibo = n: foldlnseq fibo add 0 n;

    /*
        (old-version)
        sumr = n: m: foldln (acc: i:
            if n <= i && i <= m
                then acc + i
            else acc
            ) 0 m
        ;
    */
    sumr = n: m: foldlnp (i: n <= i && i <= m) add 0 m;

    /*
        (old-version)
        sumeven = n: foldln (acc: i: 
            if isEven i
                then acc + i
            else acc
            ) 0 n
        ;
    */
    sumeven = foldlnp isEven add 0;


    /*
        (old-version)
        sumodd = n: foldln (acc: i:
            if isOdd i
                then acc + i
            else
                acc
            ) 0 n
        ;
    */
    sumodd = foldlnp isOdd add 0;
in
{
    inherit foldln;
    # s1 = sum 1 == 1;
    # s2 = sum 2 == 3;
    # s3 = sum 3 == 6;

    # m1 = fact 1 == 1;
    # m2 = fact 2 == 2;
    # m3 = fact 4 == 24;

    # sfib1 = sumfibo 1 == 1;
    # sfib2 = sumfibo 2 == 2;
    # sfib3 = sumfibo 3 == 4;
    # sfib4 = sumfibo 4 == 7;
    # sfib5 = sumfibo 10 == 143;
     
    # sf1 = sumfact 1 == 1;
    # sf2 = sumfact 2 == 3;
    # sf3 = sumfact 3 == 9;
    # sf4 = sumfact 4 == 33;

    sr1 = sumr 1 3 == 6;
    sr2 = sumr 2 5 == 14;

    # se1 = sumeven 6 == 12;
    # se2 = sumeven 7 == 12;
    # se3 = sumeven 5 == 6;

    so1 = sumodd 6 == 9;
    so2 = sumodd 7 == 16;
    so3 = sumodd 5 == 9;
}
