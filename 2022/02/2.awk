BEGIN{
  # 1. Determine choice
  # A Rock, B Paper, C Scissors <- they play
  # X Lose, Y Draw, Z Win       <- need to...
  strat["A"]["X"] = "Z" # lose
  strat["A"]["Y"] = "X" # draw
  strat["A"]["Z"] = "Y" # win
  strat["B"]["X"] = "X" # lose 
  strat["B"]["Y"] = "Y" # draw
  strat["B"]["Z"] = "Z" # win
  strat["C"]["X"] = "Y" # lose
  strat["C"]["Y"] = "Z" # draw
  strat["C"]["Z"] = "X" # win
  
  # 2. Scoring
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
}
{
  # print "plays: " strat[$1][$2] ". score: " score[$1][strat[$1][$2]]
  tot += score[$1][strat[$1][$2]]
}
END{
  print tot
}
  
