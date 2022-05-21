{
  l = split($0,x,"")
  for (i = 1; i <= l; i++)
    n[i]+=x[i]
  r++
}
END {
  for (i = 1; i <= l; i++) {
    c = int((n[i]/r)+0.5)
    e +=  c * (2^(l-i))
    g += !c * (2^(l-i))
  }
  print e, g, e*g
}
  
