/*
    Eratosthenes’ sieve computes prime numbers up to a certain fixed integer.
    Have a look at the Wikipedia page, and use it to implement a function sieve n which
    prints (trace) whether a given number is prime or not. Your implementation must 
    rely on foldln & friends. Do not use lists or sets.

    *  *
     () OMG

    Tip: The accumulator of fold should be a function now.
    The function will remember which numbers are not prime, and it should start with
    int -> bool
    (x: x != 1)
*/
with builtins;
with import ./sums.nix;
let
    /*
        let's first consider all 100 multiples

        let f = (x: x != 1)

          ---------------  
        sieve 1
        f 1 == false

          ---------------  
        sieve 2
        f 2 == true

          ---------------  
        sieve 3
        # check first number
        f 2 == true

        # add to acumulator before going to the next number
        acc = x: x != 1
        (x: acc || x == 2 || mod x 2 != 0)

        # last number
        f 3 == true

          ---------------  
        sieve 4
        # check first number
        f 2 == true

        # add to acumulator before going to the next number
        acc = x: x != 1
        (x: acc x || x == 2 || mod x 2 != 0) # basically == (x: x: x != 1 || x == 2 || mod x 2 != 0)

        # check number
        f 3 == true

        # add to acumulator before going to the next number
        acc = (x: acc x || x == 2 || mod x 2 != 0) 
        (x: acc x || x == 3 || mod x 3 != 0)

        # check number
        f 4 == false
        # if it's false, we don't add to the list

        basically:
        1, not-prime, do nothing
        2, prime, add to accumulator
        3, prime, add to accumulator
        4, not-prime, do nothing
        ...

        Trying to relate with foldlnseq:
        if acc i # if prime
            f acc i
        else
            acc

        That is my idea, now the question is, how to:
        f acc i should return something like
        (acc: i: acc i || x == i || mod x i) # confusing vars, I know sorry


    */
    mod = a: b: a - b * (a / b);

    # Important: I spent more time than it should because the builtin.mod was
    # not working with the && operator. =(
    sieve = n:
        foldln 
            # acc is basically "isPrime"
            (acc: i: 
                if acc i
                    then trace "${toString i} is prime" 
                    (x: (acc x) && (mod x i != 0)) # f acc i ==> should return a new func acc
                else
                    trace "${toString i} NOT prime" 
                    acc
            ) (x: x != 1) n;
in
sieve 13
