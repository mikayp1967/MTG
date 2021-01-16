while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," CFB-prices-*|sed "s/CFB-prices-/     /;s/\:${expansion}\,/ - /"
 done  < ../CM/expansion-list-unsorted
