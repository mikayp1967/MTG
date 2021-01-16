while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," TCG-prices-*|sed "s/TCG-prices-/     /;s/\:${expansion}\,/ - /"|tail -5
 done  < expansion-list-unsorted
