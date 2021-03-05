while read expansion ;
 do printf "${expansion}\n"
 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|awk 'NR%4==0' > afile
 grep "^${expansion}," data/CM-prices-*|sed "s/data.CM-prices-/     /;s/\:${expansion}\,/ - /"|tail -2 >> afile 
 cat afile|sort|uniq|tail -6

 done  < expansion-list-unsorted
