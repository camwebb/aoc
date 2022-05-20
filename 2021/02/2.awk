$1 == "forward" { x += $2 ; d += $2 * a }
$1 == "up"      { a -= $2 }
$1 == "down"    { a += $2 }
END             { print x, d, a, x*d }
