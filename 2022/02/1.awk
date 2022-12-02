BEGIN{
  # A Rock, B Paper, C Scissors
  # X Rock, Y Paper, Z Scissors
  score["A"]["X"] = 1 + 3 # draw 
  score["A"]["Y"] = 2 + 6 # win
  score["A"]["Z"] = 3 + 0 # lose
  score["B"]["X"] = 1 + 0 # lose 
  score["B"]["Y"] = 2 + 3 # draw
  score["B"]["Z"] = 3 + 6 # win
  score["C"]["X"] = 1 + 6 # win
  score["C"]["Y"] = 2 + 0 # lose
  score["C"]["Z"] = 3 + 3 # draw
  # this winning structure might be generalized with... modulus, or some
  #   other clever alg. But with only three cases, and without spending too much
  #   time, I'll stick with this.
}
{
  # print score[$1][$2]
  tot += score[$1][$2]
}
END{
  print tot
}
  
