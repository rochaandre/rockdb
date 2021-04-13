SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 1000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON
SET TERM OFF HEA OFF LIN 32767 NEWP NONE PAGES 0 FEED OFF ECHO OFF VER OFF LONG 32000 LONGC 2000 WRA ON TRIMS ON TRIM ON TI OFF TIMI OFF ARRAY 100 NUM 20 SQLBL ON BLO . RECSEP OFF;
SPO &var_outputfolder/&vhtmlpage&var_namefile

@rockdb/sql/headerdoc.sql &var_outputfolder/&vhtmlpage&var_namefile "&vtitlethispage" "" "" ""


PRO <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
PRO <html xmlns="http://www.w3.org/1999/xhtml">
PRO <!-- $Header:  $ -->
PRO <!-- rock_copyright (c) 2021, All rights reserved. -->
PRO <!-- Author: techmaxconsultoria@gmail.com -->


PRO <head>
PRO <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
PRO <link rel="icon" href="icon/&viconthispage" type="image/x-icon" />
PRO <title>&vtitlethispage</title>
PRO <style type="text/css">
PRO body             {font:10pt Arial,Helvetica,Geneva,sans-serif; color:black; background:white;}
PRO h1               {font-size:16pt; font-weight:bold; color:#336699; border-bottom:5px solid #336699; margin-top:0pt; margin-bottom:0pt; padding:0px 0px 0px 0px;}
PRO h2               {font-size:14pt; font-weight:bold; color:#336699; margin-top:4pt; margin-bottom:0pt;}
PRO h3               {font-size:12pt; font-weight:bold; color:#336699; margin-top:4pt; margin-bottom:0pt;}
PRO pre              {font:8pt monospace,Monaco,"Courier New",Courier;}
PRO a                {color:#663300;}
PRO table            {font-size:8pt; border-collapse:collapse; empty-cells:show; white-space:nowrap; border:1px solid #336699;}
PRO li               {font-size:8pt; color:black; padding-left:4px; padding-right:4px; padding-bottom:2px;}
PRO th               {font-weight:bold; color:red; background:#0066CC; padding-left:4px; padding-right:4px; padding-bottom:2px;}
PRO tr               {color:black; background:white;}
PRO tr:hover         {color:white; background:#0066CC;}
PRO tr.main          {color:black; background:white;}
PRO tr.main:hover    {color:black; background:white;}
PRO td               {vertical-align:top; border:1px solid #336699;}
PRO td.c             {text-align:center;}
PRO font.n           {font-size:8pt; font-style:italic; color:#336699;}
PRO font.f           {font-size:8pt; color:#999999; border-top:1px solid #336699; margin-top:30pt;}
PRO div.google-chart {width:809px; height:500px;}
PRO </style>
PRO </head>
PRO
PRO <h1> <a href="&vmainfile" target="_blank"><img src="icon/&viconthispage" alt="&vmainfile" height="33" width="52" /></a> &var_namefile <em>(&vtitlethispage)</em>  </h1>
