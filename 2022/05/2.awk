$0 ~ /\[/ {
  for (i = 1; i <= length($0); i++)
    if ((i % 4) == 0)
      new = new "|"
    else
      new = new substr($0,i,1)
  gsub(/[][ ]/,"" , new)
  nstack = split(new, vert[++v],"|")
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
    for (j = 1; j<=nstack; j++)
      if (vert[i][j])
        stack[j][v-i+1] = vert[i][j]
  
  # move
  for (i = 1; i <= m; i++) {
    # moved each crate one-by-one to temp stack
    for (j = 1; j <= moveN[i]; j++) {
      lf = length(stack[moveF[i]])
      # add to top of temp stack
      temp[j] = stack[moveF[i]][lf]
      # delete 1 from top of From
      delete stack[moveF[i]][lf]
    }

    # now move from top of temp to To
    for (j = 1; j <= moveN[i]; j++) {
      lt = length(stack[moveT[i]])
      stack[moveT[i]][lt+1] = temp[moveN[i]-j+1]
    }
    delete temp
  }
  
  for (b = 1; b <= nstack; b++)
    printf "%1s" , stack[b][length(stack[b])]
  printf "\n"
}
