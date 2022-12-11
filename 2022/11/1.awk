BEGIN{RS=""}

{
  w = i = 0 
  split($0,word,"[\n ]+")
  m = gensub(/:/,"","G",word[w+=2])
  for (w = w+3 ; word[w] != "Operation:"; w++)
    wl[m][++i] = gensub(/,/,"","G",word[w]) # first item index is 1
  items[m] = i
  op1[m] = word[w+=4]
  op2[m] = word[w+=1]
  div[m] = word[w+=4]
  true[m] = word[w+=6]
  false[m] = word[w+=6]
}

END{
  # for each round
  for (r = 1; r <= 20; r++) {
    # for each monkey
    for (m = 0; m < length(wl); m++) {
      # if there are items
      while(length(wl[m])) {
        wl1 = wl[m][1]
        # new worry level
        op2n = op2[m] == "old" ? wl1 : op2[m]
        wl1 = op1[m] == "*" ? wl1 * op2n : wl1 + op2n
        # div 3
        wl1 = int(wl1 / 3)
        # test : divisible = true
        if (!(wl1 % div[m]))
          wl[true[m]][length(wl[true[m]])+1] = wl1
        else
          wl[false[m]][length(wl[false[m]])+1] = wl1
        # wish there was car cadr!
        for (i = 2; i<= length(wl[m]); i++)
          wl[m][i-1] = wl[m][i]
        delete wl[m][length(wl[m])]

        insp[m]++
      }
    }
  }
  # for (j = 0; j < length(wl); j++)
  #   print j , insp[j]
  asort(insp, insp2, "@val_num_desc")
  print insp2[1] * insp2[2]
  
}
