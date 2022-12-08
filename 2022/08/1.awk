{ split($0,h[NR],"") }

END {
  ny = NR
  nx = length(h[1])

  # tricky to generalize these as a function... 
  # view from W
  for (y = 1; y <= ny; y++) {
    tallest = -1
    for (x = 1; x <= nx; x++)
      if (h[y][x] > tallest) {
        v[y][x] = 1
        tallest = h[y][x]
      }
  }
  
  # view from E
  for (y = 1; y <= ny; y++) {
    tallest = -1
    for (x = nx; x >= 1; x--)
      if (h[y][x] > tallest) {
        v[y][x] = 1
        tallest = h[y][x]
      }
  }
  
  # view from N
  for (x = 1; x <= nx; x++) {
    tallest = -1
    for (y = 1; y <= ny; y++)
      if (h[y][x] > tallest) {
        v[y][x] = 1
        tallest = h[y][x]
      }
  }

  # view from S
  for (x = 1; x <= nx; x++) {
    tallest = -1
    for (y = ny; y >= 1; y--)
      if (h[y][x] > tallest) {
        v[y][x] = 1
        tallest = h[y][x]
      }
  }

  # summarize
  for (y = 1; y <= ny; y++) {
    for (x = 1; x <= nx; x++) {
      # printf "%1d", v[y][x]
      totvis += v[y][x]
    }
    # printf "\n"
  }
  print totvis
}
