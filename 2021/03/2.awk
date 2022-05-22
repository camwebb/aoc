{
  seq[++line]  = $0
  kept["ox"][line] = 1
  kept["co"][line] = 1
}
END {
  bits = length(seq[1])

  for (p in kept) {
    for (i = 1; i <= bits; i++) {
      # pass 1, find commonset
      sum0 = sum1 = 0
      for (j = 1; j <= line; j++)
        if (kept[p][j])
          if (substr(seq[j],i,1) == 1)
            sum1++
          else
            sum0++
      # clunky
      if (p == "ox") {
        if (sum1 > sum0)
          choose[p] = 1
        else if (sum1 < sum0)
          choose[p] = 0
        else
        choose[p] = 1
      }
      else if (p == "co") {
        if (sum1 > sum0)
          choose[p] = 0
        else if (sum1 < sum0)
          choose[p] = 1
        else
          choose[p] = 0
      }
      print "bit " i ", p " p ", choose " choose[p]
      
      # pass 2, filter
      nkept = 0
      for (j = 1; j <= line; j++)
        if (kept[p][j] && (substr(seq[j],i,1) == choose[p])) {
          # print "  keep " seq[j]
          winner[p] = seq[j]
          nkept++
        }
        else
          kept[p][j] = 0
      if (nkept == 1)
        break
    }
    print "winner " p " = " winner[p]
    
  }
  for (i = 1; i <= bits; i++) {
    oxout += substr(winner["ox"],i,1) * (2^(bits-i))
    coout += substr(winner["co"],i,1) * (2^(bits-i))
  }
  print "oxout " oxout
  print "coout " coout
  print "val = " oxout * coout
  
}
  
