while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," CM-prices-*|sed "s/CM-prices-/     /;s/\:${expansion}\,/ - /"
 done  < expansion-list
