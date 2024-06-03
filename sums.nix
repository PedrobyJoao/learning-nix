/*
Write the following programs:

- sumfib n which sums the first n terms of the fibonacci sequence;
- sumfact n, which sums the factorials of the integers from 1 to n;
- sumr m n which sums the integers between m and n, included;
- sumeven n and sumodd n, which respectively sums even and odd numbers between 1 and n.
*/
with builtins;
with import ./easy/odd_even.nix;
with import ./foldln.nix;
with import ./foldrn.nix;
let
    
    /*
        *sumfib n*

        sumfib 5 using foldln seems easier because we have to calculate the fibo nums
        along the way

        sumfib = n: foldln f 0 n
        (add 0 (add 1 (add 1 (add 2 (add 3))))

        f = n: if n > 1 then (n - 1) + (n - 2) else n
    */
    

    # foldln doesn't exactly work for sumfact as it doesn't compute the last factorial of the sequence
    sumfact = n: foldrn (n: m: factOf n + m) 1 n;

    sumr = n: m: foldln (n: m: n + m) n m;

    sumeven = n: foldln (n: m: 
                if !isEven m
                    then 0
                else if !isEven n
                    then m
                else
                    n + m
            ) 1 n;


    # I was trying to use foldln but it was so harder (maybe even impossible given the requirement
    # of starting the sequence from 1)
    # READER: if it's possible using foldn, let me know.
    sumodd = n: foldrn (n: m:
                if isOdd n
                    then n + m
                else
                    m
            ) 1 n;
in
{
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
