# gawk -v N=4  -f 2.awk in
# gawk -v N=14 -f 2.awk in

{
  for (i = N; i <= length($0); i++) {
    same = 0
    for (j = N-1; j >= 1; j--)
      for (k = j-1; k >= 0; k--)
        if (substr($0,i-j,1) == substr($0,i-k,1)) {
          same =1
          break
        }
    if (!same) {
      print i
      exit 0
    }
  }
}
     
