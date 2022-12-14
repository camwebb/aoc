BEGIN {
  RS = ""
  FS = "\n"
  D["["] =  1
  D["]"] = -1
}

{
  I[NR][1] = $1
  I[NR][2] = $2
}

END {
  for (i in I[1])
    parse(I[1][i], 1, i, 0) # gensub(/^\[(.*)\]$/,"\\1","G",a[1]))
  for (i in X[1]) {
    for (j in X[1][i])
      print 1, i, "at", j, X[1][i][j]
    for (j in U[1][i])
      print 1, i, "up", j, U[1][i][j]
  }
}

function parse(p, a, b, par,   s, c, x, d,r,n) {
  gsub(/^\[/,"",p)
  gsub(/\]$/,"",p)
  print (s=++S) ": entering, stripted p = " p
  U[a][b][s] = par
  if (!p) {
    print s ": empty"
    X[a][b][s] = "null"
    return 1
  }
  for (c = 1; c <= length(p); c++) { # char
    x = substr(p,c,1)
    # print s ":   c=" c " x=" x " pre-d=" d " r=" r " n=" n 

    if (!(d+=D[x])) { # depth == 0 test
      if (n) {        # if colecting n, this is end of n
        n = n x
        print s ": new parse() = " n
        parse(n, a, b, s)
        n = ""
      }
      else
        r = r x         # add to remainder
    }
    else {
      if (r) {
        print s ": rem = " r
        X[a][b][s] = X[a][b][s] r 
        r = ""
        n = n x
      }
      else
        n = n x         # add to new
    }
  }
  if (r) {
    print s ": rem = " r
    X[a][b][s] = X[a][b][s] r
  }
  return 0
}
