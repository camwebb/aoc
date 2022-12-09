BEGIN{ hx = hy = tx = ty = 0}
{
  # print NR ") " $1, $2
  for (i=1; i++<=$2;) {
    mh($1)
    mt()
    # vis()
  }
  # print ""
}

END {
  print visited
}

function mh (dir) {
  if (dir == "U") hy++
  if (dir == "D") hy--
  if (dir == "L") hx--
  if (dir == "R") hx++
}

function mt (dir) {
  if (hx == tx && hy == ty) {}
    # print "over"
  else if (a(hx-tx)<=1 && a(hy-ty)<=1) {}
    # print "one apart"
  else if (hx==tx && a(hy-ty)==2) {
    # print "move U/D"
    ty += (hy>ty?1:-1)
  }
  else if (a(hx-tx)==2 && hy==ty) {
    # print "move L/R"
    tx += (hx>tx?1:-1)
  }
  else {
    # print "move diag"
    tx += (hx>tx?1:-1)
    ty += (hy>ty?1:-1)
  }
  if (!vt[tx][ty])
    visited++
  vt[tx][ty] = 1 # trace
}

function a(i) {
  return (i >=0 ? i :-i)
}

function vis(  x,y,d) {
  for (y = 6; y>=-6; y--) {
    for (x = -6; x<= 6; x++) {
      d = (vt[x][y] == 1 ? "#" : ".")
      d = (x == 0 && y == 0 ? "s" : d)
      d = (ty == y && tx == x ? "t" : d)
      d = (hy == y && hx == x ? "H" : d)
      printf "%s", d
    }
    printf " %2d\n", y
  }
}

