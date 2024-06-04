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

    # foldln is now a special case of foldlnseq 
    # x: int -> int
    # foldln = foldlnseq (x: x);

    # sum = foldln add 0;
    # mult = foldln mult 1;

    sumfibo = n: foldln (acc: i: 
        if i == 1
            then acc + i
        else
            acc + fibo i
    ) 0 n;


    sumfact = n: foldln (acc: i: acc + factOf i) 0 n;

    sumr = n: m: foldln (acc: i:
        if n <= i && i <= m
            then acc + i
        else
            acc
        ) 0 m
    ;

    sumeven = n: foldln (acc: i: 
        if isEven i
            then acc + i
        else
            acc
        ) 0 n
    ;


    sumodd = n: foldln (acc: i:
        if isOdd i
            then acc + i
        else
            acc
        ) 0 n
    ;
in
{
    # s1 = sum 1 == 1;
    # s2 = sum 2 == 3;
    # s3 = sum 3 == 6;

    sfib1 = sumfibo 1 == 1;
    sfib2 = sumfibo 2 == 2;
    sfib3 = sumfibo 3 == 4;
    sfib4 = sumfibo 4 == 7;
    sfib5 = sumfibo 10 == 143;
    
    sf1 = sumfact 1 == 1;
    sf2 = sumfact 2 == 3;
    sf3 = sumfact 3 == 9;
    sf4 = sumfact 4 == 33;

    sr1 = sumr 1 3 == 6;
    sr2 = sumr 2 5 == 14;

    se1 = sumeven 6 == 12;
    se2 = sumeven 7 == 12;
    se3 = sumeven 5 == 6;

    so1 = sumodd 6 == 9;
    so2 = sumodd 7 == 16;
    so3 = sumodd 5 == 9;
}
