BEGIN {X=1}

!$2 { t++
  check()
}

$2 {
  t++
  check()
  t++
  X+= $2
  check()
}

END { print score }

function check() {
  # print "end of " t ", X=" X
  if ((t+1) == 20 || !(((t+1)-20) % 40)) {
    print "-->during " t+1 ", X=" X " score = " (t+1) * X
    score += ((t+1) * X)
  }
}


  
