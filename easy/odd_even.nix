with import <nixpkgs> {};
with lib;
with builtins;
let
    isEven = n:
        if !(isInt n)
            then false
        else
            mod n 2 == 0
    ;

    isOdd = n:
        if !(isInt n)
            then false
        else
            ! (isEven n)
    ;
in
{
     inherit isEven;
     inherit isOdd;

     t1 = isEven 0 == true;
     t2 = isEven 1 == false;
     t3 = isEven 2 == true;
     t4 = isEven 3 == false;
     t5 = isOdd 0 == false;
     t6 = isOdd 1 == true;
     t7 = isOdd 2 == false;
     t8 = isOdd 3 == true;
     t9 = isEven 10 == true;
     t10 = isEven (-1) == false;
     t11 = isOdd 10 == false;
     t12 = isOdd (-1) == true;
     t13 = isEven "string" == false;
     t14 = isOdd "string" == false;
     t15 = isEven 2.5 == false;
     t16 = isOdd 2.5 == false;
}
