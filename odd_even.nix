with import <nixpkgs> {};
with lib;
with builtins;
let
    even = n:
        if !(isInt n)
            then false
        else
            mod n 2 == 0
    ;

    odd = n:
        if !(isInt n)
            then false
        else
            ! (even n)
    ;
in
{
     t1 = even 0 == true;
     t2 = even 1 == false;
     t3 = even 2 == true;
     t4 = even 3 == false;
     t5 = odd 0 == false;
     t6 = odd 1 == true;
     t7 = odd 2 == false;
     t8 = odd 3 == true;
     t9 = even 10 == true;
     t10 = even (-1) == false;
     t11 = odd 10 == false;
     t12 = odd (-1) == true;
     t13 = even "string" == false;
     t14 = odd "string" == false;
     t15 = even 2.5 == false;
     t16 = odd 2.5 == false;
}
