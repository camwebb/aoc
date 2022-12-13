BEGIN{
  srand()
  split("abcdefghijklmnopqrstuvwxyz",tmp,"")
  for (i in tmp)
    s2d[tmp[i]] = i+0
  
  incx["n"] =  0 ; incy["n"] = -1
  incx["s"] =  0 ; incy["s"] =  1
  incx["w"] = -1 ; incy["w"] =  0
  incx["e"] =  1 ; incy["e"] =  0

  DEBUG = 1
}

{
  split($0,h[NR],"")
  for (i in h[NR]) {
    if (h[NR][i] == "S") {
      x = i+0 ; y = NR ; h[NR][i+0] = 1  # AHA! remember indices are strings
    }
    else if (h[NR][i] == "E") {
      dx = i+0 ; dy = NR 
      m[NR][i] = "E"
    }
    else {
      m[NR][i] = h[NR][i]
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
  
  # for (run = 1; run <= 100; run++)
  # { 
  # chose move
  trapped = 0 ; routel = 0
  for (step = 1; step <= 500 ; step++) {
    move()
    if ((x == dx && y == dy) || trapped)
      break
  }

  if (DEBUG > 0) {
    for (r = 12; r <= 25; r++) {
      for (c = 1; c <= 20; c++)
        printf "%s", m[r][c]
      printf "\n"
    }
  }
  print "\n" step
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

  if (test(y+incy[_n[1]], x+incx[_n[1]], 0))
    go(y+incy[_n[1]], x+incx[_n[1]], 0)
  else if (test(y+incy[_n[2]], x+incx[_n[2]], 0))
    go(y+incy[_n[2]], x+incx[_n[2]], 0)
  else if (test(y+incy[_n[3]], x+incx[_n[3]], 0))
    go(y+incy[_n[3]], x+incx[_n[3]], 0)
  else if (test(y+incy[_n[4]], x+incx[_n[4]], 0))
    go(y+incy[_n[4]], x+incx[_n[4]], 0)
  # then backtrack and block that route
  else if (test(priory, priorx, 1))
    go(priory, priorx, 1)
  else
    exit 1
}
      
    
function test(_y, _x, _back,    _box) {
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

  # if backtracking, test for having fallen in a hole
  if (_back) {
    if (h[_y][_x] > (h[y][x]+1)) {
      trapped = 1
      print "TRAPPED!"
      return 0
    }
    else
      return 1
  }
  # not actively back tracking, reject the way you came
  else if (_y == priory && _x == priorx) {
    if (DEBUG >1)
      print "          n_rtn " _box
    return 0
  }
  # is there i) a height (i.e. on the board), ii) an allowable height, and
  # iii) not downwards more than 1, iv) not blocked, v) not the way you came
  else if (!h[_y][_x] ||                              \
           (h[_y][_x] > (h[y][x]+1)) ||               \
           (h[_y][_x] < (h[y][x]-1))     ||           \
           b[y][x][_y][_x]) {
    # => fail
    # block:
    b[y][x][_y][_x] = 1
    m[y][x] = m[y][x] _box
    if (DEBUG >1) {
      print "          block " _box
    }
    return 0
  }
  else
    return 1
}

function go(_y, _x, _retreat,    _dir) {
  if (DEBUG > 0) {
    if ((_x > x) && (_y == y))
      _dir = ">"
    else if ((_x < x) && (_y == y))
      _dir = "<"
    else if ((_x == x) && (_y > y))
      _dir = "v"
    else if ((_x == x) && (_y < y))
      _dir = "^"
    m[y][x] = _dir
  }
  if (DEBUG > 1)
    print "          moves " _dir " " (_retreat? "r":" ")

  priorx = x
  x = _x
  priory = y
  y = _y
  routel++

  if (_retreat) {
    routel -= 2
    b[y][x][priory][priorx] = 1    
  }
}


