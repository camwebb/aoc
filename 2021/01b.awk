# BEGIN                { print "  $0    c    b    a    s    i" } 
NR > 3 && ($0+a+b > s) { i++ }
                       { c = b; b = a ; a = $0 ; s = a+b+c
                         # printf "%4d %4d %4d %4d %4d %4d\n", $0,c,b,a,s,i
                       }
END                    { print i }
