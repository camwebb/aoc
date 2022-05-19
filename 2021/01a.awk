NR == 1 { l = $0 }
NR >  1 { if($0 > l) i++; l=$0 }
END     { print i }

# NR==1{l=$0}NR>1{if($0>l)i++;l=$0}END{print i} # = 45 char


# Nicer: https://github.com/phillbush/aoc/blob/master/2021/day01a
#
# NR > 1 && $0 > a { n++     }
#                  { a = $0  }
# END              { print n }
#
# NR>1&&$0>a{n++}{a=$0}END{print n} # = 33 char
