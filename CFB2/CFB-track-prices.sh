while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," CFB-prices-*|sed "s/CFB-prices-/     /;s/\:${expansion}\,/ - /"|tail -5
 done  < ../CM/expansion-list-unsorted
