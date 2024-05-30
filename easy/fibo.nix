let
    fibo = n: if n > 1 then fibo(n - 1) + fibo(n - 2) else n;
in
    fibo( fibo 5)
