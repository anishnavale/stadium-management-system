--Author: Aditya
--Comments: Script to create development users on Oracle Autonomous Database
--          Note: Login as Oracle database user 'ADMIN' to run this script.


--creating 4 development user accounts on Oracle database with 100 MB tablespace limit for each user
create user aditya identified by "Qwerty@123456789"
default tablespace DATA
quota 100m on DATA;

create user anish identified by "Qwerty@123456789"
default tablespace DATA
quota 100m on DATA;

create user sejal identified by "Qwerty@123456789"
default tablespace DATA
quota 100m on DATA;

create user sweta identified by "Qwerty@123456789"
default tablespace DATA
quota 100m on DATA;

--Validation query to check if the development users where created
select * from dba_users where username in ('ADITYA', 'ANISH', 'SEJAL', 'SWETA') order by user_id;