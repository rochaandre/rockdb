# rockdb
based on dictionary views of oracle - create nice reports with usefull information

#Beta version
Use by you own risk. Use with only select grant.

+---------------------------------------+
|                 rockdb                |
+---------------------------------------+

rockdb is a "free to use toolset" to perform an parcial assessment of Oracle database or point of interest in Oracle database.

rockdb is made of some independent tools:
-----------------------------------------
rockdb - general dashboard and all outputs and checklist - current version
rockexp - Points of attention to execute export of database -- under development

## Download
Remember this is used for my internal purpose, and I decided to share it with you.
Please test it in a database of demo, before run in production - use by your own.

## Steps

1. Download the tool into target database server
2. Navigate to master directory and connect into SQLPlus as DBA or user with access to data dictionary
   -- this is beta - create a user like below to avoid any issue:

   create user ROCKSCRIPT identified by pass123;
   grant connect,resource, select any dictionary, SELECT_CATALOG_ROLE to ROCKSCRIPT;
   grant execute on dbms_metadata to ROCKSCRIPT;

3. Configure rockdb.sh or rockdb.bat sections ORACLE_HOME PATH:

SET ORACLE_HOME=C:\app\client\Administrador\product\19.0.0\client_1
SET  PATH=C:\app\client\Administrador\product\19.0.0\client_1\bin;%PATH%
or
export ORACLE_HOME=/Users/andre/instantclient_19_8
export PATH=/Users/andre/instantclient_19_8:$PATH


3. Execute rockdb.sh -  the parameters are:

USERID=ROCKSCRIPT  -- DBA ACCOUNT with permisson to select dictionary views
PASSWO=pass123     -- DBA password
CONNST=192.168.0.1:1521/orcl        -- Connection string (easy connection)
EXPDPD=DIREXPDP    -- Directory of regular export/expdp operations (for logical backup)

chmod +x rockdb.sh


to run it:

 ./rockdb.sh ROCKSCRIPT pass123 192.168.0.1:1521/orcl DIREXDP

4. Copy output zip to client (PC or Mac), unzip and open in browser file inside of the folder like:
   Open it using Google Chrome

   instanceversionhostnamedomain/index_instanceversion.html

## Notes

1. rockdb run transparently for oracle databases.
2. Use by your own, please check the file rockdb.bat or rockdb.sh before run it.
3. You can set it to run daily or once by week - with other tools like mutt you can send it by email to distribute the result
4. This script will not create, drop any object - we have only execute procedures, select on views.
5. Be aware - configuration of this PERFORMANCE USAGE internal views - in definecfg.sql to avoid use performance tunning option.
   this will be passed like parameter in a future release.
6. If you want to contribute, please contact - techmaxconsultoria@gmail.com


## Add it to Crontab

###############################################################
# REPORT and monitoring
###############################################################
30 12 * * 1 /stage/rockdb/report/rockdb.sh XE
00 07 * * * /stage/rockdb/report/script/emailbkp.sh XE

## Create your own configuration files, avoid on update replace your configuration.
/stage/scripts/define.sh
/stage/scripts/definecfg.sql



## Troubleshooting

This is the first release. For more details please check www.soudba.com.br
You can reduce the scope of rockdb scripts - this means you can adapt for your personal use only.

## Contacts

For questions, feedbacks or issues please contact techmaxconsultoria@gmail.com

## License

  rockdb - An open-source tool to diagnose Oracle Databases and SQL
  statements - originally developed by Andre Rocha.

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
