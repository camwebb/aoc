!$0 || NR == 1 { elf++ }
$0             { cals[elf] += $0 }
END {
  asort(cals, ordcal, "@val_num_desc")
  print ordcal[1] + ordcal[2] + ordcal[3]
}
