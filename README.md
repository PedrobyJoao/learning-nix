> "Functional code is so elegant.
>  Functional programming is so relaxing."
>
>   - PedroByJoao after some hours of Nix

Just getting a bit acquainted with the functional paradigm and preparing myself to migrate to NixOS.

My study notes are mostly under the files itself but mainly `foldln.nix` and `foldrn.nix`.


#### TODOs

- [  ] explain tail recursion with example on README
- [  ] add explanation within `foldln.nix` or `foldrn.nix` about tail recursion order of evaluation
- [ x ] `foldn` is not totally correct even though tests pass. The order of evaluation is wrong.
- [ x ] implement `foldln` with tail recursion

### Tail recursion

It seems "common" recursive functions are not memory-efficient comparing with tail recursive functions.
And how tail recursion works?

Normal recursion
```nix
let
    fn = f: n:
        n + fn f (n - 1) # here
in
```

The order of execution of the above example is:
```nix
# r and r2 just for the sake of clarity
r = n - 1
r2 = fn f (r) # here
n + r2
```

As you can see, before applying sum of `n + r2`, the entire recursion has to be done until the last step.
And the same applies for all the intermediary `n`s before the last step, they must be kept in-memory.

**TODO**: With Tail recursion:

more detailed explanation: https://www.youtube.com/watch?v=_JtPhF8MshA

### Others
- I didn't know `if else` existed in Nix so some files may have nested if/else files =P
