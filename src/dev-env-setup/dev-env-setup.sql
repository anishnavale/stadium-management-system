--Author: Aditya
--Comments: Script to create development users on Oracle Autonomous Database
--          Note: Login as Oracle database user 'ADMIN' to run this script.

--To show the procedure print statements to client
set serveroutput on;


--PROC : create_dev_user(user_name<varchar>, user_pwd<varchar>, user_quota<number>)
--Comments: Creates the development users on the Oracle Database with appropriate roles and privileges assigned
create or replace procedure
create_dev_user(
    user_name IN varchar, 
    user_pwd IN varchar,
    user_quota IN number
)
as
    userCount number;
    e_code number;
    e_msg varchar2(255);
begin
dbms_output.put_line('Inputs to the procedure create_dev_user -> (' || user_name || ',' || user_pwd || ','|| user_quota || ')');
dbms_output.put_line('Trying to create dev users on Oracle Autonomous Database..');
dbms_output.put_line('Checking if user already exists...');

select count(1) into userCount from dba_users where username=upper(user_name);
if userCount>0 then
    dbms_output.put_line('User: '|| user_name || ' already exists!'); 
    dbms_output.put_line('Dropping and Recreating '||'User: '|| user_name || ' with new supplied password');
    execute immediate 'drop user ' || user_name;
end if;

dbms_output.put_line('Creating User: '|| user_name);
execute immediate 'create user ' || user_name || ' identified by "' || user_pwd || '" default tablespace data quota ' || user_quota ||'m on data';
execute immediate 'grant CONNECT, RESOURCE, CREATE VIEW to '||user_name;
dbms_output.put_line('Granted Roles and Privileges: CONNECT, RESOURCE, CREATE VIEW to '|| user_name);

exception
    when others then
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255));
end;
/


--Driver code to create the dev users
execute create_dev_user('aditya', 'Gend@1234567890123_old', 100);
execute create_dev_user('anish', 'Gend@1234567890123_old', 100);
execute create_dev_user('sejal', 'Gend@1234567890123_old', 100);
execute create_dev_user('sweta', 'Gend@1234567890123_old', 100);

