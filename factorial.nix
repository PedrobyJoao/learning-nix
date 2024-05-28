#!/usr/bin/env -S nix-instantiate --eval
# fact (3) = n * fact (2)
# fact (2) = 2 * fact (1)
# fact (1) = 1
let
    fact = n: if n > 1 then n*fact(n - 1) else 1;
in
{
    # all the following must yield true
    t1 = fact 1 == 1;
    t2 = fact 2 == 2;
    t3 = fact 3 == 6;
    t4 = fact 4 == 24;
    t5 = fact 5 == 120;
}
