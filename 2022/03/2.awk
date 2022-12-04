BEGIN{
  for (i = 65; i <= 90; i++)
    priority[sprintf("%c", i)] = i - 65 + 27
  for (i = 97; i <= 122; i++)
    priority[sprintf("%c", i)] = i - 97 +  1
}

{
  for (i = 1; i<=length($0); i++) 
    comp[((NR-1) % 3)+1][substr($0,i,1)]=1
}

(NR % 3) == 0 {
  for (i in priority)
    if (comp[1][i] && comp[2][i] && comp[3][i])
      tot += priority[i]
  delete comp
}

END{
  print tot
}
