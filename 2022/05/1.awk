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
    # for each create moved
    for (j = 1; j <= moveN[i]; j++) {
      lt = length(bin[moveT[i]])
      lf = length(bin[moveF[i]])
      # add to top of To
      bin[moveT[i]][lt+1] = bin[moveF[i]][lf]
      # delete 1 from top of From
      delete bin[moveF[i]][lf]
    }
  }
  
  for (b = 1; b <= nbin; b++)
    printf "%1s" , bin[b][length(bin[b])]
  printf "\n"
}
