#!/bin/bash
echo "cleaning ${1}.sql from different incompatible with public hosting like azure things" 
sed -e 's/DEFINER[ ]*=[ ]*[^*]*\*/\*/' ../database/backups/${1}.sql | sed -e 's/DEFINER[ ]*=[ ]*[^*]*PROCEDURE/PROCEDURE/' | sed -e 's/DEFINER[ ]*=[ ]*[^*]*FUNCTION/FUNCTION/' > ../database/backups/tmp.sql
sed -i 's/MyISAM/InnoDB/g' ../database/backups/tmp.sql
mv ../database/backups/tmp.sql ../database/backups/${1}.sql
