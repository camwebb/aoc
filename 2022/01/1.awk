(!$0) { elftot = 0 }
($0)  {
  if ((elftot += $0) > maxcal)
    maxcal = elftot
}
END { print maxcal }
