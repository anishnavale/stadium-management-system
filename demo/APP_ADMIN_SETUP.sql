/*

APP ADMIN USER SETUP

*/


--Author: Aditya
--Comments: Script to create SMS APP_ADMIN user
--          Note: Run this script logged in as 'ADMIN' user for Oracle Autonomous Database

--To show the procedure print statements to client
set serveroutput on;


--PROC : create_sms_app_admin_user(user_name<varchar>, user_pwd<varchar>, user_quota<number>)
--Comments: Creates the APP_ADMIN user on the Oracle Database with appropriate roles and privileges assigned
--          APP_ADMIN will create SMS users, db artifacts like tables, procedures, views etc. required for SMS
--          which will be later used by other SMS users like STADIUM_MANAGER, FINANCE_MANAGER, CUSTOMER etc.
create or replace procedure
create_sms_app_admin_user(
    user_name IN varchar, 
    user_pwd IN varchar,
    user_quota IN number
)
as
    userCount number;
    e_code number;
    e_msg varchar2(255);
begin

dbms_output.put_line('Inputs to the procedure create_sms_app_admin_user -> (' || user_name || ',' || user_pwd || ','|| user_quota || ')');
dbms_output.put_line('Trying to create APP_ADMIN user on Oracle Autonomous Database...');
dbms_output.put_line('Checking if user already exists...');

select count(1) into userCount from all_users where username=upper(user_name);
if userCount>0 then
    dbms_output.put_line('User: '|| user_name || ' already exists!'); 
    dbms_output.put_line('Dropping and Recreating '||'User: '|| user_name || ' with new supplied password');
    execute immediate 'drop user ' || user_name || ' cascade';
end if;

dbms_output.put_line('Creating User: '|| user_name);
execute immediate 'create user ' || user_name || ' identified by "' || user_pwd || '" default tablespace data quota ' || user_quota ||'m on data';
execute immediate 'GRANT CREATE USER, DROP USER, EXECUTE ANY TYPE, EXECUTE ANY PROCEDURE, ALTER ANY PROCEDURE, CREATE ANY TABLE, UNLIMITED TABLESPACE, DROP ANY TRIGGER, CREATE ANY PROCEDURE, ALTER ANY INDEX, CREATE ANY INDEX, CREATE TABLE, CREATE SESSION , DROP ANY TYPE, CREATE ANY TRIGGER, CREATE SEQUENCE, DROP ANY INDEX, SELECT ANY TABLE, DROP ANY TABLE, CREATE ANY TYPE, ALTER ANY TRIGGER, ALTER ANY SEQUENCE, CREATE ANY SEQUENCE, UPDATE ANY TABLE, CREATE TRIGGER, DROP ANY PROCEDURE, DROP ANY SEQUENCE, CREATE ANY VIEW, DELETE ANY TABLE, INSERT ANY TABLE, ALTER ANY TABLE, READ ANY TABLE, DEBUG CONNECT SESSION, MERGE ANY VIEW, ALTER ANY TYPE, CREATE PROCEDURE, SELECT ANY SEQUENCE, DROP ANY VIEW, CREATE VIEW 
to ' || user_name;

execute immediate 'grant CREATE SESSION to ' || user_name || ' WITH ADMIN OPTION';

dbms_output.put_line('Granted Appropriate Roles and Privileges to '|| user_name);

exception        
    when others then
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
    dbms_output.put_line('---------------------------');
    
    
    if e_code=-1940
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('Error Reason: TRYING TO CREATE APP_ADMIN USER THAT IS ALREADY CONNECTED TO DB, DISCONNECT IT AND RUN THE SCRIPT AGAIN');
        dbms_output.put_line('---------------------------');
    end if;
end;
/

execute create_sms_app_admin_user('APP_ADMIN_TEST', 'AppAdminTest@12345', 100);

