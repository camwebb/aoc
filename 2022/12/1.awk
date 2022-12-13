BEGIN{
  srand()
  split("abcdefghijklmnopqrstuvwxyz",tmp,"")
  for (i in tmp)
    s2d[tmp[i]] = i+0
  DEBUG = 1
}

{
  split($0,h[NR],"")
  for (i in h[NR]) {
    if (h[NR][i] == "S") {
      x = i ; y = NR ; h[NR][i] = 1
    }
    else if (h[NR][i] == "E") {
      dx = i ; dy = NR ; h[NR][i] = 26
      m[NR][i] = "E"
    }
    else {
      m[NR][i] = h[NR][i]
      h[NR][i] = s2d[h[NR][i]]
    }
  }
}

END{
  my = length(h)
  mx = length(h[NR])
  
  # for (run = 1; run <= 100; run++)
  # { 
  # chose move
  trapped = 0 ; routel = 0
  for (step = 1; step <= 100000 ; step++) {
    move()
    if ((x == dx && y == dy) || trapped)
      break
  }

  if (DEBUG > 0) {
  #   print ""
  #   for (r = 1; r <= my; r++) {
  #     for (c = 1; c <= mx; c++)
  #       printf "%02d ", h[r][c]
  #     printf "\n"
  #   }
  #  print ""
    for (r = 1; r <= my; r++) {
      for (c = 1; c <= mx; c++)
        printf "%s", m[r][c]
      printf "\n"
    }
  }
  print step
}

function move(   _p) {
  _p = int(rand()*2)
  if (DEBUG > 1)
    printf "%02d %02d/%02d\n", step, x, y

  # target is east
  if (x < dx) {
    # try e
    if (test(y, x+1, 0))
      go(y,x+1, 0)
    # then try s/n
    else if (test(y+1, x, 0))
      go(y+1,x, 0)
    # then try other s/n
    else if (test(y-1, x, 0))
      go(y-1,x, 0)
    # then w (away)
    else if (test(y, x-1, 0))
      go(y, x-1, 0)
    # then backtrack and block that route
    else if (test(priory, priorx, 1))
      go(priory, priorx, 1)
  }

  # target is west
  else if (x >= dx) {
    # try w
    if (test(y, x-1, 0))
      go(y,x-1, 0)
    # then try s/n
    else if (test(y+1, x, 0))
      go(y+1,x, 0)
    # then try other s/n
    else if (test(y-1, x, 0))
      go(y-1,x, 0)
    # then e (away)
    else if (test(y, x+1, 0))
      go(y, x+1, 0)
    # then backtrack and block that route
    else if (test(priory, priorx, 1))
      go(priory, priorx, 1)
  }

  # target is south
  else if (y < dy) {
    # try s
    if (test(y+1, x, 0))
      go(y+1,x, 0)
    # then try e/w
    else if (test(y, x+1, 0))
      go(y,x+1, 0)
    # then try other e/w
    else if (test(y, x-1, 0))
      go(y,x-1, 0)
    # then n (away)
    else if (test(y-1, x, 0))
      go(y-1, x, 0)
    # then backtrack and block that route
    else if (test(priory, priorx, 1))
      go(priory, priorx, 1)
  }

  # target is north
  else if (y >= dy) {
    # try n
    if (test(y-1, x, 0))
      go(y-1,x, 0)
    # then try e/w
    else if (test(y, x+1, 0))
      go(y,x+1, 0)
    # then try other e/w
    else if (test(y, x-1, 0))
      go(y,x-1, 0)
    # then s (away)
    else if (test(y+1, x, 0))
      go(y+1, x, 0)
    # then backtrack and block that route
    else if (test(priory, priorx, 1))
      go(priory, priorx, 1)
  }
  
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
      print "          retn " _box
    return 0
  }
  # is there i) a height (i.e. on the board), ii) an allowable height, and
  # iii) not downwards, iv) not blocked, v) not the way you came
  else if (!h[_y][_x] ||                              \
           (h[_y][_x] > (h[y][x]+1)) ||               \
           (h[_y][_x] < h[y][x])     ||               \
           b[y][x][_y][_x]) {
    # => fail
    # block:
    b[y][x][_y][_x] = 1
    m[y][x] = m[y][x] _box
    if (DEBUG >1) {
      print "          fail " _box
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
    print "          " _dir " " (_retreat? "r":" ")

  priorx = x
  x = _x
  priory = y
  y = _y
  routel++

  if (_retreat) {
    routel-=2
    b[y][x][priory][priorx] = 1    
  }
}


