{ split($0,h[NR],"") }

END {
  ny = NR
  nx = length(h[1])

  # for each tree
  for (y = 1; y <= ny; y++) {
    for (x = 1; x <= nx; x++) {

      # look N
      y2 = y - 1
      while (y2 >= 1) {
        dist[y][x]["n"]++
        if (h[y2][x] >= h[y][x])
          break
        y2--
      }
      
      # look S
      y2 = y + 1
      while (y2 <= ny) {
        dist[y][x]["s"]++
        if (h[y2][x] >= h[y][x])
          break
        y2++
      }
      
      # look W
      x2 = x - 1
      while (x2 >= 1) {
        dist[y][x]["w"]++
        if (h[y][x2] >= h[y][x])
          break
        x2--
      }

      # look E
      x2 = x + 1
      while (x2 <= nx) {
        dist[y][x]["e"]++
        if (h[y][x2] >= h[y][x])
          break
        x2++
      }

      score[y][x] = dist[y][x]["n"] * dist[y][x]["s"] * \
        dist[y][x]["w"] * dist[y][x]["e"]

      if (score[y][x] > maxscore)
        maxscore = score[y][x]
    }
  }

  # # visualize
  # for (y = 1; y <= ny; y++) {
  #   for (x = 1; x <= nx; x++) {
  #     printf "%2d ", score[y][x]
  #   }
  #   printf "\n"
  # }
  
  print maxscore
}
