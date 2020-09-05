while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"
 done  < expansion-list
