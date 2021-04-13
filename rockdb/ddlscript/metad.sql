-- Name : metad.sql

prompt
prompt returns DDL for creating a database object
prompt
-- Date last modified : 2015/09/29
-- Oracle Version: 11g
-- Other Oracle versions: should work on all current versions

----------------------------------------------------------------------------------------

set long 1000000
set feed off
set head off

prompt
prompt Object Types:
prompt

prompt ASSOCIATION; AUDIT; AUDIT_OBJ; CLUSTER; COMMENT; CONSTRAINT; CONTEXT; DB_LINK; DEFAULT_ROLE; DIMENSION;
prompt DIRECTORY; FUNCTION; INDEX; INDEXTYPE; JAVA_SOURCE; LIBRARY; MATERIALIZED_VIEW; MATERIALIZED_VIEW_LOG;
prompt OBJECT_GRANT; OPERATOR; OUTLINE; PACKAGE; PACKAGE_SPEC; PACKAGE_BODY; PROCEDURE; PROFILE; PROXY; REF_CONSTRAINT;
prompt ROLE; ROLE_GRANT; ROLLBACK_SEGMENT; SEQUENCE; SYNONYM; SYSTEM_GRANT; TABLE; TABLESPACE; TABLESPACE_QUOTA; TRIGGER;
prompt TRUSTED_DB_LINK; TYPE; TYPE_SPEC; TYPE_BODY; USER; VIEW; XMLSCHEMA

col user_t new_value user_s noprint
select user user_t from dual;

accept x_owner prompt "Owner [user]: " default '&user_s'
accept x_type  prompt "Object type [TABLE]: " default 'TABLE'
accept x_name  prompt "Name: "

col "Metadata" for a250

spool metad.rpt

select decode( upper( '&x_type' ),
               'USER', dbms_metadata.get_ddl( upper( '&x_type' ), upper( '&x_name' ) ),
               'PROFILE', dbms_metadata.get_ddl( upper( '&x_type' ), upper( '&x_name' ) ),
               -- default:
               dbms_metadata.get_ddl( upper( '&x_type' ), upper( '&x_name' ), upper( '&x_owner' ) )
             ) "Metadata"
from dual;

spool off

set long 10000
