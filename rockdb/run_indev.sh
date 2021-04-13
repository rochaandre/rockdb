#+-----------------------------------------------------------------+
#| Parameters                                                      |
#+-----------------------------------------------------------------+
USERID=$1
PASSWO=$2
CONNST=$3
EXPDPD=$4

# 11g
USERID=dbaxx
PASSWO=dbaxx
CONNST=192.168.1.xx:1521/xx
EXPDPD=DIREXPDP

# 12c
#USERID=admin
#PASSWO=MinhaSenha123
#CONNST=orcl_high
#EXPDPD=DIREXPDP

#+-----------------------------------------------------------------+
#| Define                                                         |
#+-----------------------------------------------------------------+
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/sql/definecfg.sql
EOF


#+-----------------------------------------------------------------+
#| Info DB                                                         |
#+-----------------------------------------------------------------+
#
sqlplus $USERID/$PASSWO@$CONNST <<EOF

@report/list/dbinfo01.sql
@report/list/dbinfo02.sql
EOF

#+-----------------------------------------------------------------+
#| General                                                         |
#+-----------------------------------------------------------------+
#
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/list/listarchivehour.sql
@report/list/listinvalidobjects.sql
@report/list/listoutstandalerts.sql
@report/list/listrmanbkp.sql
@report/bar/bararchiveperday.sql
EOF


#+-----------------------------------------------------------------+
#| Listar o backup                                                 |
#+-----------------------------------------------------------------+

echo "report need backup; "       > report/rman/rman_report.rcv
echo "report schema;           " >> report/rman/rman_report.rcv
echo "list backup of database; " >> report/rman/rman_report.rcv
echo "list backup summary; "     >> report/rman/rman_report.rcv

rman target $USERID/$PASSWO@$CONNST log=html/dbinfo_rman_report02.html cmdfile=report/rman/rman_report.rcv

#+-----------------------------------------------------------------+
#| Listar expdp backup do banco - Gerar a partir do directory      |
#+-----------------------------------------------------------------+

# Listar backup expdp

sqlplus $USERID/$PASSWO@$CONNST @report/expdp/dbinfo_expdp_list01.sql $DIREXPDP

chmod +x report/script/dbinfo_expdp_list01.sh
report/script/dbinfo_expdp_list01.sh

#+-----------------------------------------------------------------+
#| Gerar informacao do Gauge Dashboard                             |
#+-----------------------------------------------------------------+
#
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/gauge/dbgauges01.sql
@report/gauge/dbgauges02.sql
@report/gauge/dbgauges04.sql
@report/gauge/dbgauges03.sql
@report/gauge/dbgauges05.sql
@report/gauge/dbgauges06.sql
@report/gauge/dbgauges07.sql
@report/gauge/dbgauges08.sql
@report/gauge/dbgauges09.sql
@report/gauge/dbgauges10.sql
EOF

#+-----------------------------------------------------------------+
#| Tablespace                                                      |
#+-----------------------------------------------------------------+
#
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/list/dbinfo_physical_control01.sql
@report/list/dbinfo_physical_redo01.sql
EOF

sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/list/dbinfo_physical_datafile01_12c.sql
@report/list/dbinfo_physical_tempfile01_12c.sql
@report/sql/generatecalltablespace_12c.sql
EOF

sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/list/dbinfo_physical_datafile01_11g.sql
@report/list/dbinfo_physical_tempfile01_11g.sql
@report/sql/generatecalltablespace_11g.sql
EOF

#+-----------------------------------------------------------------+
#| Pie                                                             |
#+-----------------------------------------------------------------+
#
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/pie/dbpie_index_invalid01.sql
@report/pie/dbpie_large_pool01.sql
@report/pie/dbpie_object_invalid01.sql
@report/pie/dbpie_object_schema01.sql
@report/pie/dbpie_object_types01.sql
@report/pie/dbpie_shared_pool01.sql
@report/pie/dbpie_sga_pool01.sql
EOF


#+-----------------------------------------------------------------+
#| RMAN                                                            |
#+-----------------------------------------------------------------+
#
sqlplus $USERID/$PASSWO@$CONNST <<EOF
@report/list/dbinfo_rman_report01.sql
@report/list/dbinfo_rman_report02.sql
EOF


#+-----------------------------------------------------------------+
#| Operation System                                                |
#+-----------------------------------------------------------------+
#
echo "+------------------------------------------------------------------------------------------------+" > html/output_filesystem_report01.html
echo "|                                      Filesystem                                                |">> html/output_filesystem_report01.html
echo "+------------------------------------------------------------------------------------------------+">> html/output_filesystem_report01.html
df -h >> html/output_filesystem_report01.html
echo "+------------------------------------------------------------------------------------------------+">  html/output_memory_report01.html
echo "|                                      Memory                                                    |">> html/output_memory_report01.html
echo "+------------------------------------------------------------------------------------------------+">> html/output_memory_report01.html
free -m >> html/output_memory_report01.html
echo "+------------------------------------------------------------------------------------------------+">  html/output_network_report01.html
echo "|                                      network                                                   |">> html/output_network_report01.html
echo "+------------------------------------------------------------------------------------------------+">> html/output_network_report01.html
ifconfig -a >> html/output_network_report01.html
