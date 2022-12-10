/*

OTHER USER SETUP

*/

--Author: Aditya
--Comments: Script to create SMS Related users
--          Note: Run this script logged in as 'APP_ADMIN' user for Oracle Autonomous Database

--To show the procedure print statements to client
set serveroutput on;


--PROC : setup_sms_user
--Comments: Creates the APP_ADMIN user on the Oracle Database with appropriate roles and privileges assigned
--          APP_ADMIN will create SMS users, db artifacts like tables, procedures, views etc. required for SMS
--          which will be later used by other SMS users like STADIUM_MANAGER, FINANCE_MANAGER, CUSTOMER and STADIUM_SECURITY.
create or replace procedure
setup_sms_users
as
    userCount number;
    currentUser varchar(255);
    e_code number;
    e_msg varchar(255);
begin
    
    dbms_output.put_line('---------------------------');
    dbms_output.put_line('Setting up SMS users');
    dbms_output.put_line('---------------------------');
    
    --STADIUM_MANAGER
    currentUser:='STADIUM_MANAGER';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "OtherUser@12345" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CREATE SESSION to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CREATE SESSION to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
    
    --FINANCE_MANAGER
    currentUser:='FINANCE_MANAGER';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "OtherUser@12345" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CREATE SESSION to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CREATE SESSION to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
    
    --CUSTOMER
    currentUser:='CUSTOMER';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "OtherUser@12345" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CREATE SESSION to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CREATE SESSION to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
    
    
    --STADIUM_SECURITY
    currentUser:='STADIUM_SECURITY';
    dbms_output.put_line('Check if user: '|| currentUser ||' exists already');
    select count(1) into userCount from all_users where username=currentUser;
    if userCount>0
    then 
        dbms_output.put_line('User: '|| currentUser ||' exists already');
        dbms_output.put_line('Dropping and recreating user: '|| currentUser);
        execute immediate 'drop user '|| currentUser ||' cascade';
    end if;
    
    dbms_output.put_line('Trying to create user: '|| currentUser);
    execute immediate 'create user '|| currentUser ||' identified by "OtherUser@12345" default tablespace DATA quota 10m on DATA';
    execute immediate 'grant CREATE SESSION to '|| currentUser;    
    dbms_output.put_line('Created user: '|| currentUser);
    dbms_output.put_line('Granted CREATE SESSION to user: '|| currentUser);
    
    dbms_output.put_line('---------------------------');
    
exception
    when others
    then dbms_output.put_line('Exception Occurred');
    e_code := SQLCODE;
    e_msg := SQLERRM;
    dbms_output.put_line('Error Code: ' || e_code);
    dbms_output.put_line('Error Message: ' || SUBSTR(e_msg, 1, 255)); 
    
    if e_code=-1940
    then
        dbms_output.put_line('---------------------------');
        dbms_output.put_line('Error Reason: TRYING TO CREATE SMS USERS THAT ARE ALREADY CONNECTED TO DB, DISCONNECT THEM AND RUN THE SCRIPT AGAIN');
        dbms_output.put_line('---------------------------');
    end if;
end;
/

--Driver code to setup SMS related users
execute setup_sms_users;
