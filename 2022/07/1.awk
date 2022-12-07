{
  # checked: / only occurs on first line:
  if ($0 ~ /^\$ cd \//)
    # root dir = #1 ; debug: name[1] = "/"
    at = i = 1
  else if ($0 ~ /^\$ cd \.\./)
    at = up[at]
  else if ($0 ~ /^\$ cd/) {
    up[++i] = at
    at = i  # debug: name[i] = $3
  }
  else if ($1 ~ /^[0-9]+$/)
    tot[at] += $1
}

END {
  # add subdir totals
  for (i in up) {
    at = i
    while (at != 1) {
      tot[up[at]] += tot[i]
      at = up[at]
    }
  }

  for (i in tot) {
    if (tot[i] <= 100000)
      sumtot += tot[i]
  }
  print sumtot
}