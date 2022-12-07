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

  PROCINFO["sorted_in"] = "@val_num_asc"
  for (i in tot)
    if (((70000000 - tot[1]) + tot[i]) > 30000000) {
      print tot[i]
      exit 0
    }
}