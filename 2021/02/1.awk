$1 == "forward" { x += $2 }
$1 == "up"      { d -= $2 }
$1 == "down"    { d += $2 }
END             { print x, d, x*d }
