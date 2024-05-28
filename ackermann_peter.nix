with builtins;
let
    ack = m: n:
        if m == 0 
            then n + 1
        else
            if n == 0
                then ack (m - 1) 1
            else
                (ack (m - 1) (ack m (n - 1)))
    ;
in
''
ack 2 2 = ${toString (ack 2 2)}

ack 0 must return a function -> ${toString (typeOf (ack 0))}
''
