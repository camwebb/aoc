{
  for (i = 4; i <= length($0); i++)
    if ((substr($0,i-3,1) != substr($0,i-2,1)) &&                       \
        (substr($0,i-3,1) != substr($0,i-1,1)) &&                       \
        (substr($0,i-3,1) != substr($0,i  ,1)) &&                         \
        (substr($0,i-2,1) != substr($0,i-1,1)) &&                       \
        (substr($0,i-2,1) != substr($0,i  ,1)) &&                       \
        (substr($0,i-1,1) != substr($0,i  ,1))) {
      print i
      exit 0
    }
}
        
