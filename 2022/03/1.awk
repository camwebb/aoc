BEGIN{
  for (i = 65; i <= 90; i++)
    priority[sprintf("%c", i)] = i - 65 + 27
  for (i = 97; i <= 122; i++)
    priority[sprintf("%c", i)] = i - 97 +  1
}

{
  for (i = 1; i<=length($0); i++) 
    comp[int((i-1)/(length($0)/2))+1][substr($0,i,1)]=1
  
  for (i in priority)
    if ((comp[1][i] == 1) && (comp[2][i] == 1))
      tot += priority[i]
  delete comp
}

END{
  print tot
}
