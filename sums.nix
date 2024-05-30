/*
Write the following programs:

- sumfib n which sums the first n terms of the fibonacci sequence;
- sumfact n, which sums the factorials of the integers from 1 to n;
- sumr m n which sums the integers between m and n, included;
- sumeven n and sumodd n, which respectively sums even and odd numbers between 1 and n.
*/
let
    
    /*
        *sumfib n*

        sumfib 5 using foldln seems easier because we have to calculate the fibo nums
        along the way

        sumfib = n: foldln f 0 n
        (add 0 (add 1 (add 1 (add 2 (add 3))))

    */
    sumfib = n:
        
