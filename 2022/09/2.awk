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
  if (dir == "U") y[0]++
  if (dir == "D") y[0]--
  if (dir == "L") x[0]--
  if (dir == "R") x[0]++
}

function mt (   k) {
  # for each knot
  for (k = 1; k <= 9; k++) {
    if (x[k-1] == x[k] && y[k-1] == y[k]) {
      # print k " over " k-1
    }
    else if (a(x[k-1]-x[k])<=1 && a(y[k-1]-y[k])<=1) {
      # print k " one apart " from k-1
    }
    else if (x[k-1]==x[k] && a(y[k-1]-y[k])==2) {
      # print "move " k " towards " k-1 " U/D"
      y[k] += (y[k-1]>y[k]?1:-1)
    }
    else if (a(x[k-1]-x[k])==2 && y[k-1]==y[k]) {
      # print "move " k " towards " k-1 " L/R"
      x[k] += (x[k-1]>x[k]?1:-1)
    }
    else {
      # print "move " k " diag towards " k-1
      x[k] += (x[k-1]>x[k]?1:-1)
      y[k] += (y[k-1]>y[k]?1:-1)
    }
  }
  if (!vt[x[9]][y[9]])
    visited++
  vt[x[9]][y[9]] = 1 # trace tail
}

function a(i) {
  return (i >=0 ? i :-i)
}

function vis(  xv,yv,d,k) {
  for (yv = 6; yv>=-6; yv--) {
    for (xv = -6; xv<= 6; xv++) {
      # if visited
      d = (vt[xv][yv] == 1 ? "#" : ".")
      # start pos
      d = (xv == 0 && yv == 0 ? "s" : d)
      # knots, overwriting
      for (k = 9; k >= 0; k--)
        d = (y[k] == yv && x[k] == xv ? k : d)
      printf "%s", d
    }
    printf " %2d\n", yv
  }
}

