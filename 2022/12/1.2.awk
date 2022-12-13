# Second iteration. No backtracking

BEGIN{
  srand()
  split("abcdefghijklmnopqrstuvwxyz",tmp,"")
  for (i in tmp)
    s2d[tmp[i]] = i+0
  
  incx["n"] =  0 ; incy["n"] = -1
  incx["s"] =  0 ; incy["s"] =  1
  incx["w"] = -1 ; incy["w"] =  0
  incx["e"] =  1 ; incy["e"] =  0

  DEBUG = 0
  RUNS = 1000
}

{
  split($0,h[NR],"")
  for (i in h[NR]) {
    if (h[NR][i] == "S") {
      sx = i+0 ; sy = NR ; h[NR][i+0] = 1  # AHA! remember indices are strings
    }
    else if (h[NR][i] == "E") {
      dx = i+0 ; dy = NR 
      mori[NR][i] = "E"
    }
    else {
      mori[NR][i] = h[NR][i]
      h[NR][i] = s2d[h[NR][i]]
      if (maxh < h[NR][i])
        maxh = h[NR][i]
    }
  }
}

END{
  h[dy][dx] = maxh # not necessary in real puzzle where E = 26
  my = length(h)
  mx = length(h[NR])

  if (DEBUG > 1)
    print "dx = " dx ", dy = " dy ", h[E] = " maxh "\n"
  
  for (run = 1; run <= RUNS; run++) {
    
    # reset
    deadend = routel = 0
    x = sx ; y = sy
    for (i = 1 ; i <= my ; i++)
      for (j = 1 ; j <= mx ; j++)
        m[i][j] = mori[i][j]
    
    for (step = 1; step <= 1000 ; step++) {
      b[y][x] = 1
      move()
      if (x == dx && y == dy)
        print "SUCCESS!"
      if ((x == dx && y == dy) || deadend) {
        # copy the best map so far
        if (routel > maxroutel) {
          maxroutel = routel
          # print "copying run " run
          for (i = 1 ; i <= my ; i++)
            for (j = 1 ; j <= mx ; j++)
              R[i][j] = m[i][j]
        }
        rls[run] = routel
        break
      }
    }
    
    if (DEBUG > 0) {
      print "run " run
      for (r = 1; r <= my; r++) {
        for (c = 1; c <= mx; c++)
          printf "%s", m[r][c]
        printf "\n"
      }
      print ""
    }

    delete b
    delete m
  }

  asort(rls, rls2, "@val_num_desc")
  print "successes/runs: " length(rls2) "/" RUNS ", first 20:" 
  for (i = 1; i <= 20; i++)
    printf " %d", rls2[i]
  printf "\n"

  print "\nbest map:\n"
  for (i = 1; i <= my; i++) {
    for (j = 1; j <= mx; j++)
      printf "%s", R[i][j]
    printf "\n"
  }
}

function move(   _p, _m) {
  _p = int(rand()*2)
  if (DEBUG > 1)
    printf "%02d: at %03d/%03d (dx=%d dy=%d p=%d)\n" ,  \
      step, x, y, dx, dy, _p
  
  #            sewn
  #            swen
  #       eswn  |  wsen
  #       esnw  |  wsne
  # ensw  ------+-------  wnse
  # esnw  enws  |  wnes   wsne
  #       ensw  |  wnse
  #           nwes
  #           news

  _m = ""
  # testing logic:

  if      (x < dx && y < dy && _p)
    _m = "eswn"
  else if (x < dx && y < dy && !_p)
    _m = "esnw"
  else if (x == dx && y < dy && _p)
    _m = "sewn"
  else if (x == dx && y < dy && !_p)
    _m = "swen"
  else if (x > dx && y < dy && _p)
    _m = "wsen"
  else if (x > dx && y < dy && !_p)
    _m = "wsne"

  else if (x < dx && y == dy && _p)
    _m = "ensw"
  else if (x < dx && y == dy && !_p)
    _m = "esnw"
  else if (x > dx && y == dy && _p)
    _m = "wnse"
  else if (x > dx && y == dy && !_p)
    _m = "wsne"
  
  else if (x < dx && y >  dy && _p)
    _m = "enws"
  else if (x < dx && y >  dy && !_p)
    _m = "ensw"
  else if (x == dx && y >  dy && _p)
    _m = "nwes"
  else if (x == dx && y >  dy && !_p)
    _m = "news"
  else if (x > dx && y > dy && _p)
    _m = "wnes"
  else if (x > dx && y > dy && !_p)
    _m = "wnse"
  else
    exit 1
  
  if (DEBUG > 1)
    print "          order " _m 
  
  split(_m, _n, "")

  if (test(y+incy[_n[1]], x+incx[_n[1]]))
    go(y+incy[_n[1]], x+incx[_n[1]])
  else if (test(y+incy[_n[2]], x+incx[_n[2]]))
    go(y+incy[_n[2]], x+incx[_n[2]])
  else if (test(y+incy[_n[3]], x+incx[_n[3]]))
    go(y+incy[_n[3]], x+incx[_n[3]])
  else if (test(y+incy[_n[4]], x+incx[_n[4]]))
    go(y+incy[_n[4]], x+incx[_n[4]])
  # then deadend
  else {
    m[y][x] = "X"
    deadend = 1
    if (DEBUG)
      print "          deadend!"
  }
}
      
    
function test(_y, _x,     _box) {
  # _back is a flag for trying to move back a step
  if (DEBUG > 1) {
    if ((_x > x) && (_y == y))
      _box = "◨"
    else if ((_x < x) && (_y == y))
      _box = "◧"
    else if ((_x == x) && (_y > y))
      _box = "⬓"
    else if ((_x == x) && (_y < y))
      _box = "⬒"
    print "  test " _box
  }

  # is there i) a height (i.e. on the board), ii) an allowable climb, and
  # iii) not visited
  if (h[_y][_x] &&                              \
      (h[_y][_x] <= (h[y][x]+1)) &&             \
      !b[_y][_x])
    return 1
  else {
    if (DEBUG >1) {
      print "          block " _box
    }
    return 0
  }
}

function go(_y, _x,    _dir) {
  if ((_x > x) && (_y == y))
    _dir = ">"
  else if ((_x < x) && (_y == y))
    _dir = "<"
  else if ((_x == x) && (_y > y))
    _dir = "v"
  else if ((_x == x) && (_y < y))
    _dir = "^"
  m[y][x] = _dir
  if (DEBUG > 1)
    print "          moves " _dir 
  
  x = _x
  y = _y
  routel++
}

