

source report/cfg/define.sh

. oraenv <<<$1

sqlplus  $USERID/$PASSWO@$CONNST <<EOF
@report/sql/definecfg.sql
PRO  &var_outputfolder
@report/list/list_rmanbkp01.sql
@report/list/list_rman_backupspfile01.sql
@report/list/list_rman_backupsize01.sql
@report/list/list_rman_backupset01.sql
@report/list/list_rman_backuppiece01.sql
@report/list/list_rman_backupjob01.sql
@report/sql/generate_rman_menu01.sql
@report/sql/creatermansendemail01.sql
host chmod +x &var_outputfolder/creatermansendemail01.sh
host &var_outputfolder/creatermansendemail01.sh
EOF
