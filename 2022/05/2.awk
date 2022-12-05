$0 ~ /\[/ {
  for (i = 1; i <= length($0); i++)
    if ((i % 4) == 0)
      new = new "|"
    else
      new = new substr($0,i,1)
  gsub(/[][ ]/,"" , new)
  nbin = split(new, vert[++v],"|")
  new = ""
}

$0 ~ /move/ {
  moveN[++m] = $2
  moveF[m]   = $4
  moveT[m]   = $6
}

END{
  # transpose
  for (i = v; i >= 1; i--)
    for (j = 1; j<=nbin; j++)
      if (vert[i][j])
        bin[j][v-i+1] = vert[i][j]
  
  # move
  for (i = 1; i <= m; i++) {
    # moved each crate one-by-one to temp stack
    for (j = 1; j <= moveN[i]; j++) {
      lf = length(bin[moveF[i]])
      # add to top of temp stack
      stack[j] = bin[moveF[i]][lf]
      # delete 1 from top of From
      delete bin[moveF[i]][lf]
    }

    # now move from top of stack to To
    for (j = 1; j <= moveN[i]; j++) {
      lt = length(bin[moveT[i]])
      bin[moveT[i]][lt+1] = stack[moveN[i]-j+1]
    }
    delete stack
  }
  
  for (b = 1; b <= nbin; b++)
    printf "%1s" , bin[b][length(bin[b])]
  printf "\n"
}
