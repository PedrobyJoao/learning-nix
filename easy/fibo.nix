let
    /*
        I guess I never understood the fibo func until now.
        (now = 1 week after implementing the fibo func)

        The Fibonacci sequence is defined by:
        {
            F[n] = F[n-1] - F[n-2]
            F[1] = 1
            F[2] = 2
        }

        `n` stands for the n terms.

        The following function `fibo n` returns the value
        of the n'th term of the fibonacci sequence!

        It's NOT:
        - the sum of all values until n'th term
        - the sum of all values until n numbers have being iterated
    */
    fibo = n: if n > 1 then fibo(n - 1) + fibo(n - 2) else n;
in
{
    inherit fibo;

    t1 = fibo 10 == 55;
}
