with import <nixpkgs> {};
with lib;
with builtins;
/*
    TODO: instead of count, it's possible to deal with an iterator as a function as in:

    fizzbuzz = n: let aux = i:
		if i > n then
			"end"
		else trace(
			if (mod i 3) == 0 && (mod i 5) == 0 then
				"FizzBuzz"
			else if (mod i 3) == 0 then
				"Fizz"
			else if (mod i 5) == 0 then
				"Buzz"
			else i
		) aux (i + 1); in aux 1
	;
*/
let
    fb = max: count:
        if count > max
            then "finished"
        else
            if mod count 3 == 0 && mod count 5 == 0
                then trace "FizzBuzz ${toString count}" fb max (count + 1)
            else if mod count 3 == 0
                then trace "Fizz ${toString count}" fb max (count + 1)
            else if mod count 5 == 0
                then trace "Buzz ${toString count}" fb max (count + 1)
                else
                    fb max (count + 1)
    ;
in
fb 100 1
