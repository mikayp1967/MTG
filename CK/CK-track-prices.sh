while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," CK-prices-*|sed "s/CK-prices-/     /;s/\:${expansion}\,/ - /"
 done  < ../TCG/expansion-list-unsorted
 #done  < ./expansion-list-unsorted
