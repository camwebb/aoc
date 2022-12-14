BEGIN {
  RS = ""
  FS = "\n"
  D["["] =  1
  D["]"] = -1
  DEBUG = 0
}

{
  I[NR][1] = $1
  I[NR][2] = $2
}

END {
  for (i in I)
    for (j in I[i]) {
      S = 0
      parse(I[i][j], i, j, 0) # gensub(/^\[(.*)\]$/,"\\1","G",a[1]))
    }
  for (i in X) {
    for (j in X[i]) {
      for (k in X[i][j])
        print i, j, "at", k, X[i][j][k]
      for (k in U[i][j])
        print i, j, "up", k, U[i][j][k]
    }
  }
}

function parse(p, a, b, par,   s, c, x, d,r,n) {
  gsub(/^\[/,"",p)
  gsub(/\]$/,"",p)
  s = ++S
  if (DEBUG)
    print s ": entering, stripted p = " p
  U[a][b][s] = par
  if (!p) {
    if (DEBUG)
      print s ": empty"
    X[a][b][s] = "null"
    return 1
  }
  for (c = 1; c <= length(p); c++) { # char
    x = substr(p,c,1)
    # if (DEBUG)
    #   print s ":   c=" c " x=" x " pre-d=" d " r=" r " n=" n 

    if (!(d+=D[x])) { # depth == 0 test
      if (n) {        # if colecting n, this is end of n
        n = n x
        if (DEBUG)
          print s ": new parse() = " n
        parse(n, a, b, s)
        n = ""
      }
      else
        r = r x         # add to remainder
    }
    else {
      if (r) {
        if (DEBUG)
          print s ": rem = " r
        X[a][b][s] = X[a][b][s] r 
        r = ""
        n = n x
      }
      else
        n = n x         # add to new
    }
  }
  if (d) {
    print "Error: imbalanced tree: " a, b > "/dev/stderr"
    exit 1
  }
    
  if (r) {
    if (DEBUG)
      print s ": rem = " r
    X[a][b][s] = X[a][b][s] r
  }
  return 0
}
